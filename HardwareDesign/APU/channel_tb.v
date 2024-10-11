`timescale 1ns/1ns

module main_tb (
);

reg clk = 0;
reg rstn = 0;
reg[15:0] volume = 'hF000;
reg[15:0] duty_cycle = 22050;
reg[15:0] period = 44100;

wire[15:0] wave;

channel channel 
(
    .clk(clk),
    .rstn(rstn),

    .volume(volume),
    .duty_cycle(duty_cycle),
    .period(period),
    .wave(wave)
);

always @(clk) begin
    #1 clk <= ~clk;
end

initial begin
    $dumpvars(0, main_tb);
    
    #2 clk <= 1;

    rstn <= 1;
    #100000

    duty_cycle <= 2;
    #100000

    $finish;
end

endmodule