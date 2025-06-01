module VexRiscvAxiLite #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = ADDR_WIDTH / 8
)(
    input aclk,
    input aresetn,

    output logic[ADDR_WIDTH-1:0]             i_m_axil_awaddr,
    output logic[2:0]                        i_m_axil_awprot,
    output logic                             i_m_axil_awvalid,
    input logic                              i_m_axil_awready,
    output logic[DATA_WIDTH-1:0]             i_m_axil_wdata,
    output logic[STRB_WIDTH-1:0]             i_m_axil_wstrb,
    output logic                             i_m_axil_wvalid,
    input logic                              i_m_axil_wready,
    input logic [1:0]                        i_m_axil_bresp,
    input logic                              i_m_axil_bvalid,
    output logic                             i_m_axil_bready,
    output logic[ADDR_WIDTH-1:0]             i_m_axil_araddr,
    output logic[2:0]                        i_m_axil_arprot,
    output logic                             i_m_axil_arvalid,
    input logic                              i_m_axil_arready,
    input logic [DATA_WIDTH-1:0]             i_m_axil_rdata,
    input logic [1:0]                        i_m_axil_rresp,
    input logic                              i_m_axil_rvalid,
    output logic                             i_m_axil_rready,

    output logic[ADDR_WIDTH-1:0]             d_m_axil_awaddr,
    output logic[2:0]                        d_m_axil_awprot,
    output logic                             d_m_axil_awvalid,
    input logic                              d_m_axil_awready,
    output logic[DATA_WIDTH-1:0]             d_m_axil_wdata,
    output logic[STRB_WIDTH-1:0]             d_m_axil_wstrb,
    output logic                             d_m_axil_wvalid,
    input logic                              d_m_axil_wready,
    input logic [1:0]                        d_m_axil_bresp,
    input logic                              d_m_axil_bvalid,
    output logic                             d_m_axil_bready,
    output logic[ADDR_WIDTH-1:0]             d_m_axil_araddr,
    output logic[2:0]                        d_m_axil_arprot,
    output logic                             d_m_axil_arvalid,
    input logic                              d_m_axil_arready,
    input logic [DATA_WIDTH-1:0]             d_m_axil_rdata,
    input logic [1:0]                        d_m_axil_rresp,
    input logic                              d_m_axil_rvalid,
    output logic                             d_m_axil_rready
);
localparam AXI_ID_WIDTH = 1;

logic [AXI_ID_WIDTH-1:0]     i_s_axi_awid;
logic [ADDR_WIDTH-1:0]       i_s_axi_awaddr;
logic [7:0]                  i_s_axi_awlen;
logic [2:0]                  i_s_axi_awsize;
logic [1:0]                  i_s_axi_awburst;
logic                        i_s_axi_awlock;
logic [3:0]                  i_s_axi_awcache;
logic [2:0]                  i_s_axi_awprot;
logic                        i_s_axi_awvalid;
logic                        i_s_axi_awready;
logic [AXI_DATA_WIDTH-1:0]   i_s_axi_wdata;
logic [AXI_STRB_WIDTH-1:0]   i_s_axi_wstrb;
logic                        i_s_axi_wlast;
logic                        i_s_axi_wvalid;
logic                        i_s_axi_wready;
logic [AXI_ID_WIDTH-1:0]     i_s_axi_bid;
logic [1:0]                  i_s_axi_bresp;
logic                        i_s_axi_bvalid;
logic                        i_s_axi_bready;
logic [AXI_ID_WIDTH-1:0]     i_s_axi_arid;
logic [ADDR_WIDTH-1:0]       i_s_axi_araddr;
logic [7:0]                  i_s_axi_arlen;
logic [2:0]                  i_s_axi_arsize;
logic [1:0]                  i_s_axi_arburst;
logic                        i_s_axi_arlock;
logic [3:0]                  i_s_axi_arcache;
logic [2:0]                  i_s_axi_arprot;
logic                        i_s_axi_arvalid;
logic                        i_s_axi_arready;
logic [AXI_ID_WIDTH-1:0]     i_s_axi_rid;
logic [AXI_DATA_WIDTH-1:0]   i_s_axi_rdata;
logic [1:0]                  i_s_axi_rresp;
logic                        i_s_axi_rlast;
logic                        i_s_axi_rvalid;
logic                        i_s_axi_rready;

axi_axil_adapter IAdapter 
(
    .clk(aclk),
    .rst(aresetn), //Does this need to be negated???
    
    .s_axi_awid(i_s_axi_awid),
    .s_axi_awaddr(i_s_axi_awaddr),
    .s_axi_awlen(i_s_axi_awlen),
    .s_axi_awsize(i_s_axi_awsize),
    .s_axi_awburst(i_s_axi_awburst),
    .s_axi_awlock(i_s_axi_awlock),
    .s_axi_awcache(i_s_axi_awcache),
    .s_axi_awprot(i_s_axi_awprot),
    .s_axi_awvalid(i_s_axi_awvalid),
    .s_axi_awready(i_s_axi_awready),
    .s_axi_wdata(i_s_axi_wdata),
    .s_axi_wstrb(i_s_axi_wstrb),
    .s_axi_wlast(i_s_axi_wlast),
    .s_axi_wvalid(i_s_axi_wvalid),
    .s_axi_wready(i_s_axi_wready),
    .s_axi_bid(i_s_axi_bid),
    .s_axi_bresp(i_s_axi_bresp),
    .s_axi_bvalid(i_s_axi_bvalid),
    .s_axi_bready(i_s_axi_bready),
    .s_axi_arid(i_s_axi_arid),
    .s_axi_araddr(i_s_axi_araddr),
    .s_axi_arlen(i_s_axi_arlen),
    .s_axi_arsize(i_s_axi_arsize),
    .s_axi_arburst(i_s_axi_arburst),
    .s_axi_arlock(i_s_axi_arlock),
    .s_axi_arcache(i_s_axi_arcache),
    .s_axi_arprot(i_s_axi_arprot),
    .s_axi_arvalid(i_s_axi_arvalid),
    .s_axi_arready(i_s_axi_arready),
    .s_axi_rid(i_s_axi_rid),
    .s_axi_rdata(i_s_axi_rdata),
    .s_axi_rresp(i_s_axi_rresp),
    .s_axi_rlast(i_s_axi_rlast),
    .s_axi_rvalid(i_s_axi_rvalid),
    .s_axi_rready(i_s_axi_rready),
    
    .m_axil_awaddr(i_m_axil_awaddr),
    .m_axil_awprot(i_m_axil_awprot),
    .m_axil_awvalid(i_m_axil_awvalid),
    .m_axil_awready(i_m_axil_awready),
    .m_axil_wdata(i_m_axil_wdata),
    .m_axil_wstrb(i_m_axil_wstrb),
    .m_axil_wvalid(i_m_axil_wvalid),
    .m_axil_wready(i_m_axil_wready),
    .m_axil_bresp(i_m_axil_bresp),
    .m_axil_bvalid(i_m_axil_bvalid),
    .m_axil_bready(i_m_axil_bready),
    .m_axil_araddr(i_m_axil_araddr),
    .m_axil_arprot(i_m_axil_arprot),
    .m_axil_arvalid(i_m_axil_arvalid),
    .m_axil_arready(i_m_axil_arready),
    .m_axil_rdata(i_m_axil_rdata),
    .m_axil_rresp(i_m_axil_rresp),
    .m_axil_rvalid(i_m_axil_rvalid),
    .m_axil_rready(i_m_axil_rready)
);


logic [AXI_ID_WIDTH-1:0]     d_s_axi_awid;
logic [ADDR_WIDTH-1:0]       d_s_axi_awaddr;
logic [7:0]                  d_s_axi_awlen;
logic [2:0]                  d_s_axi_awsize;
logic [1:0]                  d_s_axi_awburst;
logic                        d_s_axi_awlock;
logic [3:0]                  d_s_axi_awcache;
logic [2:0]                  d_s_axi_awprot;
logic                        d_s_axi_awvalid;
logic                        d_s_axi_awready;
logic [AXI_DATA_WIDTH-1:0]   d_s_axi_wdata;
logic [AXI_STRB_WIDTH-1:0]   d_s_axi_wstrb;
logic                        d_s_axi_wlast;
logic                        d_s_axi_wvalid;
logic                        d_s_axi_wready;
logic [AXI_ID_WIDTH-1:0]     d_s_axi_bid;
logic [1:0]                  d_s_axi_bresp;
logic                        d_s_axi_bvalid;
logic                        d_s_axi_bready;
logic [AXI_ID_WIDTH-1:0]     d_s_axi_arid;
logic [ADDR_WIDTH-1:0]       d_s_axi_araddr;
logic [7:0]                  d_s_axi_arlen;
logic [2:0]                  d_s_axi_arsize;
logic [1:0]                  d_s_axi_arburst;
logic                        d_s_axi_arlock;
logic [3:0]                  d_s_axi_arcache;
logic [2:0]                  d_s_axi_arprot;
logic                        d_s_axi_arvalid;
logic                        d_s_axi_arready;
logic [AXI_ID_WIDTH-1:0]     d_s_axi_rid;
logic [AXI_DATA_WIDTH-1:0]   d_s_axi_rdata;
logic [1:0]                  d_s_axi_rresp;
logic                        d_s_axi_rlast;
logic                        d_s_axi_rvalid;
logic                        d_s_axi_rready;

axi_axil_adapter DAdapter 
(
    .clk(aclk),
    .rst(aresetn), //Does this need to be negated???
    
    .s_axi_awid(d_s_axi_awid),
    .s_axi_awaddr(d_s_axi_awaddr),
    .s_axi_awlen(d_s_axi_awlen),
    .s_axi_awsize(d_s_axi_awsize),
    .s_axi_awburst(d_s_axi_awburst),
    .s_axi_awlock(d_s_axi_awlock),
    .s_axi_awcache(d_s_axi_awcache),
    .s_axi_awprot(d_s_axi_awprot),
    .s_axi_awvalid(d_s_axi_awvalid),
    .s_axi_awready(d_s_axi_awready),
    .s_axi_wdata(d_s_axi_wdata),
    .s_axi_wstrb(d_s_axi_wstrb),
    .s_axi_wlast(d_s_axi_wlast),
    .s_axi_wvalid(d_s_axi_wvalid),
    .s_axi_wready(d_s_axi_wready),
    .s_axi_bid(d_s_axi_bid),
    .s_axi_bresp(d_s_axi_bresp),
    .s_axi_bvalid(d_s_axi_bvalid),
    .s_axi_bready(d_s_axi_bready),
    .s_axi_arid(d_s_axi_arid),
    .s_axi_araddr(d_s_axi_araddr),
    .s_axi_arlen(d_s_axi_arlen),
    .s_axi_arsize(d_s_axi_arsize),
    .s_axi_arburst(d_s_axi_arburst),
    .s_axi_arlock(d_s_axi_arlock),
    .s_axi_arcache(d_s_axi_arcache),
    .s_axi_arprot(d_s_axi_arprot),
    .s_axi_arvalid(d_s_axi_arvalid),
    .s_axi_arready(d_s_axi_arready),
    .s_axi_rid(d_s_axi_rid),
    .s_axi_rdata(d_s_axi_rdata),
    .s_axi_rresp(d_s_axi_rresp),
    .s_axi_rlast(d_s_axi_rlast),
    .s_axi_rvalid(d_s_axi_rvalid),
    .s_axi_rready(d_s_axi_rready),
    
    .m_axil_awaddr(i_m_axil_awaddr),
    .m_axil_awprot(i_m_axil_awprot),
    .m_axil_awvalid(i_m_axil_awvalid),
    .m_axil_awready(i_m_axil_awready),
    .m_axil_wdata(i_m_axil_wdata),
    .m_axil_wstrb(i_m_axil_wstrb),
    .m_axil_wvalid(i_m_axil_wvalid),
    .m_axil_wready(i_m_axil_wready),
    .m_axil_bresp(i_m_axil_bresp),
    .m_axil_bvalid(i_m_axil_bvalid),
    .m_axil_bready(i_m_axil_bready),
    .m_axil_araddr(i_m_axil_araddr),
    .m_axil_arprot(i_m_axil_arprot),
    .m_axil_arvalid(i_m_axil_arvalid),
    .m_axil_arready(i_m_axil_arready),
    .m_axil_rdata(i_m_axil_rdata),
    .m_axil_rresp(i_m_axil_rresp),
    .m_axil_rvalid(i_m_axil_rvalid),
    .m_axil_rready(i_m_axil_rready)
);

VexRiscvAxi4 #(
    .PROGADDR_RESET(32'h0201_0000)
) VexCPU (
    .timerInterrupt(?),
    .externalInterrupt(?),
    .softwareInterrupt(?),
    .debug_bus_cmd_valid(?),
    .debug_bus_cmd_ready(?),
    .debug_bus_cmd_payload_wr(?),
    .debug_bus_cmd_payload_address(?),
    .debug_bus_cmd_payload_data(?),
    .debug_bus_rsp_data(?),
    .debug_resetOut(?),
    
    .iBusAxi_ar_valid(i_s_axi_arvalid),
    .iBusAxi_ar_ready(i_s_axi_arready),
    .iBusAxi_ar_payload_addr(i_s_axi_araddr),
    .iBusAxi_ar_payload_id(i_s_axi_arid),
    .iBusAxi_ar_payload_len(i_s_axi_arlen),
    .iBusAxi_ar_payload_size(i_s_axi_arsize),
    .iBusAxi_ar_payload_burst(i_s_axi_arburst),
    .iBusAxi_ar_payload_lock(i_s_axi_arlock),
    .iBusAxi_ar_payload_cache(i_s_axi_arcache),
    .iBusAxi_ar_payload_prot(i_s_axi_arprot),
    .iBusAxi_r_valid(i_s_axi_rvalid),
    .iBusAxi_r_ready(i_s_axi_rready),
    .iBusAxi_r_payload_data(i_s_axi_rdata),
    .iBusAxi_r_payload_id(i_s_axi_rid),
    .iBusAxi_r_payload_resp(i_s_axi_rresp),
    .iBusAxi_r_payload_last(i_s_axi_rlast),

    .dBusAxi_aw_valid(d_s_axi_awvalid),
    .dBusAxi_aw_ready(d_s_axi_awready),
    .dBusAxi_aw_payload_addr(d_s_axi_awaddr),
    .dBusAxi_aw_payload_id(d_s_axi_awid),
    .dBusAxi_aw_payload_len(d_s_axi_awlen),
    .dBusAxi_aw_payload_size(d_s_axi_awsize),
    .dBusAxi_aw_payload_burst(d_s_axi_awburst),
    .dBusAxi_aw_payload_lock(d_s_axi_awlock),
    .dBusAxi_aw_payload_cache(d_s_axi_awcache),
    .dBusAxi_aw_payload_prot(d_s_axi_awprot),
    .dBusAxi_w_valid(d_s_axi_wvalid),
    .dBusAxi_w_ready(d_s_axi_wready),
    .dBusAxi_w_payload_data(d_s_axi_wdata),
    .dBusAxi_w_payload_strb(d_s_axi_wstrb),
    .dBusAxi_w_payload_last(d_s_axi_wlast),
    .dBusAxi_b_valid(d_s_axi_bvalid),
    .dBusAxi_b_ready(d_s_axi_bready),
    .dBusAxi_b_payload_id(d_s_axi_bid),
    .dBusAxi_b_payload_resp(d_s_axi_bresp),
    .dBusAxi_ar_valid(d_s_axi_arvalid),
    .dBusAxi_ar_ready(d_s_axi_arready),
    .dBusAxi_ar_payload_addr(d_s_axi_araddr),
    .dBusAxi_ar_payload_id(d_s_axi_arid),
    .dBusAxi_ar_payload_len(d_s_axi_arlen),
    .dBusAxi_ar_payload_size(d_s_axi_arsize),
    .dBusAxi_ar_payload_burst(d_s_axi_arburst),
    .dBusAxi_ar_payload_lock(d_s_axi_arlock),
    .dBusAxi_ar_payload_cache(d_s_axi_arcache),
    .dBusAxi_ar_payload_prot(d_s_axi_arprot),
    .dBusAxi_r_valid(d_s_axi_rvalid),
    .dBusAxi_r_ready(d_s_axi_rready),
    .dBusAxi_r_payload_data(d_s_axi_rdata),
    .dBusAxi_r_payload_id(d_s_axi_rid),
    .dBusAxi_r_payload_resp(d_s_axi_rresp),
    .dBusAxi_r_payload_last(d_s_axi_rlast),
    .clk(aclk),
    .reset(aresetn),
    .debugReset()
);
    
endmodule