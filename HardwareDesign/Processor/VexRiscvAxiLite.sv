module VexRiscvAxiLite (
    input aclk,
    input aresetn,

    output logic[31:0]             i_m_axil_araddr,
    output logic[2:0]              i_m_axil_arprot,
    output logic                   i_m_axil_arvalid,
    input logic                    i_m_axil_arready,
    input logic [31:0]             i_m_axil_rdata,
    input logic [1:0]              i_m_axil_rresp,
    input logic                    i_m_axil_rvalid,
    output logic                   i_m_axil_rready,

    output logic[31:0]             d_m_axil_awaddr,
    output logic[2:0]              d_m_axil_awprot,
    output logic                   d_m_axil_awvalid,
    input logic                    d_m_axil_awready,
    output logic[31:0]             d_m_axil_wdata,
    output logic[3:0]              d_m_axil_wstrb,
    output logic                   d_m_axil_wvalid,
    input logic                    d_m_axil_wready,
    input logic [1:0]              d_m_axil_bresp,
    input logic                    d_m_axil_bvalid,
    output logic                   d_m_axil_bready,
    output logic[31:0]             d_m_axil_araddr,
    output logic[2:0]              d_m_axil_arprot,
    output logic                   d_m_axil_arvalid,
    input logic                    d_m_axil_arready,
    input logic [31:0]             d_m_axil_rdata,
    input logic [1:0]              d_m_axil_rresp,
    input logic                    d_m_axil_rvalid,
    output logic                   d_m_axil_rready
);

    // Instruction AXI4 signals
    logic        i_axi_ar_valid, i_axi_ar_ready;
    logic [31:0] i_axi_ar_addr;
    logic  [7:0] i_axi_ar_id;
    logic  [3:0] i_axi_ar_region;
    logic  [7:0] i_axi_ar_len;
    logic  [2:0] i_axi_ar_size;
    logic  [1:0] i_axi_ar_burst;
    logic        i_axi_ar_lock;
    logic  [3:0] i_axi_ar_cache;
    logic  [3:0] i_axi_ar_qos;
    logic  [2:0] i_axi_ar_prot;
    logic        i_axi_r_valid, i_axi_r_ready;
    logic [31:0] i_axi_r_data;
    logic  [7:0] i_axi_r_id;
    logic  [1:0] i_axi_r_resp;
    logic        i_axi_r_last;

    // Data AXI4 signals
    logic        d_axi_ar_valid, d_axi_ar_ready;
    logic [31:0] d_axi_ar_addr;
    logic  [7:0] d_axi_ar_id;
    logic  [7:0] d_axi_ar_region;
    logic  [7:0] d_axi_ar_len;
    logic  [2:0] d_axi_ar_size;
    logic  [1:0] d_axi_ar_burst;
    logic        d_axi_ar_lock;
    logic  [3:0] d_axi_ar_cache;
    logic  [7:0] d_axi_ar_qos;
    logic  [2:0] d_axi_ar_prot;
    logic        d_axi_r_valid, d_axi_r_ready;
    logic [31:0] d_axi_r_data;
    logic        d_axi_r_id;
    logic  [1:0] d_axi_r_resp;
    logic        d_axi_r_last;

    logic        d_axi_aw_valid, d_axi_aw_ready;
    logic [31:0] d_axi_aw_addr;
    logic  [7:0] d_axi_aw_id;
    logic  [7:0] d_axi_aw_region;
    logic  [7:0] d_axi_aw_len;
    logic  [2:0] d_axi_aw_size;
    logic  [1:0] d_axi_aw_burst;
    logic        d_axi_aw_lock;
    logic  [3:0] d_axi_aw_cache;
    logic  [7:0] d_axi_aw_qos;
    logic  [2:0] d_axi_aw_prot;
    logic        d_axi_w_valid, d_axi_w_ready;
    logic [31:0] d_axi_w_data;
    logic  [3:0] d_axi_w_strb;
    logic        d_axi_w_last;
    logic        d_axi_b_valid, d_axi_b_ready;
    logic  [7:0] d_axi_b_id;
    logic  [1:0] d_axi_b_resp;

axi_axil_adapter_rd IAdapter 
(
    .clk(aclk),
    .rst(~aresetn),

    .s_axi_arid(i_axi_ar_id),
    .s_axi_araddr(i_axi_ar_addr),
    .s_axi_arlen(i_axi_ar_len),
    .s_axi_arsize(i_axi_ar_size),
    .s_axi_arburst(i_axi_ar_burst),
    .s_axi_arlock(i_axi_ar_lock),
    .s_axi_arcache(i_axi_ar_cache),
    .s_axi_arprot(i_axi_ar_prot),
    .s_axi_arvalid(i_axi_ar_valid),
    .s_axi_arready(i_axi_ar_ready),
    .s_axi_rid(i_axi_r_id),
    .s_axi_rdata(i_axi_r_data),
    .s_axi_rresp(i_axi_r_resp),
    .s_axi_rlast(i_axi_r_last),
    .s_axi_rvalid(i_axi_r_valid),
    .s_axi_rready(i_axi_r_ready),

    .m_axil_araddr(i_m_axil_araddr),
    .m_axil_arprot(i_m_axil_arprot),
    .m_axil_arvalid(i_m_axil_arvalid),
    .m_axil_arready(i_m_axil_arready),
    .m_axil_rdata(i_m_axil_rdata),
    .m_axil_rresp(i_m_axil_rresp),
    .m_axil_rvalid(i_m_axil_rvalid),
    .m_axil_rready(i_m_axil_rready)
);

axi_axil_adapter DAdapter 
(
    .clk(aclk),
    .rst(~aresetn),

    .s_axi_awid(d_axi_aw_id),
    .s_axi_awaddr(d_axi_aw_addr),
    .s_axi_awlen(d_axi_aw_len),
    .s_axi_awsize(d_axi_aw_size),
    .s_axi_awburst(d_axi_aw_burst),
    .s_axi_awlock(d_axi_aw_lock),
    .s_axi_awcache(d_axi_aw_cache),
    .s_axi_awprot(d_axi_aw_prot),
    .s_axi_awvalid(d_axi_aw_valid),
    .s_axi_awready(d_axi_aw_ready),
    .s_axi_wdata(d_axi_w_data),
    .s_axi_wstrb(d_axi_w_strb),
    .s_axi_wlast(d_axi_w_last),
    .s_axi_wvalid(d_axi_w_valid),
    .s_axi_wready(d_axi_w_ready),
    .s_axi_bid(d_axi_b_id),
    .s_axi_bresp(d_axi_b_resp),
    .s_axi_bvalid(d_axi_b_valid),
    .s_axi_bready(d_axi_b_ready),
    .s_axi_arid(d_axi_ar_id),
    .s_axi_araddr(d_axi_ar_addr),
    .s_axi_arlen(d_axi_ar_len),
    .s_axi_arsize(d_axi_ar_size),
    .s_axi_arburst(d_axi_ar_burst),
    .s_axi_arlock(d_axi_ar_lock),
    .s_axi_arcache(d_axi_ar_cache),
    .s_axi_arprot(d_axi_ar_prot),
    .s_axi_arvalid(d_axi_ar_valid),
    .s_axi_arready(d_axi_ar_ready),
    .s_axi_rid(d_axi_r_id),
    .s_axi_rdata(d_axi_r_data),
    .s_axi_rresp(d_axi_r_resp),
    .s_axi_rlast(d_axi_r_last),
    .s_axi_rvalid(d_axi_r_valid),
    .s_axi_rready(d_axi_r_ready),

    .m_axil_awaddr(d_m_axil_awaddr),
    .m_axil_awprot(d_m_axil_awprot),
    .m_axil_awvalid(d_m_axil_awvalid),
    .m_axil_awready(d_m_axil_awready),
    .m_axil_wdata(d_m_axil_wdata),
    .m_axil_wstrb(d_m_axil_wstrb),
    .m_axil_wvalid(d_m_axil_wvalid),
    .m_axil_wready(d_m_axil_wready),
    .m_axil_bresp(d_m_axil_bresp),
    .m_axil_bvalid(d_m_axil_bvalid),
    .m_axil_bready(d_m_axil_bready),
    .m_axil_araddr(d_m_axil_araddr),
    .m_axil_arprot(d_m_axil_arprot),
    .m_axil_arvalid(d_m_axil_arvalid),
    .m_axil_arready(d_m_axil_rready),
    .m_axil_rdata(d_m_axil_rdata),
    .m_axil_rresp(d_m_axil_rresp),
    .m_axil_rvalid(d_m_axil_rvalid),
    .m_axil_rready(d_m_axil_rready)
);

    // VexRiscvAxi4 instance
    VexRiscvAxi4 #(
        .PROGADDR_RESET(32'h02010000)
    ) VexCPU (
        // Instruction AXI4
        .iBusAxi_ar_valid(i_axi_ar_valid),
        .iBusAxi_ar_ready(i_axi_ar_ready),
        .iBusAxi_ar_payload_addr(i_axi_ar_addr),
        .iBusAxi_ar_payload_id(i_axi_ar_id),
        .iBusAxi_ar_payload_region(i_axi_ar_region),
        .iBusAxi_ar_payload_len(i_axi_ar_len),
        .iBusAxi_ar_payload_size(i_axi_ar_size),
        .iBusAxi_ar_payload_burst(i_axi_ar_burst),
        .iBusAxi_ar_payload_lock(i_axi_ar_lock),
        .iBusAxi_ar_payload_cache(i_axi_ar_cache),
        .iBusAxi_ar_payload_qos(i_axi_ar_qos),
        .iBusAxi_ar_payload_prot(i_axi_ar_prot),
        .iBusAxi_r_valid(i_axi_r_valid),
        .iBusAxi_r_ready(i_axi_r_ready),
        .iBusAxi_r_payload_data(i_axi_r_data),
        .iBusAxi_r_payload_id(i_axi_r_id),
        .iBusAxi_r_payload_resp(i_axi_r_resp),
        .iBusAxi_r_payload_last(i_axi_r_last),

        // Data AXI4
        .dBusAxi_ar_valid(d_axi_ar_valid),
        .dBusAxi_ar_ready(d_axi_ar_ready),
        .dBusAxi_ar_payload_addr(d_axi_ar_addr),
        .dBusAxi_ar_payload_id(d_axi_ar_id),
        .dBusAxi_ar_payload_region(d_axi_ar_region),
        .dBusAxi_ar_payload_len(d_axi_ar_len),
        .dBusAxi_ar_payload_size(d_axi_ar_size),
        .dBusAxi_ar_payload_burst(d_axi_ar_burst),
        .dBusAxi_ar_payload_lock(d_axi_ar_lock),
        .dBusAxi_ar_payload_cache(d_axi_ar_cache),
        .dBusAxi_ar_payload_qos(d_axi_ar_qos),
        .dBusAxi_ar_payload_prot(d_axi_ar_prot),
        .dBusAxi_r_valid(d_axi_r_valid),
        .dBusAxi_r_ready(d_axi_r_ready),
        .dBusAxi_r_payload_data(d_axi_r_data),
        .dBusAxi_r_payload_id(d_axi_r_id),
        .dBusAxi_r_payload_resp(d_axi_r_resp),
        .dBusAxi_r_payload_last(d_axi_r_last),
        .dBusAxi_aw_valid(d_axi_aw_valid),
        .dBusAxi_aw_ready(d_axi_aw_ready),
        .dBusAxi_aw_payload_addr(d_axi_aw_addr),
        .dBusAxi_aw_payload_id(d_axi_aw_id),
        .dBusAxi_aw_payload_region(d_axi_aw_region),
        .dBusAxi_aw_payload_len(d_axi_aw_len),
        .dBusAxi_aw_payload_size(d_axi_aw_size),
        .dBusAxi_aw_payload_burst(d_axi_aw_burst),
        .dBusAxi_aw_payload_lock(d_axi_aw_lock),
        .dBusAxi_aw_payload_cache(d_axi_aw_cache),
        .dBusAxi_aw_payload_qos(d_axi_aw_qos),
        .dBusAxi_aw_payload_prot(d_axi_aw_prot),
        .dBusAxi_w_valid(d_axi_w_valid),
        .dBusAxi_w_ready(d_axi_w_ready),
        .dBusAxi_w_payload_data(d_axi_w_data),
        .dBusAxi_w_payload_strb(d_axi_w_strb),
        .dBusAxi_w_payload_last(d_axi_w_last),
        .dBusAxi_b_valid(d_axi_b_valid),
        .dBusAxi_b_ready(d_axi_b_ready),
        .dBusAxi_b_payload_id(d_axi_b_id),
        .dBusAxi_b_payload_resp(d_axi_b_resp),

        .clk(aclk),
        .reset(~aresetn)
    );
    
endmodule