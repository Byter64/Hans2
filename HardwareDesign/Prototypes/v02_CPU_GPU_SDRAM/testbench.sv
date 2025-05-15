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

logic[15:0] memory[256];
logic[15:0] data_out;
assign sdram_d = sdram_wen ? data_out : 16'bzzzzzzzzzzzzzzzz;
always_ff @(posedge sdram_clk) begin
	if(sdram_cke && sdram_csn && sdram_rasn && sdram_casn && !sdram_a[10]) begin
		//Write
		if(!sdram_wen)
			memory[sdram_a] <= sdram_d;
		//Read
		if (sdram_wen)
			data_out <= memory[sdram_a];
	end
end

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

integer i;
initial begin
	for(i = 0; i < 256; i++)
		$dumpvars(0, memory[i]);
	$dumpvars(1, testbench);
	$dumpvars(0, Top.Processor.picorv32_core.dbg_ascii_instr);
	$dumpvars(0, Top.SDRAM);
	$dumpvars(0, Top.GraphicSystem.gpu);
	#4000000
	$finish;
end

endmodule
