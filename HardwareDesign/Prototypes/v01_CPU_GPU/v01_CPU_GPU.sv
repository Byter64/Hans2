// iverilog -g2012 testbench.sv ../Processor/picorv32.v ../Graphicsystem/BufferController.v ../Graphicsystem/Framebuffer.v ../Graphicsystem/GPU.v ../Graphicsystem/GraphicSystem.v ../Graphicsystem/HDMI_Out.v ../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v

module CPU_with_GPU
(
    input logic  clk_25mhz,
    output logic [3:0] gpdi_dp
);

logic hdmi_pixClk;
logic resetn = 0;
logic trap;
logic [7:0] reset_counter = 0;
always_ff @(posedge hdmi_pixClk) begin
    if(reset_counter != 255)
        reset_counter <= reset_counter + 1;

	resetn <= reset_counter == 255;
end

localparam S_COUNT = 2;
localparam M_COUNT = 2;
localparam ADDR_WIDTH = 32;
localparam DATA_WIDTH = 32;
localparam STRB_WIDTH = 4;
localparam M_BASE_ADDR = {32'h0, 32'h1_0000};
localparam M_ADDR_WIDTH = {32'd16, 32'd16};

logic         CPU_mem_axi_awvalid;
logic         CPU_mem_axi_awready;
logic [31:0]  CPU_mem_axi_awaddr;
logic [ 2:0]  CPU_mem_axi_awprot;
logic         CPU_mem_axi_wvalid;
logic         CPU_mem_axi_wready;
logic [31:0]  CPU_mem_axi_wdata;
logic [ 3:0]  CPU_mem_axi_wstrb;
logic         CPU_mem_axi_bvalid;
logic         CPU_mem_axi_bready;
logic [ 1:0]  CPU_mem_axi_bresp;
logic         CPU_mem_axi_arvalid;
logic         CPU_mem_axi_arready;
logic [31:0]  CPU_mem_axi_araddr;
logic [ 2:0]  CPU_mem_axi_arprot;
logic         CPU_mem_axi_rvalid;
logic         CPU_mem_axi_rready;
logic [ 1:0]  CPU_mem_axi_rresp;
logic [31:0]  CPU_mem_axi_rdata;
logic [31:0]  CPU_irq = 'b0;
logic [31:0]  CPU_eoi;
logic 		  CPU_trace_valid;
logic [35:0]  CPU_trace_data;

picorv32_axi #(
	.COMPRESSED_ISA(1),
	.BARREL_SHIFTER(1),
	.ENABLE_FAST_MUL(1),
	.ENABLE_DIV(1),
	.ENABLE_IRQ(1),
	.MASKED_IRQ(32'h0000_0000), //1 == disable this IRQ
	.LATCHED_IRQ(32'hFFFF_FFFF), //1 == interrupt is edge triggered, 0 == interrupt is level triggered
	.PROGADDR_IRQ(32'h0000_0010) //Start address of the interrupt handler

) processor 
(
	.clk(hdmi_pixClk),
	.resetn(resetn),
	.trap(trap),

	//AXI-L MASTER
	.mem_axi_awvalid(CPU_mem_axi_awvalid),
	.mem_axi_awready(CPU_mem_axi_awready),
	.mem_axi_awaddr(CPU_mem_axi_awaddr),
	.mem_axi_awprot(CPU_mem_axi_awprot),
	.mem_axi_wvalid(CPU_mem_axi_wvalid),
	.mem_axi_wready(CPU_mem_axi_wready),
	.mem_axi_wdata(CPU_mem_axi_wdata),
	.mem_axi_wstrb(CPU_mem_axi_wstrb),
	.mem_axi_bvalid(CPU_mem_axi_bvalid),
	.mem_axi_bready(CPU_mem_axi_bready),
	.mem_axi_arvalid(CPU_mem_axi_arvalid),
	.mem_axi_arready(CPU_mem_axi_arready),
	.mem_axi_araddr(CPU_mem_axi_araddr),
	.mem_axi_arprot(CPU_mem_axi_arprot),
	.mem_axi_rvalid(CPU_mem_axi_rvalid),
	.mem_axi_rready(CPU_mem_axi_rready),
	.mem_axi_rdata(CPU_mem_axi_rdata),

	.irq(CPU_irq),
	.eoi(CPU_eoi),

	.trace_valid(CPU_trace_valid),
	.trace_data(CPU_trace_data)
);

//Graphicsystem
logic [ADDR_WIDTH-1:0] GS_s_axil_awaddr;
logic [2:0]            GS_s_axil_awprot;
logic                  GS_s_axil_awvalid;
logic                  GS_s_axil_awready;
logic [DATA_WIDTH-1:0] GS_s_axil_wdata;
logic [STRB_WIDTH-1:0] GS_s_axil_wstrb;
logic                  GS_s_axil_wvalid;
logic                  GS_s_axil_wready;
logic [1:0]            GS_s_axil_bresp;
logic                  GS_s_axil_bvalid;
logic                  GS_s_axil_bready;
logic [ADDR_WIDTH-1:0] GS_s_axil_araddr;
logic [2:0]            GS_s_axil_arprot;
logic                  GS_s_axil_arvalid;
logic                  GS_s_axil_arready;
logic[DATA_WIDTH-1:0]  GS_s_axil_rdata;
logic[1:0]             GS_s_axil_rresp;
logic                  GS_s_axil_rvalid;
logic                  GS_s_axil_rready;
logic[ADDR_WIDTH-1:0]  GS_m_axil_awaddr;
logic[2:0]             GS_m_axil_awprot;
logic                  GS_m_axil_awvalid;
logic                  GS_m_axil_awready;
logic[DATA_WIDTH-1:0]  GS_m_axil_wdata;
logic[STRB_WIDTH-1:0]  GS_m_axil_wstrb;
logic                  GS_m_axil_wvalid;
logic                  GS_m_axil_wready;
logic [1:0]            GS_m_axil_bresp;
logic                  GS_m_axil_bvalid;
logic                  GS_m_axil_bready;
logic[ADDR_WIDTH-1:0]  GS_m_axil_araddr;
logic[2:0]             GS_m_axil_arprot;
logic                  GS_m_axil_arvalid;
logic                  GS_m_axil_arready;
logic [DATA_WIDTH-1:0] GS_m_axil_rdata;
logic [1:0]            GS_m_axil_rresp;
logic                  GS_m_axil_rvalid;
logic                  GS_m_axil_rready;

GraphicSystem graphicSystem 
(
	.clk25Mhz(clk_25mhz),
	.cpuClk(hdmi_pixClk),
	.reset(~resetn),
	.gpdiDp(gpdi_dp),
	.hdmi_pixClk(hdmi_pixClk),
	.aclk(hdmi_pixClk),
	.aresetn(resetn),
	.s_axil_awaddr(GS_s_axil_awaddr),
	.s_axil_awprot(GS_s_axil_awprot),
	.s_axil_awvalid(GS_s_axil_awvalid),
	.s_axil_awready(GS_s_axil_awready),
	.s_axil_wdata(GS_s_axil_wdata),
	.s_axil_wstrb(GS_s_axil_wstrb),
	.s_axil_wvalid(GS_s_axil_wvalid),
	.s_axil_wready(GS_s_axil_wready),
	.s_axil_bresp(GS_s_axil_bresp),
	.s_axil_bvalid(GS_s_axil_bvalid),
	.s_axil_bready(GS_s_axil_bready),
	.s_axil_araddr(GS_s_axil_araddr),
	.s_axil_arprot(GS_s_axil_arprot),
	.s_axil_arvalid(GS_s_axil_arvalid),
	.s_axil_arready(GS_s_axil_arready),
	.s_axil_rdata(GS_s_axil_rdata),
	.s_axil_rresp(GS_s_axil_rresp),
	.s_axil_rvalid(GS_s_axil_rvalid),
	.s_axil_rready(GS_s_axil_rready),
	.m_axil_awaddr(GS_m_axil_awaddr),
	.m_axil_awprot(GS_m_axil_awprot),
	.m_axil_awvalid(GS_m_axil_awvalid),
	.m_axil_awready(GS_m_axil_awready),
	.m_axil_wdata(GS_m_axil_wdata),
	.m_axil_wstrb(GS_m_axil_wstrb),
	.m_axil_wvalid(GS_m_axil_wvalid),
	.m_axil_wready(GS_m_axil_wready),
	.m_axil_bresp(GS_m_axil_bresp),
	.m_axil_bvalid(GS_m_axil_bvalid),
	.m_axil_bready(GS_m_axil_bready),
	.m_axil_araddr(GS_m_axil_araddr),
	.m_axil_arprot(GS_m_axil_arprot),
	.m_axil_arvalid(GS_m_axil_arvalid),
	.m_axil_arready(GS_m_axil_arready),
	.m_axil_rdata(GS_m_axil_rdata),
	.m_axil_rresp(GS_m_axil_rresp),
	.m_axil_rvalid(GS_m_axil_rvalid),
	.m_axil_rready(GS_m_axil_rready)
);


logic[ADDR_WIDTH-1:0]  MEM_s_axil_awaddr;
logic[2:0]             MEM_s_axil_awprot;
logic                  MEM_s_axil_awvalid;
logic                  MEM_s_axil_awready;
logic[DATA_WIDTH-1:0]  MEM_s_axil_wdata;
logic[STRB_WIDTH-1:0]  MEM_s_axil_wstrb;
logic                  MEM_s_axil_wvalid;
logic                  MEM_s_axil_wready;
logic                  MEM_s_axil_bvalid;
logic                  MEM_s_axil_bready;
logic[ADDR_WIDTH-1:0]  MEM_s_axil_araddr;
logic[2:0]             MEM_s_axil_arprot;
logic                  MEM_s_axil_arvalid;
logic                  MEM_s_axil_arready;
logic[DATA_WIDTH-1:0]  MEM_s_axil_rdata;
logic[1:0]             MEM_s_axil_rresp;
logic                  MEM_s_axil_rvalid;
logic                  MEM_s_axil_rready;

AXILiteMemory #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .STRB_WIDTH(STRB_WIDTH),
    .MEMORY_DEPTH(10240) //MAKE THIS AS HIGH AS POSSIBLE
) Memory (
    .aclk(hdmi_pixClk),
    .aresetn(resetn),
    .s_axil_awaddr(MEM_s_axil_awaddr >> 2),
    .s_axil_awprot(MEM_s_axil_awprot),
    .s_axil_awvalid(MEM_s_axil_awvalid),
    .s_axil_awready(MEM_s_axil_awready),
    .s_axil_wdata(MEM_s_axil_wdata),
    .s_axil_wstrb(MEM_s_axil_wstrb),
    .s_axil_wvalid(MEM_s_axil_wvalid),
    .s_axil_wready(MEM_s_axil_wready),
    .s_axil_bvalid(MEM_s_axil_bvalid),
    .s_axil_bready(MEM_s_axil_bready),
    .s_axil_araddr(MEM_s_axil_araddr >> 2),
    .s_axil_arprot(MEM_s_axil_arprot),
    .s_axil_arvalid(MEM_s_axil_arvalid),
    .s_axil_arready(MEM_s_axil_arready),
    .s_axil_rdata(MEM_s_axil_rdata),
    .s_axil_rresp(MEM_s_axil_rresp),
    .s_axil_rvalid(MEM_s_axil_rvalid),
    .s_axil_rready(MEM_s_axil_rready)
);

initial $readmemh("C:/Users/Yanni/Desktop/Hans2/HardwareDesign/Prototypes/v01_CPU_GPU/Software/firmware32.hex", Memory.memory);

logic[S_COUNT*ADDR_WIDTH-1:0] AXI_s_axil_awaddr;
logic[S_COUNT*3-1:0]          AXI_s_axil_awprot;
logic[S_COUNT-1:0]            AXI_s_axil_awvalid;
logic[S_COUNT-1:0]            AXI_s_axil_awready;
logic[S_COUNT*DATA_WIDTH-1:0] AXI_s_axil_wdata;
logic[S_COUNT*STRB_WIDTH-1:0] AXI_s_axil_wstrb;
logic[S_COUNT-1:0]            AXI_s_axil_wvalid;
logic[S_COUNT-1:0]            AXI_s_axil_wready;
logic[S_COUNT*2-1:0]          AXI_s_axil_bresp;
logic[S_COUNT-1:0]            AXI_s_axil_bvalid;
logic[S_COUNT-1:0]            AXI_s_axil_bready;
logic[S_COUNT*ADDR_WIDTH-1:0] AXI_s_axil_araddr;
logic[S_COUNT*3-1:0]          AXI_s_axil_arprot;
logic[S_COUNT-1:0]            AXI_s_axil_arvalid;
logic[S_COUNT-1:0]            AXI_s_axil_arready;
logic[S_COUNT*DATA_WIDTH-1:0] AXI_s_axil_rdata;
logic[S_COUNT*2-1:0]          AXI_s_axil_rresp;
logic[S_COUNT-1:0]            AXI_s_axil_rvalid;
logic[S_COUNT-1:0]            AXI_s_axil_rready;
logic[M_COUNT*ADDR_WIDTH-1:0] AXI_m_axil_awaddr;
logic[M_COUNT*3-1:0]          AXI_m_axil_awprot;
logic[M_COUNT-1:0]            AXI_m_axil_awvalid;
logic[M_COUNT-1:0]            AXI_m_axil_awready;
logic[M_COUNT*DATA_WIDTH-1:0] AXI_m_axil_wdata;
logic[M_COUNT*STRB_WIDTH-1:0] AXI_m_axil_wstrb;
logic[M_COUNT-1:0]            AXI_m_axil_wvalid;
logic[M_COUNT-1:0]            AXI_m_axil_wready;
logic[M_COUNT*2-1:0]          AXI_m_axil_bresp;
logic[M_COUNT-1:0]            AXI_m_axil_bvalid;
logic[M_COUNT-1:0]            AXI_m_axil_bready;
logic[M_COUNT*ADDR_WIDTH-1:0] AXI_m_axil_araddr;
logic[M_COUNT*3-1:0]          AXI_m_axil_arprot;
logic[M_COUNT-1:0]            AXI_m_axil_arvalid;
logic[M_COUNT-1:0]            AXI_m_axil_arready;
logic[M_COUNT*DATA_WIDTH-1:0] AXI_m_axil_rdata;
logic[M_COUNT*2-1:0]          AXI_m_axil_rresp;
logic[M_COUNT-1:0]            AXI_m_axil_rvalid;
logic[M_COUNT-1:0]            AXI_m_axil_rready;

//MASTER MAP
//{CPU, Graphicsystem}
assign AXI_s_axil_awaddr 	= {CPU_mem_axi_awaddr, GS_m_axil_awaddr};
assign AXI_s_axil_awprot 	= {CPU_mem_axi_awprot, GS_m_axil_awprot};
assign AXI_s_axil_awvalid 	= {CPU_mem_axi_awvalid, GS_m_axil_awvalid};
assign {CPU_mem_axi_awready, GS_m_axil_awready} = AXI_s_axil_awready;
assign AXI_s_axil_wdata 	= {CPU_mem_axi_wdata, GS_m_axil_wdata};
assign AXI_s_axil_wstrb 	= {CPU_mem_axi_wstrb, GS_m_axil_wstrb};
assign AXI_s_axil_wvalid 	= {CPU_mem_axi_wvalid, GS_m_axil_wvalid};
assign {CPU_mem_axi_wready, GS_m_axil_wready} = AXI_s_axil_wready;
assign {CPU_mem_axi_bresp, GS_m_axil_bresp} = AXI_s_axil_bresp;
assign {CPU_mem_axi_bvalid, GS_m_axil_bvalid} = AXI_s_axil_bvalid;
assign AXI_s_axil_bready 	= {CPU_mem_axi_bready, GS_m_axil_bready};
assign AXI_s_axil_araddr 	= {CPU_mem_axi_araddr, GS_m_axil_araddr};
assign AXI_s_axil_arprot 	= {CPU_mem_axi_arprot, GS_m_axil_arprot};
assign AXI_s_axil_arvalid 	= {CPU_mem_axi_arvalid, GS_m_axil_arvalid};
assign {CPU_mem_axi_arready, GS_m_axil_arready} = AXI_s_axil_arready;
assign {CPU_mem_axi_rdata, GS_m_axil_rdata} = AXI_s_axil_rdata;
assign {CPU_mem_axi_rresp, GS_m_axil_rresp} = AXI_s_axil_rresp;
assign {CPU_mem_axi_rvalid, GS_m_axil_rvalid} = AXI_s_axil_rvalid;
assign AXI_s_axil_rready 	= {CPU_mem_axi_rready, GS_m_axil_rready};

//SLAVE MAP
//{Memory, Graphicsystem}
assign {MEM_s_axil_awaddr, GS_s_axil_awaddr} = AXI_m_axil_awaddr;
assign {MEM_s_axil_awprot, GS_s_axil_awprot} = AXI_m_axil_awprot;
assign {MEM_s_axil_awvalid, GS_s_axil_awvalid} = AXI_m_axil_awvalid;
assign AXI_m_axil_awready 	= {MEM_s_axil_awready, GS_s_axil_awready};
assign {MEM_s_axil_wdata, GS_s_axil_wdata} = AXI_m_axil_wdata;
assign {MEM_s_axil_wstrb, GS_s_axil_wstrb} = AXI_m_axil_wstrb;
assign {MEM_s_axil_wvalid, GS_s_axil_wvalid} = AXI_m_axil_wvalid;
assign AXI_m_axil_wready 	= {MEM_s_axil_wready, GS_s_axil_wready};
assign AXI_m_axil_bresp	 	= {2'b0, GS_s_axil_bresp};
assign AXI_m_axil_bvalid 	= {MEM_s_axil_bvalid, GS_s_axil_bvalid};
assign {MEM_s_axil_bready, GS_s_axil_bready} = AXI_m_axil_bready;
assign {MEM_s_axil_araddr, GS_s_axil_araddr} = AXI_m_axil_araddr;
assign {MEM_s_axil_arprot, GS_s_axil_arprot} = AXI_m_axil_arprot;
assign {MEM_s_axil_arvalid, GS_s_axil_arvalid} = AXI_m_axil_arvalid;
assign AXI_m_axil_arready 	= {MEM_s_axil_arready, GS_s_axil_arready};
assign AXI_m_axil_rdata 	= {MEM_s_axil_rdata, GS_s_axil_rdata};
assign AXI_m_axil_rresp 	= {MEM_s_axil_rresp, GS_s_axil_rresp};
assign AXI_m_axil_rvalid 	= {MEM_s_axil_rvalid, GS_s_axil_rvalid};
assign {MEM_s_axil_rready, GS_s_axil_rready} = AXI_m_axil_rready;

axil_interconnect #(
	.S_COUNT(S_COUNT),
	.M_COUNT(M_COUNT),
	.DATA_WIDTH(DATA_WIDTH),
	.ADDR_WIDTH(ADDR_WIDTH),
	.STRB_WIDTH(STRB_WIDTH),
	.M_BASE_ADDR(M_BASE_ADDR),
	.M_ADDR_WIDTH(M_ADDR_WIDTH)
)
AxiInterconnect 
(
	.clk(hdmi_pixClk),
	.rst(~resetn),

	.s_axil_awaddr(AXI_s_axil_awaddr),
	.s_axil_awprot(AXI_s_axil_awprot),
	.s_axil_awvalid(AXI_s_axil_awvalid),
	.s_axil_awready(AXI_s_axil_awready),
	.s_axil_wdata(AXI_s_axil_wdata),
	.s_axil_wstrb(AXI_s_axil_wstrb),
	.s_axil_wvalid(AXI_s_axil_wvalid),
	.s_axil_wready(AXI_s_axil_wready),
	.s_axil_bresp(AXI_s_axil_bresp),
	.s_axil_bvalid(AXI_s_axil_bvalid),
	.s_axil_bready(AXI_s_axil_bready),
	.s_axil_araddr(AXI_s_axil_araddr),
	.s_axil_arprot(AXI_s_axil_arprot),
	.s_axil_arvalid(AXI_s_axil_arvalid),
	.s_axil_arready(AXI_s_axil_arready),
	.s_axil_rdata(AXI_s_axil_rdata),
	.s_axil_rresp(AXI_s_axil_rresp),
	.s_axil_rvalid(AXI_s_axil_rvalid),
	.s_axil_rready(AXI_s_axil_rready),
	.m_axil_awaddr(AXI_m_axil_awaddr),
	.m_axil_awprot(AXI_m_axil_awprot),
	.m_axil_awvalid(AXI_m_axil_awvalid),
	.m_axil_awready(AXI_m_axil_awready),
	.m_axil_wdata(AXI_m_axil_wdata),
	.m_axil_wstrb(AXI_m_axil_wstrb),
	.m_axil_wvalid(AXI_m_axil_wvalid),
	.m_axil_wready(AXI_m_axil_wready),
	.m_axil_bresp(AXI_m_axil_bresp),
	.m_axil_bvalid(AXI_m_axil_bvalid),
	.m_axil_bready(AXI_m_axil_bready),
	.m_axil_araddr(AXI_m_axil_araddr),
	.m_axil_arprot(AXI_m_axil_arprot),
	.m_axil_arvalid(AXI_m_axil_arvalid),
	.m_axil_arready(AXI_m_axil_arready),
	.m_axil_rdata(AXI_m_axil_rdata),
	.m_axil_rresp(AXI_m_axil_rresp),
	.m_axil_rvalid(AXI_m_axil_rvalid),
	.m_axil_rready(AXI_m_axil_rready)
);
endmodule
