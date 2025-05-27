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
inout logic[15:0]  sdram_d;

always #20 clk_25mhz <= ~clk_25mhz;

IS42S16160 SDRAM 
(
	.Dq(sdram_d),
	.Addr(sdram_a),
	.Ba(sdram_ba),
	.Clk(sdram_clk),
	.Cke(sdram_cke),
	.Cs_n(sdram_csn),
	.Ras_n(sdram_rasn),
	.Cas_n(sdram_casn),
	.We_n(sdram_wen),
	.Dqm(sdram_dqm)
);

logic sd_clk; 
logic sd_cmd;
inout logic[3:0] sd_d;
assign sd_d[0] = 0;

CPU_with_GPU_SDRAM_SDCard Top 
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
	.sdram_d(sdram_d),

	.sd_clk(sd_clk),
	.sd_cmd(sd_cmd),
	.sd_d(sd_d)
);
    
integer i; 
initial begin
	for(i = 0; i < 64; i++) begin
		$dumpvars(0, SDRAM.Bank0[i]);
	end
	$dumpvars(0, testbench);  

	#2000000
	$finish;
end

endmodule
