module sd_card_reader (
    input logic clk,
    input logic rst,

    input logic read_data, //Read operation, one time high
    output logic [7:0] data_out, //Data stored in the fifo
    //SD_controller
    input logic miso, // Connect to SD_DAT[0].
    output logic sclk, // Connect to SD_SCK.
    output logic cs, // Connect to SD_DAT[3].
    output logic mosi // Connect to SD_CMD.
                // For SPI mode, SD_DAT[2] and SD_DAT[1] should be held HIGH. 
                // SD_RESET should be held LOW.
);
///////////////////////////////////////////////////////////////////////

    localparam QUEUE_SIZE = 2048;
    // states of Controller
    logic state = IDLE;
    localparam IDLE = 0;
    localparam BYTES = 1;

    // SD CARD INPUTS/OUTPUTS
    logic rd = 0; // Read signal for SD card
    logic [7:0] dout; // data output for read operation
    logic byte_available; // byte can be read
    logic ready;
    logic [31:0] address = 0;
    logic [31:0] sector_address;
    assign sector_address = address<<9;
    logic egal;
    logic [4:0] egal2;
    
    logic [8:0] byteZaehler = 0;
    
    logic fifo_full;
    logic fifo_empty;
    logic [31:0] count;

    fifo #(
    .DATA_WIDTH(8),
    .MAX_QUEUE_SIZE(QUEUE_SIZE)
    )queue(
    .clk(clk),
    .rst(rst),
    .enqueue(byte_available),
    .dequeue(read_data),
    .data_in(dout),
    .data_out(data_out),
    .empty(fifo_empty),
    .full(fifo_full),
    .queue_size(count)
);

    // Connections to sdcontroller
    sd_controller sd1 (
        .cs(cs),
        .mosi(mosi),
        .miso(miso),
        .sclk(sclk),
        .rd(rd),
        .dout(dout),
        .byte_available(byte_available),
        .wr(1'b0),
        .din(8'b0),
        .ready_for_next_byte(egal),
        .reset(rst),
        .ready(ready),
        .address(sector_address),
        .clk(clk),
        .status(egal2)
    );

    always_ff @(posedge clk) begin
        if(state == IDLE) begin
          byteZaehler <= 0;
          if(count < QUEUE_SIZE-512 && ready) begin
            state <= BYTES;
            rd <= 1;
          end
        end else begin
          if(byte_available) begin
            byteZaehler <= byteZaehler + 1;
          end
          if(byteZaehler>=9'b100) begin
            rd <= 0;
            state <= IDLE;
            address <= address + 1;
          end
        end
        if (rst) begin
          address <= 0;
          state <= IDLE;
          rd <= 0;
          byteZaehler <= 0;
        end 
    end

endmodule

