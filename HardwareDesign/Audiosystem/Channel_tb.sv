`timescale 1ns/1ns
module Test;

logic clk_25mhz = 0;
logic audio_bclk;
logic audio_lrclk;
logic audio_din;

always # 20 clk_25mhz <= ~clk_25mhz;

Channel_Test Channel_Test 
(
    .*
);

integer i;

initial begin
    $dumpvars(0, Test);
  #10000000

    $finish;
end

endmodule