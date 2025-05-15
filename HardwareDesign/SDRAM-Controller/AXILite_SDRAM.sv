module AXILite_SDRAM #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = DATA_WIDTH / 8
)
(
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
    input logic                              s_axil_rready
);

logic        clk_i;
logic        rst_i;
logic        inport_awvalid_i;
logic [31:0] inport_awaddr_i;
logic [ 3:0] inport_awid_i;
logic [ 7:0] inport_awlen_i;
logic [ 1:0] inport_awburst_i;
logic        inport_wvalid_i;
logic [31:0] inport_wdata_i;
logic [ 3:0] inport_wstrb_i;
logic        inport_wlast_i;
logic        inport_bready_i;
logic        inport_arvalid_i;
logic [31:0] inport_araddr_i;
logic [ 3:0] inport_arid_i;
logic [ 7:0] inport_arlen_i;
logic [ 1:0] inport_arburst_i;
logic        inport_rready_i;
logic [15:0] sdram_data_input_i;
logic        inport_awready_o;
logic        inport_wready_o;
logic        inport_bvalid_o;
logic [ 1:0] inport_bresp_o;
logic [ 3:0] inport_bid_o;
logic        inport_arready_o;
logic        inport_rvalid_o;
logic [31:0] inport_rdata_o;
logic [ 1:0] inport_rresp_o;
logic [ 3:0] inport_rid_o;
logic        inport_rlast_o;
logic        sdram_clk_o;
logic        sdram_cke_o;
logic        sdram_cs_o;
logic        sdram_ras_o;
logic        sdram_cas_o;
logic        sdram_we_o;
logic [ 1:0] sdram_dqm_o;
logic [12:0] sdram_addr_o;
logic [ 1:0] sdram_ba_o;
logic [15:0] sdram_data_output_o;
logic        sdram_data_out_en_o;

sdram_axi sdram_axi 
(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .inport_awvalid_i(inport_awvalid_i),
    .inport_awaddr_i(inport_awaddr_i),
    .inport_awid_i(inport_awid_i),
    .inport_awlen_i(inport_awlen_i),
    .inport_awburst_i(inport_awburst_i),
    .inport_wvalid_i(inport_wvalid_i),
    .inport_wdata_i(inport_wdata_i),
    .inport_wstrb_i(inport_wstrb_i),
    .inport_wlast_i(inport_wlast_i),
    .inport_bready_i(inport_bready_i),
    .inport_arvalid_i(inport_arvalid_i),
    .inport_araddr_i(inport_araddr_i),
    .inport_arid_i(inport_arid_i),
    .inport_arlen_i(inport_arlen_i),
    .inport_arburst_i(inport_arburst_i),
    .inport_rready_i(inport_rready_i),
    .sdram_data_input_i(sdram_data_input_i),
    .inport_awready_o(inport_awready_o),
    .inport_wready_o(inport_wready_o),
    .inport_bvalid_o(inport_bvalid_o),
    .inport_bresp_o(inport_bresp_o),
    .inport_bid_o(inport_bid_o),
    .inport_arready_o(inport_arready_o),
    .inport_rvalid_o(inport_rvalid_o),
    .inport_rdata_o(inport_rdata_o),
    .inport_rresp_o(inport_rresp_o),
    .inport_rid_o(inport_rid_o),
    .inport_rlast_o(inport_rlast_o),
    .sdram_clk_o(sdram_clk_o),
    .sdram_cke_o(sdram_cke_o),
    .sdram_cs_o(sdram_cs_o),
    .sdram_ras_o(sdram_ras_o),
    .sdram_cas_o(sdram_cas_o),
    .sdram_we_o(sdram_we_o),
    .sdram_dqm_o(sdram_dqm_o),
    .sdram_addr_o(sdram_addr_o),
    .sdram_ba_o(sdram_ba_o),
    .sdram_data_output_o(sdram_data_output_o),
    .sdram_data_out_en_o(sdram_data_out_en_o)
);

//SDRAM signals
assign sdram_cke    = sdram_cke_o;
assign sdram_csn    = !sdram_cs_o;
assign sdram_wen    = !sdram_we_o;
assign sdram_rasn   = !sdram_ras_o;
assign sdram_casn   = !sdram_cas_o;
assign sdram_a      = sdram_addr_o;
assign sdram_ba     = sdram_ba_o;
assign sdram_dqm    = sdram_dqm_o;

//controller inputs
assign clk_i = aclk;
assign rst_i = !aresetn;
assign inport_awvalid_i = s_axil_awvalid;
assign inport_awaddr_i = s_axil_awaddr;
assign inport_awid_i = 0;
assign inport_awlen_i = 0;
assign inport_awburst_i = 1;
assign inport_wvalid_i = s_axil_wvalid;
assign inport_wdata_i = s_axil_wdata;
assign inport_wstrb_i = s_axil_wstrb;
assign inport_wlast_i = 1;
assign inport_bready_i = s_axil_bready;
assign inport_arvalid_i = s_axil_arvalid;
assign inport_araddr_i = s_axil_araddr;
assign inport_arid_i = 0;
assign inport_arlen_i = 0;
assign inport_arburst_i = 1;
assign inport_rready_i = s_axil_rready;

//Controller outputss
assign s_axil_awready = inport_awready_o;
assign s_axil_wready = inport_wready_o;
assign s_axil_bvalid = inport_bvalid_o;
assign s_axil_bresp = inport_bresp_o;
//inport_bid_o
assign s_axil_arready = inport_arready_o;
assign s_axil_rvalid = inport_rvalid_o;
assign s_axil_rdata = inport_rdata_o;
assign s_axil_rresp = inport_rresp_o;
//inport_rid_o
//inport_rlast_o

ODDRX1F  
#(
    //.DDR_ALIGNMENT("NONE"),
    //.INIT(1'b0),
    //.SRTYPE("SYNC")
)
u_clock_delay
(
    .Q(sdram_clk),
    .SCLK(clk_i),
    .RST(1'b0),
    .D0(1'b0),
    .D1(1'b1)
);

genvar i;
for (i=0; i < 16; i = i + 1) 
begin
  TRELLIS_IO 
  #(
    //.DRIVE(12),
    //.IOSTANDARD("LVTTL"),
    //.SLEWRATE("FAST")
  )
  u_data_buf
  (
    .O(sdram_data_input_i[i]),
    .B(sdram_d[i]),
    .I(sdram_data_output_o[i]),
    .T(~sdram_data_out_en_o)
  );
end

endmodule