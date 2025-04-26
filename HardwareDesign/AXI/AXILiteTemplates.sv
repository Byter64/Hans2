//This module gives copy and paste templates for:
//- Axi Lite slave interface
//- Axi Lite master interface
//- Axi Lite sender logic
//- Axi Lite receiver logic
//--------------------------------------
//The "T" in the logic tempaltes has to be replaced to the prefix of the according AXI channel (either aw, w, b, r or rd)

module AXILiteTemplates (
    input logic                              aclk,
    input logic                              aresetn,

    /*
     * AXI lite slave interfaces
     */
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

    /*
     * AXI lite master interfaces
     */
    output logic[ADDR_WIDTH-1:0]             m_axil_awaddr,
    output logic[2:0]                        m_axil_awprot,
    output logic                             m_axil_awvalid,
    input logic                              m_axil_awready,
    output logic[DATA_WIDTH-1:0]             m_axil_wdata,
    output logic[STRB_WIDTH-1:0]             m_axil_wstrb,
    output logic                             m_axil_wvalid,
    input logic                              m_axil_wready,
    input logic [1:0]                        m_axil_bresp,
    input logic                              m_axil_bvalid,
    output logic                             m_axil_bready,
    output logic[ADDR_WIDTH-1:0]             m_axil_araddr,
    output logic[2:0]                        m_axil_arprot,
    output logic                             m_axil_arvalid,
    input logic                              m_axil_arready,
    input logic [DATA_WIDTH-1:0]             m_axil_rdata,
    input logic [1:0]                        m_axil_rresp,
    input logic                              m_axil_rvalid,
    output logic                             m_axil_rready
);

//##############################################
//####Templates for the receiver of a signal####
//##############################################
always_ff @(posedge aclk) begin
		// Logic to determine S_AXIS_TREADY
end

always_ff @(posedge aclk) begin
	if (s_axil_Tvalid && s_axil_Tready) begin //Never add any other conditions. This is likely to break axi
		// Do something
    end
end

//##############################################
//#####Templates for the sender of a signal#####
//##############################################
logic next_Tvalid; //Assign your valid logic to this signal
logic[DATA_WIDTH-1:0] next_Tdata; //Assign the data to this signal
always_ff @(posedge aclk) begin
	if (!aresetn)
		m_axil_Tvalid <= 0;
	else if (!m_axil_Tvalid || m_axil_Tready) begin
		m_axil_Tvalid <= next_Tvalid;
    end
end

always_ff @(posedge aclk) begin
	if (!aresetn)
		m_axil_Tdata <= 0;
	else if (!m_axil_Tvalid || m_axil_Tready)
	begin
		m_axil_Tdata <= next_Tdata;

		if (!next_Tvalid)
			m_axil_Tdata <= 0;
	end
end
endmodule