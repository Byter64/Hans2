/* Updated SD Card controller module with SDHC support and correct write response handling */

`timescale 1ns / 1ps

module sd_controller(
    output reg cs, // Connect to SD_DAT[3].
    output mosi,   // Connect to SD_CMD.
    input miso,    // Connect to SD_DAT[0].
    output sclk,   // Connect to SD_SCK.

    input rd,
    output reg [7:0] dout,
    output reg byte_available,

    input wr,
    input [7:0] din,
    output reg ready_for_next_byte,

    input reset,
    output ready,
    input [31:0] address,
    input clk,  // 50 MHz clock
    output [4:0] status
);

    // Clock divider for 400kHz during init
    reg [6:0] clk_div_counter = 0;
    reg clk_400khz_en = 0;

    always @(posedge clk) begin
        if (clk_div_counter == 62) begin
            clk_div_counter <= 0;
            clk_400khz_en <= 1;
        end else begin
            clk_div_counter <= clk_div_counter + 1;
            clk_400khz_en <= 0;
        end
    end
    
        // Clock divider for 400kHz during init
    logic clk_25mhz_en = 0;

    always @(posedge clk) begin
        clk_25mhz_en <= ~clk_25mhz_en;
    end

    logic is_initialized = 0;
    logic mul_clk;
    assign mul_clk = is_initialized ? clk_25mhz_en : clk_400khz_en;

    parameter RST = 0;
    parameter INIT = 1;
    parameter CMD0 = 2;
    parameter CMD8 = 3;
    parameter CMD8_RESP = 4;
    parameter CMD55 = 5;
    parameter CMD41 = 6;
    parameter POLL_CMD = 7;
    parameter IDLE = 8;
    parameter READ_BLOCK = 9;
    parameter READ_BLOCK_WAIT = 10;
    parameter READ_BLOCK_DATA = 11;
    parameter READ_BLOCK_CRC = 12;
    parameter SEND_CMD = 13;
    parameter RECEIVE_BYTE_WAIT = 14;
    parameter RECEIVE_BYTE = 15;
    parameter WRITE_BLOCK_CMD = 16;
    parameter WRITE_BLOCK_INIT = 17;
    parameter WRITE_BLOCK_DATA = 18;
    parameter WRITE_BLOCK_BYTE = 19;
    parameter WRITE_BLOCK_RESP = 20;
    parameter WRITE_BLOCK_WAIT = 21;

    parameter WRITE_DATA_SIZE = 515;

    reg [4:0] state = RST;
    assign status = state;
    reg [4:0] return_state;
    reg sclk_sig = 0;
    reg [55:0] cmd_out;
    reg [7:0] recv_data;
    reg cmd_mode = 1;
    reg [7:0] data_sig = 8'hFF;

    reg [9:0] byte_counter;
    reg [9:0] bit_counter;
    reg [26:0] boot_counter = 27'd10_000_000;
    reg [31:0] sector_address;

    always @(posedge mul_clk) begin
        if (reset == 1) begin
            state <= RST;
            sclk_sig <= 0;
            boot_counter <= 27'd10_000_000;
            is_initialized <= 0;
        end else begin
            case (state)
                RST: begin
                    if (boot_counter == 0) begin
                        sclk_sig <= 0;
                        cmd_out <= {56{1'b1}};
                        byte_counter <= 0;
                        byte_available <= 0;
                        ready_for_next_byte <= 0;
                        cmd_mode <= 1;
                        bit_counter <= 160;
                        cs <= 1;
                        state <= INIT;
                    end else begin
                        boot_counter <= boot_counter - 1;
                    end
                end
                INIT: begin
                    if (bit_counter == 0) begin
                        cs <= 0;
                        state <= CMD0;
                    end else begin
                        bit_counter <= bit_counter - 1;
                        sclk_sig <= ~sclk_sig;
                    end
                end
                CMD0: begin
                    cmd_out <= 56'hFF_40_00_00_00_00_95;
                    bit_counter <= 55;
                    return_state <= CMD8;
                    state <= SEND_CMD;
                end
                CMD8: begin
                    cmd_out <= 56'hFF_48_00_00_01_AA_87;
                    bit_counter <= 55;
                    return_state <= CMD8_RESP;
                    state <= SEND_CMD;
                end
                CMD8_RESP: begin
                    state <= CMD55;
                end
                CMD55: begin
                    cmd_out <= 56'hFF_77_00_00_00_00_01;
                    bit_counter <= 55;
                    return_state <= CMD41;
                    state <= SEND_CMD;
                end
                CMD41: begin
                    cmd_out <= 56'hFF_69_40_00_00_00_01;
                    bit_counter <= 55;
                    return_state <= POLL_CMD;
                    state <= SEND_CMD;
                end
                POLL_CMD: begin
                    if (recv_data[0] == 0) begin
                        state <= IDLE;
                    end else begin
                        state <= CMD55;
                    end
                end
                IDLE: begin
                    is_initialized <= 1;
                    if (rd || wr) sector_address <= address >> 9;
                    if (rd == 1) begin
                        state <= READ_BLOCK;
                    end else if (wr == 1) begin
                        state <= WRITE_BLOCK_CMD;
                    end else begin
                        state <= IDLE;
                    end
                end
                READ_BLOCK: begin
                    cmd_out <= {8'hFF, 8'h51,
                                sector_address[31:24], sector_address[23:16],
                                sector_address[15:8], sector_address[7:0], 8'hFF};
                    bit_counter <= 55;
                    return_state <= READ_BLOCK_WAIT;
                    state <= SEND_CMD;
                end
                READ_BLOCK_WAIT: begin
                    if (sclk_sig == 1 && miso == 0) begin
                        byte_counter <= 511;
                        bit_counter <= 7;
                        return_state <= READ_BLOCK_DATA;
                        state <= RECEIVE_BYTE;
                    end
                    sclk_sig <= ~sclk_sig;
                end
                READ_BLOCK_DATA: begin
                    dout <= recv_data;
                    byte_available <= 1;
                    if (byte_counter == 0) begin
                        bit_counter <= 7;
                        return_state <= READ_BLOCK_CRC;
                        state <= RECEIVE_BYTE;
                    end else begin
                        byte_counter <= byte_counter - 1;
                        return_state <= READ_BLOCK_DATA;
                        bit_counter <= 7;
                        state <= RECEIVE_BYTE;
                    end
                end
                READ_BLOCK_CRC: begin
                    bit_counter <= 7;
                    return_state <= IDLE;
                    state <= RECEIVE_BYTE;
                end
                SEND_CMD: begin
                    if (sclk_sig == 1) begin
                        if (bit_counter == 0) begin
                            state <= RECEIVE_BYTE_WAIT;
                        end else begin
                            bit_counter <= bit_counter - 1;
                            cmd_out <= {cmd_out[54:0], 1'b1};
                        end
                    end
                    sclk_sig <= ~sclk_sig;
                end
                RECEIVE_BYTE_WAIT: begin
                    if (sclk_sig == 1) begin
                        if (miso == 0) begin
                            recv_data <= 0;
                            bit_counter <= 6;
                            state <= RECEIVE_BYTE;
                        end
                    end
                    sclk_sig <= ~sclk_sig;
                end
                RECEIVE_BYTE: begin
                    byte_available <= 0;
                    if (sclk_sig == 1) begin
                        recv_data <= {recv_data[6:0], miso};
                        if (bit_counter == 0) begin
                            state <= return_state;
                        end else begin
                            bit_counter <= bit_counter - 1;
                        end
                    end
                    sclk_sig <= ~sclk_sig;
                end
                WRITE_BLOCK_CMD: begin
                    cmd_out <= {8'hFF, 8'h58,
                                sector_address[31:24], sector_address[23:16],
                                sector_address[15:8], sector_address[7:0], 8'hFF};
                    bit_counter <= 55;
                    return_state <= WRITE_BLOCK_INIT;
                    state <= SEND_CMD;
                    ready_for_next_byte <= 1;
                end
                WRITE_BLOCK_INIT: begin
                    cmd_mode <= 0;
                    byte_counter <= WRITE_DATA_SIZE;
                    state <= WRITE_BLOCK_DATA;
                    ready_for_next_byte <= 0;
                end
                WRITE_BLOCK_DATA: begin
                    if (byte_counter == 0) begin
                        bit_counter <= 7;
                        return_state <= WRITE_BLOCK_RESP;
                        state <= RECEIVE_BYTE;
                    end else begin
                        if ((byte_counter == 2) || (byte_counter == 1)) begin
                            data_sig <= 8'hFF;
                        end else if (byte_counter == WRITE_DATA_SIZE) begin
                            data_sig <= 8'hFE;
                        end else begin
                            data_sig <= din;
                            ready_for_next_byte <= 1;
                        end
                        bit_counter <= 7;
                        state <= WRITE_BLOCK_BYTE;
                        byte_counter <= byte_counter - 1;
                    end
                end
                WRITE_BLOCK_BYTE: begin
                    if (sclk_sig == 1) begin
                        if (bit_counter == 0) begin
                            state <= WRITE_BLOCK_DATA;
                            ready_for_next_byte <= 0;
                        end else begin
                            data_sig <= {data_sig[6:0], 1'b1};
                            bit_counter <= bit_counter - 1;
                        end
                    end
                    sclk_sig <= ~sclk_sig;
                end
                WRITE_BLOCK_RESP: begin
                    if ((recv_data[4:0] == 5'b00101)) begin // 0x05 = Data accepted
                        state <= WRITE_BLOCK_WAIT;
                    end else begin
                        state <= IDLE; // Error: treat as write failure
                    end
                end
                WRITE_BLOCK_WAIT: begin
                    if (sclk_sig == 1) begin
                        if (miso == 1) begin
                            state <= IDLE;
                            cmd_mode <= 1;
                        end
                    end
                    sclk_sig <= ~sclk_sig;
                end
            endcase
        end
    end

    assign sclk = sclk_sig;
    assign mosi = cmd_mode ? cmd_out[55] : data_sig[7];
    assign ready = (state == IDLE);
endmodule