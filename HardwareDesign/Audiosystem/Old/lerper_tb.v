`timescale 1ns/1ns

module main_tb (
);

reg clk = 0;
reg rstn = 0;
reg[15:0] i_signal = 'h0000;
reg[15:0] speed = 3;

wire[15:0] o_signal;

lerper lerper 
(
    .clk(clk),
    .rstn(rstn),

    .i_signal(i_signal),
    .speed(speed),
    .o_signal(o_signal)
);

always @(clk) begin
    #1 clk <= ~clk;
end

initial begin
    $dumpvars(0, main_tb);
    
    #2 clk <= 1;

    rstn <= 1;
    i_signal <= 5000;
    #10000

    i_signal <= 0;
    #10000

    speed <= -3;
    i_signal <= 5000;
    #100000

    i_signal <= 0;
    #100000

    $finish;
end

endmodule