//yosys -p"read_verilog ULX3S_hdmi\TMDS_encoder.v HDMI_Out.v GPU.v BufferController.v Framebuffer.v GraphicSystem.v; synth_ecp5 -json Ausgabe.json"

module GraphicSystem
(
    input clk25Mhz,
    input cpuClk,
    input reset,
    output[3:0] gpdiDp,
    output hdmi_pixClk,

    input logic                              aclk,
    input logic                              aresetn,
    //AXI-L SLAVE
    input logic [ADDR_WIDTH-1:0]             s_axil_awaddr,
    input logic [2:0]                        s_axil_awprot,
    input logic                              s_axil_awvalid,
    output logic                             s_axil_awready,
    input logic [DATA_WIDTH-1:0]             s_axil_wdata,
    input logic [STRB_WIDTH-1:0]             s_axil_wstrb,
    input logic                              s_axil_wvalid,
    output logic                             s_axil_wready,
    output logic [1:0]                       s_axil_bresp,
    output logic                             s_axil_bvalid,
    input logic                              s_axil_bready,
    input logic [ADDR_WIDTH-1:0]             s_axil_araddr,
    input logic [2:0]                        s_axil_arprot,
    input logic                              s_axil_arvalid,
    output logic                             s_axil_arready,
    output logic[DATA_WIDTH-1:0]             s_axil_rdata,
    output logic[1:0]                        s_axil_rresp,
    output logic                             s_axil_rvalid,
    input logic                              s_axil_rready,

    //AXI-L MASTER
    output logic[ADDR_WIDTH-1:0]             m_axil_awaddr = 0,
    output logic[2:0]                        m_axil_awprot = 0,
    output logic                             m_axil_awvalid = 0,
    input logic                              m_axil_awready,
    output logic[DATA_WIDTH-1:0]             m_axil_wdata = 0,
    output logic[STRB_WIDTH-1:0]             m_axil_wstrb = 0,
    output logic                             m_axil_wvalid = 0,
    input logic                              m_axil_wready,
    input logic [1:0]                        m_axil_bresp,
    input logic                              m_axil_bvalid,
    output logic                             m_axil_bready = 0,
    output logic[ADDR_WIDTH-1:0]             m_axil_araddr,
    output logic[2:0]                        m_axil_arprot,
    output logic                             m_axil_arvalid,
    input logic                              m_axil_arready,
    input logic [DATA_WIDTH-1:0]             m_axil_rdata,
    input logic [1:0]                        m_axil_rresp,
    input logic                              m_axil_rvalid,
    output logic                             m_axil_rready
);

localparam DATA_WIDTH = 32;
localparam ADDR_WIDTH = 32;
localparam STRB_WIDTH = 4;

typedef enum logic[31:0] {
    ADDRESS,
    ADDRESS_X,
    ADDRESS_Y,
    IMAGE_WIDTH,
    WIDTH,
    HEIGHT,
    X,
    Y,
    CLEAR_COLOR,
    COMMAND_DRAW,
    COMMAND_CLEAR,
    IS_BUSY,

    VSYNC,
    HSYNC,

    COMMAND_SWAP_BUFFERS,
    VSYNC_BUFFER_SWAP
} DataIndex;

DataIndex activeWriteDataIndex;
DataIndex activeReadDataIndex;
logic        swapBuffers;
logic        isVSynced;
logic[31:0]  gpu_Address;
logic[15:0]  gpu_AddressX;
logic[15:0]  gpu_AddressY;
logic[15:0]  gpu_ImageWidth;
logic[10:0]  gpu_Width;
logic[9:0]   gpu_Height;
logic[10:0]  gpu_X;
logic[9:0]   gpu_Y;
logic[15:0]  gpu_ClearColor;
logic        gpu_Draw;
logic        gpu_Clear;
logic        gpu_IsBusy;
logic        vSync;
logic        hSync;
logic        swapBuffers;
logic        vSyncBufferSwap;

logic[15:0]  gpu_MemData;
logic        gpu_MemValid;
logic[31:0]  gpu_MemAddr;
logic        gpu_MemRead;

//START - AXI SLAVE IMPLEMENTATION

//Address write
always_ff @(posedge aclk) s_axil_awready <= 1;
always_ff @(posedge aclk) begin
	if (s_axil_awvalid && s_axil_awready) begin 
		activeWriteDataIndex <= s_axil_awaddr;
    end
end

//Write
always_ff @(posedge aclk) s_axil_wready <= 1;
always_ff @(posedge aclk) begin
	if (s_axil_wvalid && s_axil_wready) begin
		case (activeWriteDataIndex)
            ADDRESS: gpu_Address <= s_axil_wdata;
            ADDRESS_X: gpu_AddressX <= s_axil_wdata;
            ADDRESS_Y: gpu_AddressY <= s_axil_wdata;
            IMAGE_WIDTH: gpu_ImageWidth <= s_axil_wdata;
            WIDTH: gpu_Width <= s_axil_wdata;
            HEIGHT: gpu_Height <= s_axil_wdata;
            X: gpu_X <= s_axil_wdata;
            Y: gpu_Y <= s_axil_wdata;
            CLEAR_COLOR: gpu_ClearColor <= s_axil_wdata;
            COMMAND_DRAW: gpu_Draw <= s_axil_wdata;
            COMMAND_CLEAR: gpu_Clear <= s_axil_wdata;
            COMMAND_SWAP_BUFFERS: swapBuffers <= s_axil_wdata;
            VSYNC_BUFFER_SWAP: vSyncBufferSwap <= s_axil_wdata;
        endcase
    end
end

//Write response
assign s_axil_bresp = 0;
always_ff @(posedge aclk) begin
	if (!aresetn)
		s_axil_bvalid <= 0;
	else if (!s_axil_bvalid || s_axil_bready) begin
		s_axil_bvalid <= 1;
    end
end

//Address read
always_ff @(posedge aclk) s_axil_arready <= 1;
always_ff @(posedge aclk) begin
	if (s_axil_arvalid && s_axil_arready) begin
		activeReadDataIndex <= s_axil_araddr;
    end
end

//Read
logic[DATA_WIDTH-1:0] next_rdata;
assign s_axil_rresp = 1;

always_comb begin
    case (activeReadDataIndex)
        ADDRESS: next_rdata = gpu_Address;
        ADDRESS_X: next_rdata = gpu_AddressX;
        ADDRESS_Y: next_rdata = gpu_AddressY;
        IMAGE_WIDTH: next_rdata = gpu_ImageWidth;
        WIDTH: next_rdata = gpu_Width;
        HEIGHT: next_rdata = gpu_Height;
        X: next_rdata = gpu_X;
        Y: next_rdata = gpu_Y;
        CLEAR_COLOR: next_rdata = gpu_ClearColor;
        IS_BUSY: next_rdata = gpu_IsBusy;

        VSYNC: next_rdata = vSync;
        HSYNC: next_rdata = hSync;
        VSYNC_BUFFER_SWAP: next_rdata = vSyncBufferSwap;
        default: next_rdata = 0;
    endcase
end

always_ff @(posedge aclk) begin
	if (!aresetn)
		s_axil_rvalid <= 0;
	else if (!s_axil_rvalid || s_axil_rready) begin
		s_axil_rvalid <= 1;
    end
end

always_ff @(posedge aclk) begin
	if (!aresetn)
		s_axil_rdata <= 0;
	else if (!s_axil_rvalid || s_axil_rready)
	begin
		s_axil_rdata <= next_rdata;
	end
end
//END - AXI SLAVE IMPLEMENTATION

//START - AXI MASTER 

//Address read
logic next_arvalid;
logic[DATA_WIDTH-1:0] next_ardata;
assign next_arvalid = gpu_MemRead;
assign next_ardata = gpu_MemAddr;

always_ff @(posedge aclk) begin
	if (!aresetn)
		m_axil_arvalid <= 0;
	else if (!m_axil_arvalid || m_axil_arready) begin
		m_axil_arvalid <= next_arvalid;
    end
end

always_ff @(posedge aclk) begin
	if (!aresetn)
		m_axil_ardata <= 0;
	else if (!m_axil_arvalid || m_axil_arready)
	begin
		m_axil_ardata <= next_ardata;

		if (!next_arvalid)
			m_axil_ardata <= 0;
	end
end

//Read
always_ff @(posedge aclk) begin
	m_axil_rready <= 1;
end

always_ff @(posedge aclk) begin
	gpu_MemValid <= 0;
    if (m_axil_rvalid && m_axil_rready) begin
		gpu_MemData <= m_axil_rdata;
        gpu_MemValid <= 1;
    end
end

//END - AXI MASTER IMPLEMENTATION

localparam SCREEN_WIDTH = 400;
localparam SCREEN_HEIGHT = 240;

wire[9:0]   gpu_FbX;
wire[8:0]   gpu_FbY;
wire[15:0]  gpu_FbColor;
wire        gpu_FbWrite;
wire[10:0]  hdmi_nextX;
wire[10:0]  hdmi_nextY;
wire        hdmi_hSync;
wire bfCont_fbGPU;
wire bfCont_fbHDMI;
wire[15:0]  fb2_dataOutA;
wire[15:0]  fb2_dataOutB;
wire[15:0]  fb1_dataOutA;
wire[15:0]  fb1_dataOutB;
wire[16:0] gpu_fbAddress = gpu_FbX + gpu_FbY * SCREEN_WIDTH;
wire[16:0] hdmi_fbAddress = ((hdmi_nextX >> 1) + (hdmi_nextY >> 1) * SCREEN_WIDTH); //this halves the resoluton from 480x800 to 240x400
wire[15:0] hdmi_color = bfCont_fbHDMI == 0 ? fb1_dataOutB : fb2_dataOutB;

BufferController bfCont(
    .clk(cpuClk),
    .reset(reset),
    .swapIn(swapBuffers),
    .vSync(hdmi_vSync),
    .isSynchronized(isVSynced),

    .fbGPU(bfCont_fbGPU),
    .fbHDMI(bfCont_fbHDMI)
);

Framebuffer #(
    .WIDTH(16),
    .DEPTH(SCREEN_HEIGHT * SCREEN_WIDTH)
) fb1 (
    .clkA(hdmi_pixClk),
    .dataInA(gpu_FbColor),
    .addressA(gpu_fbAddress),
    .writeEnableA(bfCont_fbGPU == 1'b0 ? gpu_FbWrite : 1'b0),

    .clkB(hdmi_pixClk),
    .dataInB(16'b0),
    .addressB(hdmi_fbAddress),
    .writeEnableB(1'b0),

    .dataOutA(fb1_dataOutA),
    .dataOutB(fb1_dataOutB)
);

Framebuffer #(
    .WIDTH(16),
    .DEPTH(SCREEN_HEIGHT * SCREEN_WIDTH)
) fb2 (
    .clkA(hdmi_pixClk),
    .dataInA(gpu_FbColor),
    .addressA(gpu_fbAddress),
    .writeEnableA(bfCont_fbGPU == 1'b1 ? gpu_FbWrite : 1'b0),

    .clkB(hdmi_pixClk),
    .dataInB(16'b0),
    .addressB(hdmi_fbAddress),
    .writeEnableB(1'b0),

    .dataOutA(fb2_dataOutA),
    .dataOutB(fb2_dataOutB)
);


/*The gpu_mem... and gpu_Ctrl... signals are direct in-/outputs on the GraphicSystem*/
gpu #(
    .FB_WIDTH(SCREEN_WIDTH),
    .FB_HEIGHT(SCREEN_HEIGHT)
) gpu (
    .clk(hdmi_pixClk),
    .reset(reset),
    //MEM INTERFACE
    .mem_data(gpu_MemData),
    .mem_valid(gpu_MemValid),
    .mem_addr(gpu_MemAddr),
    .mem_read(gpu_MemRead),
    //CONTROL INTERFACE: Draw
    .ctrl_address(gpu_Address),
    .ctrl_address_x(gpu_AddressX),
    .ctrl_address_y(gpu_AddressY),
    .ctrl_image_width(gpu_ImageWidth),
    .ctrl_width(gpu_Width),
    .ctrl_height(gpu_Height),
    .ctrl_x(gpu_X),
    .ctrl_y(gpu_Y),
    .ctrl_draw(gpu_Draw),
    //CONTROL INTERFACE: Clear
    .ctrl_clear_color(gpu_ClearColor),
    .ctrl_clear(gpu_Clear),
    .crtl_busy(gpu_IsBusy),
    //FRAMEBUFFER INTERFACE
    .fb_x(gpu_FbX),
    .fb_y(gpu_FbY),
    .fb_color(gpu_FbColor),
    .fb_write(gpu_FbWrite)
);


HDMI_Out hdmi_Out
(
    //In
    .clk_25mhz(clk25Mhz),
    .red({hdmi_color[15:11], 3'b0}),
    .green({hdmi_color[10:6], 3'b0}),
    .blue({hdmi_color[5:1], 3'b0}),

    //Out
    .pixclk(hdmi_pixClk),
    .nextX(hdmi_nextX),
    .nextY(hdmi_nextY),
    .hSync(hdmi_hSync),
    .vSync(hdmi_vSync),
    .gpdi_dp(gpdiDp)

);

endmodule