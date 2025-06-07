//`define NO_CONTROLLER_ATTACHED
module Top
(
    input logic  clk_25mhz,
    output logic [3:0] gpdi_dp,
 
	output logic        sdram_clk,
	output logic        sdram_cke,
	output logic        sdram_csn,
	output logic        sdram_wen,
	output logic        sdram_rasn,
	output logic        sdram_casn,
	output logic[12:0]  sdram_a,
	output logic[1:0]   sdram_ba,
	output logic[1:0]   sdram_dqm,
	inout  logic[15:0]  sdram_d, 

    output logic        sd_clk,
    output logic        sd_cmd,
    inout  logic [3:0]  sd_d,

	//Controller
	output logic		c1clock,
	output logic		c1latch,
	input  logic		c1data,
	output logic		c2clock,
	output logic		c2latch,
	input  logic		c2data,

	//Buttons for debug
	input logic[6:0]	btn
);        
     
logic canBeDeleted;   
         
logic hdmi_pixClk;   
logic resetn = 0;    
logic trap;        
logic [7:0] reset_counter = 0;
always_ff @(posedge hdmi_pixClk) begin
    if(reset_counter != 255)
        reset_counter <= reset_counter + 1;
 
	resetn <= reset_counter == 255;
end
  
wire clk_7mhz;  
wire clk_50mhz;
wire clk_130mhz;
ecp5pll #(
  .in_hz       (25000000),
  .out0_hz    (130000000),
  .out0_deg    (       0),
  .out0_tol_hz (       0),  
  .out1_hz     (50000000),
  .out1_deg    (       0),
  .out1_tol_hz ( 1000000),
  .out2_hz     (       0),
  .out2_deg    (       0),
  .out2_tol_hz (       0),
  .out3_hz     (       0),
  .out3_deg    (       0),
  .out3_tol_hz (       0)     
) TopLevelPLL (
  .clk_i(clk_25mhz),  
  .clk_o({clk_50mhz, clk_130mhz})  
); 
                  
localparam S_COUNT = 3;
localparam M_COUNT = 5;
localparam ADDR_WIDTH = 32;
localparam DATA_WIDTH = 32;
localparam STRB_WIDTH = 4;
localparam BOOTLOADER_START = 32'h0201_0000;
//						  {SDRAM, Graphicsystem, Bootloader, 	  Controller,	SDCARD}
localparam M_BASE_ADDR  = {32'h0, 32'h200_0000, BOOTLOADER_START, 32'h02000200, 32'h8000_0000};
localparam M_ADDR_WIDTH = {32'd25, 32'd8,		32'd16,			  32'd2,		32'd31};
           
logic         DCPU_mem_axi_awvalid;
logic         DCPU_mem_axi_awready;
logic [31:0]  DCPU_mem_axi_awaddr;  
logic [ 2:0]  DCPU_mem_axi_awprot;
logic         DCPU_mem_axi_wvalid;
logic         DCPU_mem_axi_wready;
logic [31:0]  DCPU_mem_axi_wdata;
logic [ 3:0]  DCPU_mem_axi_wstrb;
logic         DCPU_mem_axi_bvalid;
logic         DCPU_mem_axi_bready;
logic [ 1:0]  DCPU_mem_axi_bresp;
logic         DCPU_mem_axi_arvalid;
logic         DCPU_mem_axi_arready;
logic [31:0]  DCPU_mem_axi_araddr; 
logic [ 2:0]  DCPU_mem_axi_arprot;
logic         DCPU_mem_axi_rvalid;
logic         DCPU_mem_axi_rready;
logic [ 1:0]  DCPU_mem_axi_rresp;
logic [31:0]  DCPU_mem_axi_rdata;

logic [31:0]  ICPU_mem_axi_araddr;
logic [ 2:0]  ICPU_mem_axi_arprot;
logic         ICPU_mem_axi_arvalid;
logic         ICPU_mem_axi_arready;
logic [31:0]  ICPU_mem_axi_rdata;
logic [ 1:0]  ICPU_mem_axi_rresp;
logic         ICPU_mem_axi_rvalid;
logic         ICPU_mem_axi_rready;

logic         ICPU_mem_axi_awvalid = 0;
logic         ICPU_mem_axi_awready;
logic [31:0]  ICPU_mem_axi_awaddr = 0;  
logic [ 2:0]  ICPU_mem_axi_awprot = 0;
logic         ICPU_mem_axi_wvalid = 0;
logic         ICPU_mem_axi_wready;
logic [31:0]  ICPU_mem_axi_wdata = 0;
logic [ 3:0]  ICPU_mem_axi_wstrb = 0;
logic         ICPU_mem_axi_bvalid;
logic         ICPU_mem_axi_bready;
assign 		  ICPU_mem_axi_bready = 0;
logic [ 1:0]  ICPU_mem_axi_bresp;

VexRiscvAxiLite Processor (
	.aclk(clk_50mhz),
	.aresetn(resetn),

	.d_m_axil_awaddr(DCPU_mem_axi_awaddr),
	.d_m_axil_awready(DCPU_mem_axi_awready),
	.d_m_axil_awvalid(DCPU_mem_axi_awvalid),
	.d_m_axil_awprot(DCPU_mem_axi_awprot),
	.d_m_axil_wvalid(DCPU_mem_axi_wvalid),
	.d_m_axil_wready(DCPU_mem_axi_wready),
	.d_m_axil_wdata(DCPU_mem_axi_wdata),
	.d_m_axil_wstrb(DCPU_mem_axi_wstrb),
	.d_m_axil_bvalid(DCPU_mem_axi_bvalid),
	.d_m_axil_bready(DCPU_mem_axi_bready),
	.d_m_axil_bresp(DCPU_mem_axi_bresp),
	.d_m_axil_arvalid(DCPU_mem_axi_arvalid),
	.d_m_axil_arready(DCPU_mem_axi_arready),
	.d_m_axil_araddr(DCPU_mem_axi_araddr),
	.d_m_axil_arprot(DCPU_mem_axi_arprot),
	.d_m_axil_rvalid(DCPU_mem_axi_rvalid),
	.d_m_axil_rready(DCPU_mem_axi_rready),
	.d_m_axil_rresp(DCPU_mem_axi_rresp),
	.d_m_axil_rdata(DCPU_mem_axi_rdata),

	.i_m_axil_araddr(ICPU_mem_axi_araddr),
	.i_m_axil_arprot(ICPU_mem_axi_arprot),
	.i_m_axil_arvalid(ICPU_mem_axi_arvalid),
	.i_m_axil_arready(ICPU_mem_axi_arready),
	.i_m_axil_rdata(ICPU_mem_axi_rdata),
	.i_m_axil_rresp(ICPU_mem_axi_rresp),
	.i_m_axil_rvalid(ICPU_mem_axi_rvalid),
	.i_m_axil_rready(ICPU_mem_axi_rready)
);


logic[ADDR_WIDTH-1:0]  SDRAM_s_axil_awaddr;
logic[2:0]             SDRAM_s_axil_awprot;
logic                  SDRAM_s_axil_awvalid;
logic                  SDRAM_s_axil_awready;
logic[DATA_WIDTH-1:0]  SDRAM_s_axil_wdata;
logic[STRB_WIDTH-1:0]  SDRAM_s_axil_wstrb;
logic                  SDRAM_s_axil_wvalid;
logic                  SDRAM_s_axil_wready;
logic                  SDRAM_s_axil_bvalid;
logic                  SDRAM_s_axil_bready;
logic[ADDR_WIDTH-1:0]  SDRAM_s_axil_araddr;
logic[2:0]             SDRAM_s_axil_arprot;
logic                  SDRAM_s_axil_arvalid;
logic                  SDRAM_s_axil_arready;
logic[DATA_WIDTH-1:0]  SDRAM_s_axil_rdata;
logic[1:0]             SDRAM_s_axil_rresp;
logic                  SDRAM_s_axil_rvalid;
logic                  SDRAM_s_axil_rready;
  
AXILite_SDRAM SDRAM 
(
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

    .aclk(clk_50mhz),
    .aresetn(resetn),
    .s_axil_awaddr(SDRAM_s_axil_awaddr),
    .s_axil_awprot(SDRAM_s_axil_awprot),
    .s_axil_awvalid(SDRAM_s_axil_awvalid),
    .s_axil_awready(SDRAM_s_axil_awready),
    .s_axil_wdata(SDRAM_s_axil_wdata),
    .s_axil_wstrb(SDRAM_s_axil_wstrb),
    .s_axil_wvalid(SDRAM_s_axil_wvalid),
    .s_axil_wready(SDRAM_s_axil_wready),
    .s_axil_bvalid(SDRAM_s_axil_bvalid),
    .s_axil_bready(SDRAM_s_axil_bready),
    .s_axil_araddr(SDRAM_s_axil_araddr),
    .s_axil_arprot(SDRAM_s_axil_arprot),
    .s_axil_arvalid(SDRAM_s_axil_arvalid),
    .s_axil_arready(SDRAM_s_axil_arready),
    .s_axil_rdata(SDRAM_s_axil_rdata),
    .s_axil_rresp(SDRAM_s_axil_rresp),
    .s_axil_rvalid(SDRAM_s_axil_rvalid),
    .s_axil_rready(SDRAM_s_axil_rready)
);   

logic sd_cs;
logic [ADDR_WIDTH-1:0] SDC_s_axil_awaddr;
logic [2:0]            SDC_s_axil_awprot;
logic                  SDC_s_axil_awvalid;
logic                  SDC_s_axil_awready;
logic [DATA_WIDTH-1:0] SDC_s_axil_wdata;
logic [STRB_WIDTH-1:0] SDC_s_axil_wstrb;
logic                  SDC_s_axil_wvalid;
logic                  SDC_s_axil_wready;
logic [1:0]            SDC_s_axil_bresp;
logic                  SDC_s_axil_bvalid;
logic                  SDC_s_axil_bready;
logic [ADDR_WIDTH-1:0] SDC_s_axil_araddr;
logic [2:0]            SDC_s_axil_arprot;
logic                  SDC_s_axil_arvalid;
logic                  SDC_s_axil_arready;
logic[DATA_WIDTH-1:0]  SDC_s_axil_rdata;
logic[1:0]             SDC_s_axil_rresp;
logic                  SDC_s_axil_rvalid;
logic                  SDC_s_axil_rready;
assign sd_d[3] = sd_cs;

sd_card_reader #(
	.OFFSET('h8000_0000)
) SDCard (
	.miso(sd_d[0]),
	.sclk(sd_clk),
	.cs(sd_cs),
	.mosi(sd_cmd),

	.aclk(clk_50mhz),
	.aresetn(resetn),
	.s_axil_awaddr(SDC_s_axil_awaddr),
	.s_axil_awprot(SDC_s_axil_awprot),
	.s_axil_awvalid(SDC_s_axil_awvalid),
	.s_axil_awready(SDC_s_axil_awready),
	.s_axil_wdata(SDC_s_axil_wdata),
	.s_axil_wstrb(SDC_s_axil_wstrb),
	.s_axil_wvalid(SDC_s_axil_wvalid),
	.s_axil_wready(SDC_s_axil_wready),
	.s_axil_bresp(SDC_s_axil_bresp),
	.s_axil_bvalid(SDC_s_axil_bvalid),
	.s_axil_bready(SDC_s_axil_bready),
	.s_axil_araddr(SDC_s_axil_araddr),
	.s_axil_arprot(SDC_s_axil_arprot),
	.s_axil_arvalid(SDC_s_axil_arvalid),
	.s_axil_arready(SDC_s_axil_arready),
	.s_axil_rdata(SDC_s_axil_rdata),
	.s_axil_rresp(SDC_s_axil_rresp),
	.s_axil_rvalid(SDC_s_axil_rvalid),
	.s_axil_rready(SDC_s_axil_rready)
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


GraphicSystem GraphicSystem 
(
	.clk25Mhz(clk_25mhz),
	.cpuClk(clk_50mhz),
	.reset(~resetn),
	.gpdiDp(gpdi_dp),
	.hdmi_pixClk(hdmi_pixClk),
	.aclk(clk_50mhz),
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

logic[31:0] CONT_s_axil_rdata;
logic[1:0] 	CONT_s_axil_rresp;
logic 		CONT_s_axil_rvalid;
logic 		CONT_s_axil_rready;
logic[31:0] CONT_s_axil_awaddr;
logic[1:0] 	CONT_s_axil_awprot;
logic 		CONT_s_axil_awvalid;
logic[31:0] CONT_s_axil_wdata;
logic[3:0] 	CONT_s_axil_wstrb;
logic 		CONT_s_axil_wvalid;
logic 		CONT_s_axil_bready;
logic[31:0] CONT_s_axil_araddr;
logic[1:0] 	CONT_s_axil_arprot;
logic 		CONT_s_axil_arvalid;

logic[31:0] CONT_true_rdata;
`ifdef NO_CONTROLLER_ATTACHED
assign CONT_true_rdata = {btn[2], btn[6], btn[5], btn[4], btn[3], 3'b0, btn[1]};
`else
assign CONT_true_rdata = CONT_s_axil_rdata;
`endif

//This should be replaced by the Audiosystems' 32 kHz clock
logic[8:0] 	CONT_clkdiv;
logic 		CONT_clk;
assign 		CONT_clk = CONT_clkdiv[8];
always_ff @(posedge clk_50mhz) begin
	CONT_clkdiv <= CONT_clkdiv + 1;

	if(!resetn) begin
		CONT_clkdiv <= 0;
	end
end


Controller Controller 
(
	.clk(CONT_clk),
	.aclk(clk_50mhz),
	.aresetn(resetn),
	.s_axil_rdata(CONT_s_axil_rdata),
	.s_axil_rresp(CONT_s_axil_rresp),
	.s_axil_rvalid(CONT_s_axil_rvalid),
	.s_axil_rready(CONT_s_axil_rready),
	
	.cont0_data(c1data),
	.cont0_clk(c1clock),
	.cont0_activate(c1latch),
	.cont1_data(c2data),
	.cont1_clk(c2clock),
	.cont1_activate(c2latch)
);
              
      
logic[ADDR_WIDTH-1:0]  BOOT_s_axil_awaddr;
logic[2:0]             BOOT_s_axil_awprot;
logic                  BOOT_s_axil_awvalid;
logic                  BOOT_s_axil_awready;
logic[DATA_WIDTH-1:0]  BOOT_s_axil_wdata;
logic[STRB_WIDTH-1:0]  BOOT_s_axil_wstrb;
logic                  BOOT_s_axil_wvalid;
logic                  BOOT_s_axil_wready;
logic                  BOOT_s_axil_bvalid;
logic                  BOOT_s_axil_bready;
logic[ADDR_WIDTH-1:0]  BOOT_s_axil_araddr;
logic[2:0]             BOOT_s_axil_arprot;
logic                  BOOT_s_axil_arvalid;
logic                  BOOT_s_axil_arready;
logic[DATA_WIDTH-1:0]  BOOT_s_axil_rdata;
logic[1:0]             BOOT_s_axil_rresp;     
logic                  BOOT_s_axil_rvalid;
logic                  BOOT_s_axil_rready;
AXILiteMemory #(
	.OFFSET(BOOTLOADER_START),
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH), 
    .STRB_WIDTH(STRB_WIDTH),
    .MEMORY_DEPTH(8192) //In 32-Bit words   
) Bootloader (
    .aclk(clk_50mhz),  
    .aresetn(resetn),
    .s_axil_awaddr(BOOT_s_axil_awaddr),
    .s_axil_awprot(BOOT_s_axil_awprot),
    .s_axil_awvalid(BOOT_s_axil_awvalid),
    .s_axil_awready(BOOT_s_axil_awready),
    .s_axil_wdata(BOOT_s_axil_wdata),
    .s_axil_wstrb(BOOT_s_axil_wstrb),
    .s_axil_wvalid(BOOT_s_axil_wvalid),
    .s_axil_wready(BOOT_s_axil_wready),
    .s_axil_bvalid(BOOT_s_axil_bvalid),
    .s_axil_bready(BOOT_s_axil_bready),
    .s_axil_araddr(BOOT_s_axil_araddr),
    .s_axil_arprot(BOOT_s_axil_arprot),
    .s_axil_arvalid(BOOT_s_axil_arvalid),
    .s_axil_arready(BOOT_s_axil_arready),
    .s_axil_rdata(BOOT_s_axil_rdata),
    .s_axil_rresp(BOOT_s_axil_rresp),
    .s_axil_rvalid(BOOT_s_axil_rvalid),
    .s_axil_rready(BOOT_s_axil_rready)
);
 
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
//{ICPU, DCPU, Graphicsystem}
assign AXI_s_axil_awaddr 	= 	{ICPU_mem_axi_awaddr	, DCPU_mem_axi_awaddr	, GS_m_axil_awaddr}	;
assign AXI_s_axil_awprot 	= 	{ICPU_mem_axi_awprot	, DCPU_mem_axi_awprot	, GS_m_axil_awprot}	;
assign AXI_s_axil_awvalid 	= 	{ICPU_mem_axi_awvalid	, DCPU_mem_axi_awvalid	, GS_m_axil_awvalid};
assign 							{ICPU_mem_axi_awready	, DCPU_mem_axi_awready	, GS_m_axil_awready} 	= AXI_s_axil_awready;
assign AXI_s_axil_wdata 	= 	{ICPU_mem_axi_wdata		, DCPU_mem_axi_wdata	, GS_m_axil_wdata}	;
assign AXI_s_axil_wstrb 	= 	{ICPU_mem_axi_wstrb		, DCPU_mem_axi_wstrb	, GS_m_axil_wstrb}	;
assign AXI_s_axil_wvalid 	= 	{ICPU_mem_axi_wvalid	, DCPU_mem_axi_wvalid	, GS_m_axil_wvalid}	;
assign 							{ICPU_mem_axi_wready	, DCPU_mem_axi_wready	, GS_m_axil_wready} 	= AXI_s_axil_wready;
assign 							{ICPU_mem_axi_bresp		, DCPU_mem_axi_bresp	, GS_m_axil_bresp} 		= AXI_s_axil_bresp;
assign 							{ICPU_mem_axi_bvalid	, DCPU_mem_axi_bvalid	, GS_m_axil_bvalid} 	= AXI_s_axil_bvalid;
assign AXI_s_axil_bready 	= 	{ICPU_mem_axi_bready	, DCPU_mem_axi_bready	, GS_m_axil_bready}	;
assign AXI_s_axil_araddr 	= 	{ICPU_mem_axi_araddr	, DCPU_mem_axi_araddr	, GS_m_axil_araddr}	;
assign AXI_s_axil_arprot 	= 	{ICPU_mem_axi_arprot	, DCPU_mem_axi_arprot	, GS_m_axil_arprot}	;
assign AXI_s_axil_arvalid 	= 	{ICPU_mem_axi_arvalid	, DCPU_mem_axi_arvalid	, GS_m_axil_arvalid};
assign 							{ICPU_mem_axi_arready	, DCPU_mem_axi_arready	, GS_m_axil_arready} 	= AXI_s_axil_arready;
assign 							{ICPU_mem_axi_rdata		, DCPU_mem_axi_rdata	, GS_m_axil_rdata} 		= AXI_s_axil_rdata;
assign 							{ICPU_mem_axi_rresp		, DCPU_mem_axi_rresp	, GS_m_axil_rresp} 		= AXI_s_axil_rresp;
assign 							{ICPU_mem_axi_rvalid	, DCPU_mem_axi_rvalid	, GS_m_axil_rvalid} 	= AXI_s_axil_rvalid;
assign AXI_s_axil_rready 	= 	{ICPU_mem_axi_rready	, DCPU_mem_axi_rready	, GS_m_axil_rready}	;

//SLAVE MAP
//{SDRAM, Graphicsystem, Bootloader, Controrller, SDCard}
assign 							{SDRAM_s_axil_awaddr, 	GS_s_axil_awaddr, 	BOOT_s_axil_awaddr,		CONT_s_axil_awaddr, SDC_s_axil_awaddr} = AXI_m_axil_awaddr;
assign 							{SDRAM_s_axil_awprot, 	GS_s_axil_awprot, 	BOOT_s_axil_awprot, 	CONT_s_axil_awprot,	SDC_s_axil_awprot} = AXI_m_axil_awprot;
assign 							{SDRAM_s_axil_awvalid, 	GS_s_axil_awvalid, 	BOOT_s_axil_awvalid,	CONT_s_axil_awvalid,SDC_s_axil_awvalid} = AXI_m_axil_awvalid;
assign AXI_m_axil_awready 	= 	{SDRAM_s_axil_awready, 	GS_s_axil_awready, 	BOOT_s_axil_awready,	1'b0,				SDC_s_axil_awready};
assign 							{SDRAM_s_axil_wdata, 	GS_s_axil_wdata, 	BOOT_s_axil_wdata, 		CONT_s_axil_wdata,	SDC_s_axil_wdata} = AXI_m_axil_wdata;
assign 							{SDRAM_s_axil_wstrb, 	GS_s_axil_wstrb, 	BOOT_s_axil_wstrb, 		CONT_s_axil_wstrb,	SDC_s_axil_wstrb} = AXI_m_axil_wstrb;
assign 							{SDRAM_s_axil_wvalid, 	GS_s_axil_wvalid, 	BOOT_s_axil_wvalid, 	CONT_s_axil_wvalid,	SDC_s_axil_wvalid} = AXI_m_axil_wvalid;
assign AXI_m_axil_wready 	= 	{SDRAM_s_axil_wready, 	GS_s_axil_wready, 	BOOT_s_axil_wready, 	1'b0,				SDC_s_axil_wready};
assign AXI_m_axil_bresp	 	= 	{2'b0, 					GS_s_axil_bresp, 	2'b0, 					2'b0,				SDC_s_axil_bresp};
assign AXI_m_axil_bvalid 	= 	{SDRAM_s_axil_bvalid, 	GS_s_axil_bvalid, 	BOOT_s_axil_bvalid, 	1'b0,				SDC_s_axil_bvalid};
assign 							{SDRAM_s_axil_bready, 	GS_s_axil_bready, 	BOOT_s_axil_bready, 	CONT_s_axil_bready,	SDC_s_axil_bready} = AXI_m_axil_bready;
assign 							{SDRAM_s_axil_araddr, 	GS_s_axil_araddr, 	BOOT_s_axil_araddr, 	CONT_s_axil_araddr,	SDC_s_axil_araddr} = AXI_m_axil_araddr;
assign 							{SDRAM_s_axil_arprot, 	GS_s_axil_arprot, 	BOOT_s_axil_arprot, 	CONT_s_axil_arprot,	SDC_s_axil_arprot} = AXI_m_axil_arprot;
assign 							{SDRAM_s_axil_arvalid,	GS_s_axil_arvalid, 	BOOT_s_axil_arvalid,	CONT_s_axil_arvalid,SDC_s_axil_arvalid} = AXI_m_axil_arvalid;
assign AXI_m_axil_arready 	= 	{SDRAM_s_axil_arready, 	GS_s_axil_arready, 	BOOT_s_axil_arready,	1'b1,				SDC_s_axil_arready};
assign AXI_m_axil_rdata 	= 	{SDRAM_s_axil_rdata, 	GS_s_axil_rdata, 	BOOT_s_axil_rdata, 		CONT_true_rdata, 	SDC_s_axil_rdata};
assign AXI_m_axil_rresp 	= 	{SDRAM_s_axil_rresp, 	GS_s_axil_rresp, 	BOOT_s_axil_rresp, 		CONT_s_axil_rresp, 	SDC_s_axil_rresp};
assign AXI_m_axil_rvalid 	= 	{SDRAM_s_axil_rvalid, 	GS_s_axil_rvalid, 	BOOT_s_axil_rvalid, 	CONT_s_axil_rvalid, SDC_s_axil_rvalid};
assign 							{SDRAM_s_axil_rready, 	GS_s_axil_rready, 	BOOT_s_axil_rready, 	CONT_s_axil_rready, SDC_s_axil_rready} = AXI_m_axil_rready;
   
axil_crossbar #(
	.S_COUNT(S_COUNT),
	.M_COUNT(M_COUNT),
	.DATA_WIDTH(DATA_WIDTH),
	.ADDR_WIDTH(ADDR_WIDTH),
	.STRB_WIDTH(STRB_WIDTH),
	.M_BASE_ADDR(M_BASE_ADDR),
	.M_ADDR_WIDTH(M_ADDR_WIDTH)
)
AxiCrossbar 
(
	.clk(clk_50mhz),
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
