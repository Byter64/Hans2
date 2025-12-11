module Framebuffer #(
    parameter WIDTH = 9,
    parameter DEPTH = 2048
) (
    input clkA,
    input[WIDTH-1:0] dataInA,
    input[$clog2(DEPTH)-1:0] addressA,
    input writeEnableA,
    output reg[WIDTH-1:0] dataOutA,

    input clkB,
    input[WIDTH-1:0] dataInB,
    input[$clog2(DEPTH)-1:0] addressB,
    input writeEnableB,
    output reg[WIDTH-1:0] dataOutB
);
 
reg[WIDTH-1:0] memory[DEPTH-1];
initial $readmemh("C:/Repos/Hans2/HardwareDesign/Graphicsystem/StartScreen.hex", memory);

always @(posedge clkA) begin
    if(writeEnableA)
        memory[addressA] <= dataInA;
    else
        dataOutA <= memory[addressA];
end

always @(posedge clkB) begin
    if(writeEnableB)
        memory[addressB] <= dataInB;
    else
        dataOutB <= memory[addressB];
end
    
endmodule