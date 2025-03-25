//This module gives copy and paste templates for:
//- Axi Lite slave interface
//- Axi Lite master interface
//- Axi Lite sender logic
//- Axi Lite receiver logic
//--------------------------------------
//The "T" in the logic tempaltes has to be replaced to the prefix of the according AXI channel (either aw, w, b, r or rd)

module AXILiteTemplates (
    input                               aclk,
    input                               arst,

    /*
     * AXI lite slave interfaces
     */
    input  [ADDR_WIDTH-1:0]             s_axil_awaddr,
    input  [2:0]                        s_axil_awprot,
    input                               s_axil_awvalid,
    output                              s_axil_awready,
    input  [DATA_WIDTH-1:0]             s_axil_wdata,
    input  [STRB_WIDTH-1:0]             s_axil_wstrb,
    input                               s_axil_wvalid,
    output                              s_axil_wready,
    output [1:0]                        s_axil_bresp,
    output                              s_axil_bvalid,
    input                               s_axil_bready,
    input  [ADDR_WIDTH-1:0]             s_axil_araddr,
    input  [2:0]                        s_axil_arprot,
    input                               s_axil_arvalid,
    output                              s_axil_arready,
    output [DATA_WIDTH-1:0]             s_axil_rdata,
    output [1:0]                        s_axil_rresp,
    output                              s_axil_rvalid,
    input                               s_axil_rready,

    /*
     * AXI lite master interfaces
     */
    output [ADDR_WIDTH-1:0]             m_axil_awaddr,
    output [2:0]                        m_axil_awprot,
    output                              m_axil_awvalid,
    input                               m_axil_awready,
    output [DATA_WIDTH-1:0]             m_axil_wdata,
    output [STRB_WIDTH-1:0]             m_axil_wstrb,
    output                              m_axil_wvalid,
    input                               m_axil_wready,
    input  [1:0]                        m_axil_bresp,
    input                               m_axil_bvalid,
    output                              m_axil_bready,
    output [ADDR_WIDTH-1:0]             m_axil_araddr,
    output [2:0]                        m_axil_arprot,
    output                              m_axil_arvalid,
    input                               m_axil_arready,
    input  [DATA_WIDTH-1:0]             m_axil_rdata,
    input  [1:0]                        m_axil_rresp,
    input                               m_axil_rvalid,
    output                              m_axil_rready
);

//##############################################
//####Templates for the receiver of a signal####
//##############################################
always @(posedge aclk) begin
		// Logic to determine S_AXIS_TREADY
end

always @(posedge aclk) begin
	if (s_axil_Tvalid && s_axil_Tready) begin //Never add any other conditions. This is likely to break axi
		// Do something
    end
end

//##############################################
//#####Templates for the sender of a signal#####
//##############################################
logic next_Tvalid; //Assign your valid logic to this signal
logic[DATA_WIDTH-1:0] next_TData; //Assign the data here
always @(posedge aclk) begin
	if (!aresetn)
		m_axil_Tvalid <= 0;
	else if (!m_axil_Tvalid || m_axil_Tready) begin
		m_axil_Tvalid <= next_Tvalid;
    end
end

always @(posedge aclk) begin
	if (!aresetn)
		m_axil_Tdata <= 0;
	else if (!m_axil_Tvalid || m_axil_Tready)
	begin
		m_axil_Tdata <= next_TData;

		if (!next_Tvalid)
			m_axil_Tdata <= 0;
	end
end
endmodule