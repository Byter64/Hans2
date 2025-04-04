module sd_card_write_test (
    input logic clk_25mhz,          // 25 MHz clock input
    // SD card interface
    output logic sd_cmd,            // MOSI (CMD pin of SD card)
    output logic sd_clk,            // Clock (SCK pin of SD card)
    inout logic [3:0] sd_d          // MISO (D0-D3 pins of SD card)
);

    logic clk;

    ecp5pll
    #(
        .in_hz(25000000),
        .out0_hz(40000000)
    )
    ecp5pll_inst
    (
        .clk_i(clk_25mhz),
        .clk_o(clk)
    );

    // Internal signals for sd_controller
    logic cs;
    logic mosi;
    logic miso;
    logic sclk;
    logic rd;
    logic [7:0] dout;
    logic byte_available;
    logic wr;
    logic [7:0] din;
    logic ready_for_next_byte;
    logic reset = 0;
    logic ready;
    logic [31:0] address;
    logic [4:0] status;

    // Instantiate the sd_controller
    sd_controller sd_controller_inst (
        .cs(cs),
        .mosi(mosi),
        .miso(miso),
        .sclk(sclk),
        .rd(rd),
        .dout(dout),
        .byte_available(byte_available),
        .wr(wr),
        .din(din),
        .ready_for_next_byte(ready_for_next_byte),
        .reset(reset),
        .ready(ready),
        .address(address),
        .clk(clk),
        .status(status)
    );

    // Connect SD card signals
    assign sd_cmd = mosi;
    assign sd_clk = sclk;
    assign sd_d[0] = miso;
    assign sd_d[3] = cs;
    assign sd_d[2] = 1'b1; // Hold HIGH for SPI mode
    assign sd_d[1] = 1'b1; // Hold HIGH for SPI mode

    // State machine to control the write operation
    typedef enum logic [2:0] {IDLE, INIT_WRITE, WRITE, WAIT_WRITE, NEXT_SECTOR, DONE} state_t;
    state_t state = IDLE;

    logic [8:0] byte_counter = 9'd0;  // Counts bytes per sector
    logic [7:0] data_in = 8'h00;      // Data to write
    logic [7:0] sector = 8'h00;       // Sector counter
    logic old_ready_for_next_byte;

    assign din = data_in;
    
    always_ff @(posedge clk) begin
        old_ready_for_next_byte <= ready_for_next_byte;

        case (state)
            IDLE: begin
                if (ready) begin
                    address <= 32'h00000000; // Start writing at sector 0
                    wr <= 1'b1;              // Begin writing
                    state <= INIT_WRITE;
                end
            end

            INIT_WRITE: begin
                wr <= 1'b0;  // Lower wr after starting
                byte_counter <= 0;
                state <= WRITE;
            end

            WRITE: begin
                if (ready_for_next_byte && ~old_ready_for_next_byte) begin
                    data_in <= data_in - 8'h01; // Increment data
                    byte_counter <= byte_counter + 1;
                    wr <= 1'b0;

                    if (byte_counter == 9'd511) begin
                        state <= WAIT_WRITE;
                    end
                end
            end

            WAIT_WRITE: begin
                if (ready) begin
                    wr <= 1'b1; // Start next sector write
                    state <= NEXT_SECTOR;
                end
            end

            NEXT_SECTOR: begin
                wr <= 1'b0;  // Lower write signal
                sector <= sector + 1;
                address <= address + 32'h200;  // Increment sector
                data_in <= 8'h00;            // Reset data per sector
                byte_counter <= 0;

                if (sector >= 10) begin
                    state <= DONE;
                end else begin
                    state <= WRITE;
                end
            end

            DONE: begin
                wr <= 1'b0; // Stop writing
            end
        endcase
    end

endmodule
