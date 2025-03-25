module I2STransmitter (
    input logic[15:0] dataIn,
    input logic bitclk,
    
    output logic dataOut
);

logic[3:0] bitIndex = 4'b0;
logic[3:0] nextBit;
assign nextBit = bitIndex + 1;
//MSB first
always @(posedge bitclk) begin
    bitIndex <= nextBit;
    case (bitIndex)
        4'b0000: dataOut <= dataIn[15];
        4'b0001: dataOut <= dataIn[14];
        4'b0010: dataOut <= dataIn[13];
        4'b0011: dataOut <= dataIn[12];
        4'b0100: dataOut <= dataIn[11];
        4'b0101: dataOut <= dataIn[10];
        4'b0110: dataOut <= dataIn[9];
        4'b0111: dataOut <= dataIn[8];
        4'b1000: dataOut <= dataIn[7];
        4'b1001: dataOut <= dataIn[6];
        4'b1010: dataOut <= dataIn[5];
        4'b1011: dataOut <= dataIn[4];
        4'b1100: dataOut <= dataIn[3];
        4'b1101: dataOut <= dataIn[2];
        4'b1110: dataOut <= dataIn[1];
        4'b1111: dataOut <= dataIn[0];
    endcase
end
    
endmodule