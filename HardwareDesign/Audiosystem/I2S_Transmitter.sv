module I2S_Transmitter (
    input clk_1024khz,
    input clk_64khz,
    input[15:0] data,

    I2S.Transmitter i2s
);

assign i2s.bclk = clk_1024khz;
assign i2s.lrclk = clk_64khz;
assign i2s.data = 0;
  /*  
logic[3:0] bitIndex = 4'b0;
logic[3:0] nextBit = bitIndex + 1;
//MSB first
always_ff @(posedge clk_1024khz) begin : DataSerializer
    bitIndex <= nextBit;
    case (bitIndex)
        4'b0000: i2s.data <= data[15];
        4'b0001: i2s.data <= data[14];
        4'b0010: i2s.data <= data[13];
        4'b0011: i2s.data <= data[12];
        4'b0100: i2s.data <= data[11];
        4'b0101: i2s.data <= data[10];
        4'b0110: i2s.data <= data[9];
        4'b0111: i2s.data <= data[8];
        4'b1000: i2s.data <= data[7];
        4'b1001: i2s.data <= data[6];
        4'b1010: i2s.data <= data[5];
        4'b1011: i2s.data <= data[4];
        4'b1100: i2s.data <= data[3];
        4'b1101: i2s.data <= data[2];
        4'b1110: i2s.data <= data[1];
        4'b1111: i2s.data <= data[0];
    endcase
end
*/
endmodule