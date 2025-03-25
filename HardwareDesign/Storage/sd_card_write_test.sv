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
        .out0_hz(80000000)
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
    typedef enum logic [1:0] {IDLE, WRITE, DONE} state_t;
    state_t state = IDLE;

    logic [9:0] byte_counter = -1; // Counter to track bytes written (0 to 511)
    logic old_ready_for_next_byte;

    logic [7:0] data_in = -1;

    assign din = data_in;
    
    always_ff @(posedge clk) begin
        old_ready_for_next_byte <= ready_for_next_byte;
        case (state)
            IDLE: begin
                if (ready) begin
                    address <= 32'h00000000; // Start address (first sector)
                    wr <= 1'b1; // Start write operation
                    state <= WRITE;
                end
            end

            WRITE: begin
                if (ready_for_next_byte && ~old_ready_for_next_byte) begin
                    byte_counter <= byte_counter + 1;
                    data_in <= data_in + 1;
                    wr <= 1'b0;
                    if (byte_counter == 10'd511) begin // After 512 bytes, stop
                        state <= DONE;
                    end
                end
            end

            DONE: begin
                // Write operation complete
                // Do nothing, or add additional logic if needed
            end
        endcase
    end


endmodule