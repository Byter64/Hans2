module AXILite_SDRAM (
    input logic clk_133mhz,

    //SDRAM
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

    input logic                              aclk,
    input logic                              aresetn,
    
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
);


sdram_controller AXILiteSDRAM 
(
    //Host Interface
    .wr_addr(),
    .wr_data(),
    .wr_enable(),
    .rd_addr(),
    .rd_data(),
    .rd_ready(),
    .rd_enable(),
    .busy(),
    .rst_n(),
    .clk(), //Expects 133 MHz
    // SDRAM Interface
    .addr(sdram_a),
    .bank_addr(sdram_ba),
    .data(sdram_d),
    .clock_enable(sdram_cke),
    .cs_n(sdram_csn),
    .ras_n(sdram_rasn),
    .cas_n(sdram_casn),
    .we_n(sdram_wen),
    .data_mask_low(sdram_dqm[0]),
    .data_mask_high(sdram_dqm[1])
);
    
endmodule