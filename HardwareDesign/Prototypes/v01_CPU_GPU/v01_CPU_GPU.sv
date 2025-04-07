// iverilog -g2012 testbench.sv ../Processor/picorv32.v ../Graphicsystem/BufferController.v ../Graphicsystem/Framebuffer.v ../Graphicsystem/GPU.v ../Graphicsystem/GraphicSystem.v ../Graphicsystem/HDMI_Out.v ../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v ../Controller/controller.sv

module CPU_with_GPU
    (
        input logic clk_25mhz,
		input logic [6:0] btn,
        output logic [3:0] gpdi_dp,
		output logic v33out = 1,
    	input  logic cont_data,
    	output logic cont_clk,
    	output logic cont_activate
    );
	logic clk;
    assign clk = clk_25mhz;
	logic controller_clk = 0;
	logic resetn = 0;
	logic trap;
    logic [7:0] reset_counter = 100;
    always_ff @(posedge hdmi_pixClk ) begin
        if(reset_counter>0) begin
            reset_counter <= reset_counter - 1;
        end
        else begin
            resetn <= 1;
        end
    end
	
	logic [6:0] 	btn_reg;

	logic 			mem_valid;
	logic 			mem_instr;
	logic 			mem_ready;
	logic [31:0] 	mem_addr;
	logic [31:0] 	mem_wdata;
	logic [3:0] 	mem_wstrb;
	logic [31:0] 	mem_rdata;

	logic         	swapBuffers;
    logic         	isVSynced = 1'b1;
    logic [15:0]   	gpu_MemData;
    logic [31:0]   	gpu_MemAddr;
    logic         	gpu_MemRead;
    logic         	gpu_MemValid = 1'b0;
    logic [31:0]   	gpu_CtrlAddress;
    logic [15:0]   	gpu_CtrlAddressX;
    logic [15:0]   	gpu_CtrlAddressY;
    logic [15:0]   	gpu_CtrlImageWidth;
    logic [10:0]   	gpu_CtrlWidth;
    logic [9:0]    	gpu_CtrlHeight;
    logic [10:0]   	gpu_CtrlX;
    logic [9:0]    	gpu_CtrlY;
    logic         	gpu_CtrlDraw;
    logic [15:0]   	gpu_CtrlClearColor = 16'b1101100010110111;
    logic         	gpu_CtrlClear;
    logic         	gpu_CtrlBusy;
    logic         	hdmi_pixClk;
    logic         	hdmi_vSync;

	logic[11:0]   	controller_btns;

	localparam MEM_SIZE = 24576;
	
	logic [31:0] memory [0:MEM_SIZE/4-1];
	initial $readmemh("C:/Users/Yanni/Desktop/Test/main.hex", memory);


	picorv32 #(
		.ENABLE_FAST_MUL(1),
		.ENABLE_DIV(1),
		.BARREL_SHIFTER(1)
	) uut (
		.clk         (hdmi_pixClk        ),
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
		.clk25Mhz(clk_25mhz),
		.cpuClk(hdmi_pixClk),
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
	
	Controller controller
	(
		.clk(controller_clk),
		.controller_btns(controller_btns),
		.cont_data(cont_data),
		.cont_clk(cont_clk),
		.cont_activate(cont_activate)
	);

	logic [31:0] tmp_gpu_MemData;
	logic [31:0] tmp_gpu_addr;
	assign gpu_MemData = tmp_gpu_addr[1] ? tmp_gpu_MemData[31:16] : tmp_gpu_MemData[15:0];

	always_ff @(posedge hdmi_pixClk) begin
		mem_ready <= 0;
		gpu_CtrlDraw <= 0;
        gpu_CtrlClear <= 0;
        swapBuffers <= 0;
		gpu_MemValid <= 0;
		if(gpu_MemRead) begin
			tmp_gpu_addr <= gpu_MemAddr;
			tmp_gpu_MemData <= memory[gpu_MemAddr >> 2];
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
				//GPU
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
				//BTNS
				(mem_addr == MEM_SIZE+32'h0200): if (~|mem_wstrb) mem_rdata 		<= {31'b0,btn_reg[1]};
				(mem_addr == MEM_SIZE+32'h0204): if (~|mem_wstrb) mem_rdata 		<= {31'b0,btn_reg[2]};
				(mem_addr == MEM_SIZE+32'h0208): if (~|mem_wstrb) mem_rdata 		<= {31'b0,btn_reg[3]};
				(mem_addr == MEM_SIZE+32'h020C): if (~|mem_wstrb) mem_rdata 		<= {31'b0,btn_reg[4]};
				(mem_addr == MEM_SIZE+32'h0210): if (~|mem_wstrb) mem_rdata 		<= {31'b0,btn_reg[5]};
				(mem_addr == MEM_SIZE+32'h0214): if (~|mem_wstrb) mem_rdata 		<= {31'b0,btn_reg[6]};
				//Controller
				(mem_addr == MEM_SIZE+32'h0400): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[0]};
				(mem_addr == MEM_SIZE+32'h0404): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[1]};
				(mem_addr == MEM_SIZE+32'h0408): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[2]};
				(mem_addr == MEM_SIZE+32'h040C): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[3]};
				(mem_addr == MEM_SIZE+32'h0410): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[4]};
				(mem_addr == MEM_SIZE+32'h0414): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[5]};
				(mem_addr == MEM_SIZE+32'h0418): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[6]};
				(mem_addr == MEM_SIZE+32'h041C): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[7]};
				(mem_addr == MEM_SIZE+32'h0420): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[8]};
				(mem_addr == MEM_SIZE+32'h0424): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[9]};
				(mem_addr == MEM_SIZE+32'h0428): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[10]};
				(mem_addr == MEM_SIZE+32'h042C): if (~|mem_wstrb) mem_rdata 		<= {31'b0,controller_btns[11]};
			endcase
		end
	end

	logic[7:0] controller_clk_counter = 0;
	logic[7:0] controller_clk_counter_next;

	assign controller_clk_counter_next = controller_clk_counter + 1;

	always_ff @(posedge clk_25mhz) begin
		if(controller_clk_counter_next == 10) begin
			controller_clk_counter <= 0;
			controller_clk <= ~controller_clk;
		end else begin
			controller_clk_counter <= controller_clk_counter_next;
		end
	end

	logic [11:0] btn_timer [0:6];  

	always_ff @(posedge hdmi_pixClk) begin
		for (int i = 0; i < 7; i++) begin
			if (btn_timer[i] == 12'h0000)  begin
				btn_reg[i] <= btn[i]; 
				if(btn[i]) begin
					btn_timer[i] <= 12'h0001;
				end 
			end
			else begin
					btn_timer[i] <= btn_timer[i] + 1;
			end
		end  
	end


endmodule
