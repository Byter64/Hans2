module sd_card_test (
    input logic clk_25mhz,          // 25 MHz clock input
    input logic [6:0] btn,
    output logic [7:0] led,

    // SD card interface
    output logic sd_cmd,            // MOSI (CMD pin of SD card)
    output logic sd_clk,            // Clock (SCK pin of SD card)
    output logic [3:0] audio_l,
    output logic [3:0] audio_r,
    inout logic [3:0] sd_d          // MISO (D0-D3 pins of SD card)
);
// SD card interface signals
logic SDmosi;                    // MOSI line
logic SDmiso;                    // MISO line
logic SDcs;                      // Chip Select line

// Connect SD data lines
assign sd_d[0] = SDmiso;          
assign sd_d[1] = 1'b1;         // Unused data lines pulled high
assign sd_d[2] = 1'b1;
assign sd_d[3] = SDcs;
assign sd_cmd = SDmosi;
// SD card control signals
logic [7:0] data_out;                // Data output from the SD controller
logic read_data;                     // Signal to trigger SD card read
                               // Every 32kHz trigger a new read

logic clk;

ecp5pll
#(
    .in_hz(25000000),
    .out0_hz(100000000)
)
ecp5pll_inst
(
    .clk_i(clk_25mhz),
    .clk_o(clk)
);

sd_card_reader sd_card (
    .clk(clk),
    .rst(globalReset),
    .read_data(read_data),
    .data_out(data_out),
    .miso(SDmiso),
    .mosi(SDmosi),
    .sclk(sd_clk),
    .cs(SDcs)
);


logic globalReset;                // Global reset signal
logic state;                // Current state
localparam RESETSTATE = 0;        // Reset state
localparam RUNNINGSTATE = 1;      // Running state

logic [10:0] reset_counter = 0;


always_ff @(posedge clk) begin
    if(state == RESETSTATE) begin
        globalReset <= 1;
        reset_counter <= reset_counter + 1;
        if(&reset_counter) begin
            state <= RUNNINGSTATE;
        end
    end else begin
        globalReset <= 0;
        if(!btn[0]) begin
            reset_counter <= 0;
            state <= RESETSTATE;
        end
    end
end


always_ff @(posedge clk) begin
    led <= data_out;
end

logic [5:0] btn_d;

debouncer de [5:0](
    .clk(clk),
    .btn_i(btn[6:1]),
    .btn_o(btn_d)
);

always_ff @(posedge clk) begin
    read_data <= 0;
    if(|btn_d) begin
        read_data <= 1;
    end
end

endmodule


