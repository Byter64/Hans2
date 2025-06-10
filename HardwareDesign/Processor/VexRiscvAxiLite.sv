module VexRiscvAxiLite #(
    parameter PROGADDR_RESET = 32'h02010000
) (
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
    logic        i_axi_ar_valid;
    logic        i_axi_ar_ready;
    logic [31:0] i_axi_ar_addr;
    logic  [0:0] i_axi_ar_id;
    logic  [3:0] i_axi_ar_region;
    logic  [7:0] i_axi_ar_len;
    logic  [2:0] i_axi_ar_size;
    logic  [1:0] i_axi_ar_burst;
    logic        i_axi_ar_lock;
    logic  [3:0] i_axi_ar_cache;
    logic  [3:0] i_axi_ar_qos;
    logic  [2:0] i_axi_ar_prot;
    logic        i_axi_r_valid;
    logic        i_axi_r_ready;
    logic [31:0] i_axi_r_data;
    logic  [0:0] i_axi_r_id;
    logic  [1:0] i_axi_r_resp;
    logic        i_axi_r_last;

    // Data AXI4 signals
    logic        d_axi_ar_valid;
    logic        d_axi_ar_ready;
    logic [31:0] d_axi_ar_addr;
    logic        d_axi_ar_id;
    logic  [3:0] d_axi_ar_region;
    logic  [7:0] d_axi_ar_len;
    logic  [2:0] d_axi_ar_size;
    logic  [1:0] d_axi_ar_burst;
    logic        d_axi_ar_lock;
    logic  [3:0] d_axi_ar_cache;
    logic  [3:0] d_axi_ar_qos;
    logic  [2:0] d_axi_ar_prot;
    logic        d_axi_r_valid;
    logic        d_axi_r_ready;
    logic [31:0] d_axi_r_data;
    logic        d_axi_r_id;
    logic  [1:0] d_axi_r_resp;
    logic        d_axi_r_last;

    logic        d_axi_aw_valid;
    logic        d_axi_aw_ready;
    logic [31:0] d_axi_aw_addr;
    logic  [0:0] d_axi_aw_id;
    logic  [3:0] d_axi_aw_region;
    logic  [7:0] d_axi_aw_len;
    logic  [2:0] d_axi_aw_size;
    logic  [1:0] d_axi_aw_burst;
    logic        d_axi_aw_lock;
    logic  [3:0] d_axi_aw_cache;
    logic  [3:0] d_axi_aw_qos;
    logic  [2:0] d_axi_aw_prot;
    logic        d_axi_w_valid;
    logic        d_axi_w_ready;
    logic [31:0] d_axi_w_data;
    logic  [3:0] d_axi_w_strb;
    logic        d_axi_w_last;
    logic        d_axi_b_valid;
    logic        d_axi_b_ready;
    logic  [0:0] d_axi_b_id;
    logic  [1:0] d_axi_b_resp;

    // Remove the axi_axil_adapter instantiations and replace with mkaxi2axil_bridge

    // Instruction AXI4 to AXI4-Lite Bridge
    mkaxi2axil_bridge IBridge (
        .CLK(aclk),
        .RST_N(aresetn),

        // AXI4 Instruction (from VexRiscv)
        .AXI4_ARVALID(i_axi_ar_valid),
        .AXI4_ARADDR(i_axi_ar_addr),
        .AXI4_ARLEN(i_axi_ar_len),
        .AXI4_ARSIZE(i_axi_ar_size),
        .AXI4_ARBURST(i_axi_ar_burst),
        .AXI4_ARLOCK(i_axi_ar_lock),
        .AXI4_ARCACHE(i_axi_ar_cache),
        .AXI4_ARPROT(i_axi_ar_prot),
        .AXI4_ARQOS(i_axi_ar_qos),
        .AXI4_ARREGION(i_axi_ar_region),
        .AXI4_ARREADY(i_axi_ar_ready),

        .AXI4_RVALID(i_axi_r_valid),
        .AXI4_RDATA(i_axi_r_data),
        .AXI4_RRESP(i_axi_r_resp),
        .AXI4_RLAST(i_axi_r_last),
        .AXI4_RREADY(i_axi_r_ready),

        .AXI4_AWVALID(), // Not used for instruction
        .AXI4_AWADDR(32'b0),
        .AXI4_AWLEN(8'b0),
        .AXI4_AWSIZE(3'b0),
        .AXI4_AWBURST(2'b0),
        .AXI4_AWLOCK(1'b0),
        .AXI4_AWCACHE(4'b0),
        .AXI4_AWPROT(3'b0),
        .AXI4_AWQOS(4'b0),
        .AXI4_AWREGION(4'b0),
        .AXI4_AWREADY(),

        .AXI4_WVALID(1'b0),
        .AXI4_WDATA(32'b0),
        .AXI4_WSTRB(4'b0),
        .AXI4_WLAST(1'b0),
        .AXI4_WREADY(),

        .AXI4_BVALID(),
        .AXI4_BRESP(),
        .AXI4_BREADY(1'b0),

        // AXI4-Lite Master (Instruction)
        .AXI4L_ARVALID(i_m_axil_arvalid),
        .AXI4L_ARADDR(i_m_axil_araddr),
        .AXI4L_ARPROT(i_m_axil_arprot),
        .AXI4L_ARREADY(i_m_axil_arready),
        .AXI4L_RVALID(i_m_axil_rvalid),
        .AXI4L_RRESP(i_m_axil_rresp),
        .AXI4L_RDATA(i_m_axil_rdata),
        .AXI4L_RREADY(i_m_axil_rready),

        .AXI4L_AWVALID(),
        .AXI4L_AWADDR(),
        .AXI4L_AWPROT(),
        .AXI4L_AWREADY(),
        .AXI4L_WVALID(),
        .AXI4L_WDATA(),
        .AXI4L_WSTRB(),
        .AXI4L_WREADY(),
        .AXI4L_BVALID(),
        .AXI4L_BRESP(),
        .AXI4L_BREADY()
    );

    // Data AXI4 to AXI4-Lite Bridge
    mkaxi2axil_bridge DBridge (
        .CLK(aclk),
        .RST_N(aresetn),

        // AXI4 Data (from VexRiscv)
        .AXI4_AWVALID(d_axi_aw_valid),
        .AXI4_AWADDR(d_axi_aw_addr),
        .AXI4_AWLEN(d_axi_aw_len),
        .AXI4_AWSIZE(d_axi_aw_size),
        .AXI4_AWBURST(d_axi_aw_burst),
        .AXI4_AWLOCK(d_axi_aw_lock),
        .AXI4_AWCACHE(d_axi_aw_cache),
        .AXI4_AWPROT(d_axi_aw_prot),
        .AXI4_AWQOS(d_axi_aw_qos),
        .AXI4_AWREGION(d_axi_aw_region),
        .AXI4_AWREADY(d_axi_aw_ready),

        .AXI4_WVALID(d_axi_w_valid),
        .AXI4_WDATA(d_axi_w_data),
        .AXI4_WSTRB(d_axi_w_strb),
        .AXI4_WLAST(d_axi_w_last),
        .AXI4_WREADY(d_axi_w_ready),

        .AXI4_BVALID(d_axi_b_valid),
        .AXI4_BRESP(d_axi_b_resp),
        .AXI4_BREADY(d_axi_b_ready),

        .AXI4_ARVALID(d_axi_ar_valid),
        .AXI4_ARADDR(d_axi_ar_addr),
        .AXI4_ARLEN(d_axi_ar_len),
        .AXI4_ARSIZE(d_axi_ar_size),
        .AXI4_ARBURST(d_axi_ar_burst),
        .AXI4_ARLOCK(d_axi_ar_lock),
        .AXI4_ARCACHE(d_axi_ar_cache),
        .AXI4_ARPROT(d_axi_ar_prot),
        .AXI4_ARQOS(d_axi_ar_qos),
        .AXI4_ARREGION(d_axi_ar_region),
        .AXI4_ARREADY(d_axi_ar_ready),

        .AXI4_RVALID(d_axi_r_valid),
        .AXI4_RDATA(d_axi_r_data),
        .AXI4_RRESP(d_axi_r_resp),
        .AXI4_RLAST(d_axi_r_last),
        .AXI4_RREADY(d_axi_r_ready),

        // AXI4-Lite Master (Data)
        .AXI4L_AWVALID(d_m_axil_awvalid),
        .AXI4L_AWADDR(d_m_axil_awaddr),
        .AXI4L_AWPROT(d_m_axil_awprot),
        .AXI4L_AWREADY(d_m_axil_awready),
        .AXI4L_WVALID(d_m_axil_wvalid),
        .AXI4L_WDATA(d_m_axil_wdata),
        .AXI4L_WSTRB(d_m_axil_wstrb),
        .AXI4L_WREADY(d_m_axil_wready),
        .AXI4L_BVALID(d_m_axil_bvalid),
        .AXI4L_BRESP(d_m_axil_bresp),
        .AXI4L_BREADY(d_m_axil_bready),
        .AXI4L_ARVALID(d_m_axil_arvalid),
        .AXI4L_ARADDR(d_m_axil_araddr),
        .AXI4L_ARPROT(d_m_axil_arprot),
        .AXI4L_ARREADY(d_m_axil_arready),
        .AXI4L_RVALID(d_m_axil_rvalid),
        .AXI4L_RRESP(d_m_axil_rresp),
        .AXI4L_RDATA(d_m_axil_rdata),
        .AXI4L_RREADY(d_m_axil_rready)
    );

    // VexRiscvAxi4 instance
    VexRiscvAxi4 #(
        .PROGADDR_RESET(PROGADDR_RESET)
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