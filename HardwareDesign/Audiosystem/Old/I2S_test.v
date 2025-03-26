//yosys -p"read_verilog -sv ecp5pll.sv I2S_test.v; synth_ecp5 -json Ausgabe.json"

module I2S_Test (
    input[6:0] btn,
    input clk_25mhz,
    output audio_bclk,
    output audio_lrclk,
    output audio_din
);

assign audio_bclk = clk_1024khz; //bclk
assign audio_lrclk = clk_64khz; //lrclk
assign audio_din = data_out; //din

reg data_out;

wire clk_100mhz;
ecp5pll
#(
    .in_hz   (25000000),
    .out0_hz(100000000), .out0_tol_hz(50),
)
ecp5pll_inst
(
    .clk_i(clk_25mhz),
    .clk_o({clk_100mhz})
);

reg[9:0] clk_64khz_counter;
reg clk_64khz; 
always @(posedge clk_1024khz) begin
    clk_64khz_counter <= clk_64khz_counter + 1;
    if(clk_64khz_counter + 1 == 16) begin
        clk_64khz_counter <= 0;
        clk_64khz <= ~clk_64khz;
    end
end

reg[9:0] clk_1024khz_counter;
reg clk_1024khz; 
always @(posedge clk_100mhz) begin
    clk_1024khz_counter <= clk_1024khz_counter + 1;
    if(clk_1024khz_counter + 1 == 49) begin
        clk_1024khz_counter <= 0;
        clk_1024khz <= ~clk_1024khz;
    end
end


reg[15:0] memory[239616];
reg[31:0] pointer = 0;

initial $readmemh("audiotest.hex", memory);

reg[15:0] amplitude;
always @(posedge clk_64khz) begin
    pointer <= pointer + 1;
    //turning little endian into big endian
    amplitude <= {memory[pointer[31:0]][7:0], memory[pointer[31:0]][15:8]};
end

reg[3:0] bitIndex = 4'b0;
wire[3:0] nextBit = bitIndex + 1;
//MSB first
always @(posedge clk_1024khz) begin
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