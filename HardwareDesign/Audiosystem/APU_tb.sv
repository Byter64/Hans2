`timescale 1 ns / 1 ps

module APU_tb;
    
logic clk = 0;
initial clk <= 1;
always #5 clk = ~clk;

logic rst;
initial begin
    rst <= 1;
    repeat(100) @(posedge clk);
    rst <= 0;
end

logic[15:0] bram[2048 / 2];
initial $readmemh("program.txt", bram);

//RAM
logic[15:0] main[2048];
integer mainI;
initial for (mainI = 0; mainI < 2048; mainI++) main[mainI] = 16'hAAAA;

logic[31:0] address;
logic[15:0] dataOut;
logic writeEnable;
logic readEnable;
logic readRAM;
APU APU 
(
    .clk(clk),
    .rst(rst),
    .dataIn(readRAM ? main[address] : bram[address]),
    .dataReady(1'b1),
    .writeAcknowledge(1'b1),

    .address(address),
    .dataOut(dataOut),
    .writeEnable(writeEnable),
    .readEnable(readEnable),
    .readRAM(readRAM)
);

integer i;
initial begin
    $dumpvars(0, APU_tb);
    $dumpvars(0, APU.regs[0]);
    $dumpvars(0, APU.regs[1]);
    $dumpvars(0, APU.regs[2]);

    repeat(100000) @(posedge clk);
    $finish;
end
endmodule