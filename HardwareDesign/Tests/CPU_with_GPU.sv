/*
read_verilog -sv  CPU_with_GPU.sv ../Processor/picorv32.v ../Graphicsystem/BufferController.v ../Graphicsystem/Framebuffer.v ../Graphicsystem/GPU.v ../Graphicsystem/GraphicSystem.v ../Graphicsystem/HDMI_Out.v ../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v 
=== top ===

   Number of wires:               3772
   Number of wire bits:          17245
   Number of public wires:        3772
   Number of public wire bits:   17245
   Number of ports:                  2
   Number of port bits:              5
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:               4842
     $scopeinfo                     12
     CCU2C                         483
     DP16KD                        184
     EHXPLLL                         1
     L6MUX21                        18
     LUT4                         2467
     MULT18X18D                      6
     ODDRX1F                         3
     PFUMX                         310
     TRELLIS_DPR16X4                32
     TRELLIS_FF                   1326
*/

module top(
    input logic clk_25mhz,
    output logic [3:0] gpdi_dp
    );

	localparam MEM_SIZE = 8192;
	localparam [31:0] STACKADDR = 32'h 0000_0000 + (MEM_SIZE);
	localparam [31:0] PROGADDR_RESET = 32'h0000_0000; 

	logic mem_valid;
	logic mem_ready;
	logic [31:0] mem_addr;
	logic [31:0] mem_wdata;
	logic [3:0] mem_wstrb;
	logic [31:0] mem_rdata;

    reg resetn;
    reg [31:0] counter;

    // Reset Logic
    initial begin
        resetn <= 0;
        counter <= 0;
    end

    always @(posedge clk_25mhz) begin
        if (counter < 100) begin
            counter <= counter + 1;
            resetn <= 0;
        end else begin
            resetn <= 1;
        end
    end

	picorv32 #(
		.ENABLE_FAST_MUL(1),
		.ENABLE_DIV(1),
		.BARREL_SHIFTER(1),
		.STACKADDR(STACKADDR),
		.PROGADDR_RESET(PROGADDR_RESET)
	) uut (
		.clk         (clk_25mhz  ), //input
		.resetn      (resetn     ), //input
        .mem_valid   (mem_valid  ), //output
        .mem_instr   (mem_instr  ), //output
		.mem_addr    (mem_addr   ), //output
		.mem_wdata   (mem_wdata  ), //output
		.mem_wstrb   (mem_wstrb  ), //output
		.mem_ready   (mem_ready  ), //input
		.mem_rdata   (mem_rdata  )  //input
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
    .clk25Mhz(clk_25mhz),
    .cpuClk(clk_25mhz),
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