`timescale 1 ns / 1 ps

module testbench;

logic clk_25mhz = 0;
logic [3:0] gpdi_dp;
logic        sdram_clk;
logic        sdram_cke;
logic        sdram_csn;
logic        sdram_wen;
logic        sdram_rasn;
logic        sdram_casn;
logic[12:0]  sdram_a;
logic[1:0]   sdram_ba;
logic[1:0]   sdram_dqm;
logic[15:0]  sdram_d;

always #20 clk_25mhz <= ~clk_25mhz;

CPU_with_GPU_SDRAM Top 
(
	.clk_25mhz(clk_25mhz),
	.gpdi_dp(gpdi_dp),
	.sdram_clk(sdram_clk),
	.sdram_cke(sdram_cke),
	.sdram_csn(sdram_csn),
	.sdram_wen(sdram_wen),
	.sdram_rasn(sdram_rasn),
	.sdram_casn(sdram_casn),
	.sdram_a(sdram_a),
	.sdram_ba(sdram_ba),
	.sdram_dqm(sdram_dqm),
	.sdram_d(sdram_d)
);

initial begin
	$dumpvars(0, Top.Processor);
	$dumpvars(0, Top.SDRAM);
	for(integer i = 0; i < 1000; i++) $dumpvars(0, Top.Bootloader.memory[i]);
	#30000000
	$finish;
end

endmodule
