module Audiosystem_Test (
    input logic clk_25mhz,
    output logic audio_bclk,
    output logic audio_lrclk,
    output logic audio_dout
);


logic clk;
logic clk_25mhz;
logic rst;

//CPU Interface
logic[23:0] registerData;
logic[3:0] registerSelect;
logic[7:0] channelSelect;
    
//Memory Interface (AXI Lite Master)
logic           aclk;
logic           aresetn;
logic [31:0]    m_axil_awaddr;
logic [2:0]     m_axil_awprot;
logic           m_axil_awvalid;
logic           m_axil_awready;

logic [15:0]    m_axil_wdata;
logic [1:0]     m_axil_wstrb;
logic           m_axil_wvalid;
logic           m_axil_wready;

logic  [1:0]    m_axil_bresp;
logic           m_axil_bvalid;
logic           m_axil_bready;

logic [31:0]    m_axil_araddr;
logic [2:0]     m_axil_arprot;
logic           m_axil_arvalid;
logic           m_axil_arready;

logic  [15:0]   m_axil_rdata;
logic  [1:0]    m_axil_rresp;
logic           m_axil_rvalid;
logic           m_axil_rready;

Audiosystem Audiosystem 
(
    .*
);

AXILiteMemory #(
    .DATA_WIDTH(16),
    .MEMORY_DEPTH(239616)
) AXILiteMemory (
    .aclk(aclk),
    .aresetn(aresetn),

    .s_axil_awvalid(m_axil_awaddr),
    .s_axil_awaddr(m_axil_awprot),
    .s_axil_awprot(m_axil_awvalid),
    .s_axil_awready(m_axil_awready),
    .s_axil_wdata(m_axil_wdata),
    .s_axil_wstrb(m_axil_wstrb),
    .s_axil_wvalid(m_axil_wvalid),
    .s_axil_wready(m_axil_wready),
    .s_axil_bresp(m_axil_bresp),
    .s_axil_bvalid(m_axil_bvalid),
    .s_axil_bready(m_axil_bready),
    .s_axil_araddr(m_axil_araddr),
    .s_axil_arprot(m_axil_arprot),
    .s_axil_arvalid(m_axil_arvalid),
    .s_axil_arready(m_axil_arready),
    .s_axil_rdata(m_axil_rdata),
    .s_axil_rresp(m_axil_rresp),
    .s_axil_rvalid(m_axil_rvalid),
    .s_axil_rready(m_axil_rready)
    
);


endmodule