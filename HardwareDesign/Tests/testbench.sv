`timescale 1 ns / 1 ps
// iverilog -g2012 testbench.sv ../Processor/picorv32.v ../Graphicsystem/BufferController.v ../Graphicsystem/Framebuffer.v ../Graphicsystem/GPU.v ../Graphicsystem/GraphicSystem.v ../Graphicsystem/HDMI_Out.v ../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v 

module testbench;
	logic clk = 1;
	logic resetn = 0;
	logic trap;

	always #5 clk = ~clk;

	initial begin
		repeat (100) @(posedge clk);
		resetn <= 1;
	end

	logic mem_valid;
	logic mem_instr;
	logic mem_ready;
	logic [31:0] mem_addr;
	logic [31:0] mem_wdata;
	logic [3:0] mem_wstrb;
	logic  [31:0] mem_rdata;

	logic[3:0]    gpdi_dp;
	logic         swapBuffers;
    logic         isVSynced = 1'b1;
    logic[15:0]   gpu_MemData;
    logic[31:0]   gpu_MemAddr;
    logic         gpu_MemRead;
    logic         gpu_MemValid = 1'b0;
    logic[31:0]   gpu_CtrlAddress;
    logic[15:0]   gpu_CtrlAddressX;
    logic[15:0]   gpu_CtrlAddressY;
    logic[15:0]   gpu_CtrlImageWidth;
    logic[10:0]   gpu_CtrlWidth;
    logic[9:0]    gpu_CtrlHeight;
    logic[10:0]   gpu_CtrlX;
    logic[9:0]    gpu_CtrlY;
    logic         gpu_CtrlDraw;
    logic[15:0]   gpu_CtrlClearColor = 16'b1101100010110111;
    logic         gpu_CtrlClear;
    logic         gpu_CtrlBusy;
    logic         hdmi_pixClk;
    logic         hdmi_vSync;

	localparam MEM_SIZE = 32768;
	
	logic [31:0] memory [0:MEM_SIZE/4-1];
	initial $readmemh("Software/firmware32.hex", memory);


	picorv32 #(
		.ENABLE_FAST_MUL(1),
		.ENABLE_DIV(1),
		.BARREL_SHIFTER(1)
	) uut (
		.clk         (clk        ),
		.resetn      (resetn     ),
		.trap        (trap       ),
		.mem_valid   (mem_valid  ),
		.mem_instr   (mem_instr  ),
		.mem_ready   (mem_ready  ),
		.mem_addr    (mem_addr   ),
		.mem_wdata   (mem_wdata  ),
		.mem_wstrb   (mem_wstrb  ),
		.mem_rdata   (mem_rdata  )
	);

	GraphicSystem graphicSystem 
	(
		.clk25Mhz(clk),
		.cpuClk(clk),
		.reset(~resetn),
		.gpdiDp(gpdi_dp),
		.hdmi_pixClk(hdmi_pixClk),
		.hdmi_vSync(hdmi_vSync),
		.swapBuffers(swapBuffers),
		.isVSynced(isVSynced),
		.gpu_MemData(gpu_MemData),
		.gpu_MemValid(gpu_MemValid),
		.gpu_MemAddr(gpu_MemAddr),
		.gpu_MemRead(gpu_MemRead),
		.gpu_CtrlAddress(gpu_CtrlAddress),
		.gpu_CtrlAddressX(gpu_CtrlAddressX),
		.gpu_CtrlAddressY(gpu_CtrlAddressY),
		.gpu_CtrlImageWidth(gpu_CtrlImageWidth),
		.gpu_CtrlWidth(gpu_CtrlWidth),
		.gpu_CtrlHeight(gpu_CtrlHeight),
		.gpu_CtrlX(gpu_CtrlX),
		.gpu_CtrlY(gpu_CtrlY),
		.gpu_CtrlDraw(gpu_CtrlDraw),
		.gpu_CtrlClearColor(gpu_CtrlClearColor),
		.gpu_CtrlClear(gpu_CtrlClear),
		.gpu_CtrlBusy(gpu_CtrlBusy)
	);

	always_ff @(posedge clk) begin
		mem_ready <= 0;
		gpu_CtrlDraw <= 0;
        gpu_CtrlClear <= 0;
        swapBuffers <= 0;
		gpu_MemValid <= 0;
		if(gpu_MemRead) begin
			gpu_MemData <= memory[gpu_MemAddr >> 2];
			gpu_MemValid <= 1;
		end else if (mem_valid && !mem_ready) begin
			mem_ready <= 1;
			case (1)
				mem_addr < MEM_SIZE: begin
					if (|mem_wstrb) begin
						if (mem_wstrb[0]) memory[mem_addr >> 2][ 7: 0] <= mem_wdata[ 7: 0];
						if (mem_wstrb[1]) memory[mem_addr >> 2][15: 8] <= mem_wdata[15: 8];
						if (mem_wstrb[2]) memory[mem_addr >> 2][23:16] <= mem_wdata[23:16];
						if (mem_wstrb[3]) memory[mem_addr >> 2][31:24] <= mem_wdata[31:24];
					end else begin
						mem_rdata <= memory[mem_addr >> 2];
					end
				end
				(mem_addr == MEM_SIZE+32'h0000): if (&mem_wstrb) gpu_CtrlAddress 	<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0004): if (&mem_wstrb) gpu_CtrlAddressX 	<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0008): if (&mem_wstrb) gpu_CtrlAddressY 	<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h000C): if (&mem_wstrb) gpu_CtrlImageWidth <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0010): if (&mem_wstrb) gpu_CtrlWidth 		<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0014): if (&mem_wstrb) gpu_CtrlHeight 	<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0018): if (&mem_wstrb) gpu_CtrlX 			<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h001C): if (&mem_wstrb) gpu_CtrlY 			<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0020): if (&mem_wstrb) gpu_CtrlDraw 		<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0024): if (&mem_wstrb) gpu_CtrlClearColor <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0028): if (&mem_wstrb) gpu_CtrlClear 		<= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0100): if (&mem_wstrb) swapBuffers  		<= swapBuffers ? 0 : mem_wdata;
                (mem_addr == MEM_SIZE+32'h010C): if (&mem_wstrb) isVSynced 			<= mem_wdata;
				(mem_addr == MEM_SIZE+32'h002C): if (~|mem_wstrb) mem_rdata 		<= {31'b0,gpu_CtrlBusy};
				(mem_addr == MEM_SIZE+32'h0108): if (~|mem_wstrb) mem_rdata 		<= {31'b0,hdmi_vSync};
			endcase
		end
		if (mem_valid && mem_ready) begin
			if (^mem_addr === 1'bx ||
					(mem_wstrb[0] && ^mem_wdata[ 7: 0] == 1'bx) ||
					(mem_wstrb[1] && ^mem_wdata[15: 8] == 1'bx) ||
					(mem_wstrb[2] && ^mem_wdata[23:16] == 1'bx) ||
					(mem_wstrb[3] && ^mem_wdata[31:24] == 1'bx)) begin
				$display("CRITICAL UNDEF MEM TRANSACTION");
				$finish;
			end
		end
	end

	initial begin
		$dumpfile("testbench.vcd");
		$dumpvars(0, testbench);
		repeat(1000000) @(posedge clk);
		$finish;
	end

endmodule
