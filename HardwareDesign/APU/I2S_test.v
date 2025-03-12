module I2S_Test (
    input[6:0] btn,
    input clk_25mhz,
    output audio_sclk,
    output audio_bclk,
    output audio_din,
    output audio_lrclk,
    output audio_xsmt
);

//I²S
wire bit_clk;
wire lr_clk;
reg data_out;

wire unused;
wire unused2;

assign audio_sclk = 0; //PCM5102a will generate a sclk itself if sclk is low
assign lr_clk = lr_clk; //lrclk
assign audio_din = data_out; //din
assign audio_bclk = bit_clk; //bclk
assign audio_xsmt = 1; //XSFMT

ecp5pll
#(
    .in_hz(25000000),
    .out0_hz(10000000),                 .out0_tol_hz(100000000),
    .out1_hz(10000000), .out1_deg(0), .out1_tol_hz(100000000),
    .out2_hz(64000), .out2_deg(0), .out2_tol_hz(1000),
    .out3_hz(1024000), .out3_deg(0), .out3_tol_hz(1000)
)
ecp5pll_inst
(
    .clk_i(clk_25mhz),
    .clk_o({bit_clk, lr_clk, unused, unused2})
);

reg[15:0] amplitude = 16'b100000000;
reg[3:0] bitIndex = 4'b0;
wire[3:0] nextBit = bitIndex + 1;

reg[7:0] freqCounter = 0;
wire[7:0] nextFreqCounter = freqCounter + 1;

always @(posedge lr_clk) begin
    freqCounter <= nextFreqCounter;
    if(freqCounter >= 100) begin
        freqCounter <= 0;
        amplitude <= -amplitude;
    end
end

//MSB first
always @(posedge bit_clk) begin
    bitIndex <= nextBit;
    case (bitIndex)
        4'b0000: data_out <= amplitude[15];
        4'b0001: data_out <= amplitude[14];
        4'b0010: data_out <= amplitude[13];
        4'b0011: data_out <= amplitude[12];
        4'b0100: data_out <= amplitude[11];
        4'b0101: data_out <= amplitude[10];
        4'b0110: data_out <= amplitude[9];
        4'b0111: data_out <= amplitude[8];
        4'b1000: data_out <= amplitude[7];
        4'b1001: data_out <= amplitude[6];
        4'b1010: data_out <= amplitude[5];
        4'b1011: data_out <= amplitude[4];
        4'b1100: data_out <= amplitude[3];
        4'b1101: data_out <= amplitude[2];
        4'b1110: data_out <= amplitude[1];
        4'b1111: data_out <= amplitude[0];
    endcase
end
endmodule
