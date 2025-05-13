`timescale 1 ns / 1 ps

module testbench;

logic clk_25mhz = 0;
logic [3:0] gpdi_dp;

always #20 clk_25mhz <= ~clk_25mhz;

CPU_with_GPU_SDRAM Top 
(
	.clk_25mhz(clk_25mhz),
	.gpdi_dp(gpdi_dp)
);

initial begin
	$dumpvars(0, Top);
	for(integer i = 0; i < 1000; i++) $dumpvars(0, Top.Bootloader.memory[i]);
	#100000
	$finish;
end

endmodule
