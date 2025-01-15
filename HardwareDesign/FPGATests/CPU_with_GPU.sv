module top(
    input logic clk_25mhz,
    output logic [3:0] gpdi_dp
    );

	localparam MEM_SIZE = 8192;
	localparam [31:0] STACKADDR = 32'h 0000_0000 + (MEM_SIZE);
	localparam [31:0] PROGADDR_RESET = 32'h00000; 

	logic mem_valid;
	logic mem_ready;
	logic [31:0] mem_addr;
	logic [31:0] mem_wdata;
	logic [3:0] mem_wstrb;
	logic [31:0] mem_rdata;

    logic [3:0] clocks;
    ecp5pll
    #(
        .in_hz(25*10**6),
        .out0_hz(25*10**6),                 .out0_tol_hz(0),
        .out1_hz(50*10**6), .out1_deg( 90), .out1_tol_hz(0),
        .out2_hz(100*10**6), .out2_deg(180), .out2_tol_hz(0),
        .out3_hz(144*10**6), .out3_deg(300), .out3_tol_hz(0)
    )
    ecp5pll_inst
    (
        .clk_i(clk_25mhz),
        .clk_o(clocks)
    );

	picorv32 #(
		.ENABLE_FAST_MUL(1),
		.ENABLE_DIV(1),
		.BARREL_SHIFTER(1),
		.STACKADDR(STACKADDR),
		.PROGADDR_RESET(PROGADDR_RESET)
	) uut (
		.clk         (clocks[0]  ),
		.mem_valid   (mem_valid  ),
		.mem_ready   (mem_ready  ),
		.mem_addr    (mem_addr   ),
		.mem_wdata   (mem_wdata  ),
		.mem_wstrb   (mem_wstrb  ),
		.mem_rdata   (mem_rdata  )
	);


    logic         swapBuffers;
    logic         isVSynced = 1'b1;
    logic[15:0]   gpu_MemData;
    logic[31:0]   gpu_MemAddr;
    logic         gpu_MemRead;
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

GraphicSystem graphicSystem 
(
    .clk25Mhz(clocks[0]),
    .cpuClk(clocks[0]),
    .reset(1'b0),
    .gpdiDp(gpdi_dp),
    .hdmi_vSync(hdmi_vSync),
    .swapBuffers(swapBuffers),
    .isVSynced(isVSynced),
    .gpu_MemData(gpu_MemData),
    .gpu_MemValid(1'b1),
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

	logic [31:0] memory [0:MEM_SIZE/4-1];
	initial begin 
        $readmemh("firmware.hex", memory);
    end

    always_ff @(posedge clk_25mhz) begin
        mem_ready <= (mem_valid && (mem_addr < MEMSIZE+32'h0200));
    end
    
    always_ff @(posedge clk_25mhz ) begin
        mem_rdata <= (mem_addr < MEMSIZE) ? memory[mem_addr >> 2] : (mem_addr == MEM_SIZE + 32'h002C)? {31'b0,gpu_CtrlBusy} : (mem_addr == MEM_SIZE+32'h0108) ? {31'b0,hdmi_vSync} : 32'b0;
    end

    always_ff @(posedge clk_25mhz) begin
        gpu_CtrlDraw <= 0;
        gpu_CtrlClear <= 0;
        swapBuffers <= 0;
        
        if (mem_valid) begin
            case (1'b1)
                (mem_addr < MEM_SIZE): begin
                    if (mem_wstrb[0]) memory[mem_addr >> 2][7:0] <= mem_wdata[7:0];
                    if (mem_wstrb[1]) memory[mem_addr >> 2][15:8] <= mem_wdata[15:8];
                    if (mem_wstrb[2]) memory[mem_addr >> 2][23:16] <= mem_wdata[23:16];
                    if (mem_wstrb[3]) memory[mem_addr >> 2][31:24] <= mem_wdata[31:24];
                end
                (mem_addr == MEM_SIZE+32'h0000): gpu_CtrlAddress <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0004): gpu_CtrlAddressX <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0008): gpu_CtrlAddressY <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h000C): gpu_CtrlImageWidth <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0010): gpu_CtrlWidth <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0014): gpu_CtrlHeight <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0018): gpu_CtrlX <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h001C): gpu_CtrlY <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0020): gpu_CtrlDraw <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0024): gpu_CtrlClearColor <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0028): gpu_CtrlClear <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h0100): swapBuffers <= mem_wdata;
                (mem_addr == MEM_SIZE+32'h010C): isVSynced <= mem_wdata;
            endcase
        end
    end
endmodule
