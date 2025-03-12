`timescale 1ns/1ns
module Test;

logic clk_25mhz;
logic audio_bclk;
logic audio_lrclk;
logic audio_din;

Channel_Test Channel_Test 
(
    .*
);

initial begin
    $dumpvars(0, Test);
  #1000000

    $finish;
end

endmodule