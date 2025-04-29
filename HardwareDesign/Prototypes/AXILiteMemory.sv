//This memory does not use s_axil_wstrb!! You can't mask the writing data
//EDIT: uses s_axil_wstrb now :)
module AXILiteMemory #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = DATA_WIDTH / 8,
    parameter MEMORY_DEPTH = 119808 //This is the whole available BRAM on the ecp5 85F
) (
    input  logic                         aclk,
    input  logic                         aresetn,

    input  logic[ADDR_WIDTH-1:0]         s_axil_awaddr,
    input  logic[2:0]                    s_axil_awprot,
    input  logic                         s_axil_awvalid,
    output logic                         s_axil_awready,

    input  logic[DATA_WIDTH-1:0]         s_axil_wdata,
    input  logic[STRB_WIDTH-1:0]         s_axil_wstrb,
    input  logic                         s_axil_wvalid,
    output logic                         s_axil_wready,

    output logic                         s_axil_bvalid,
    input  logic                         s_axil_bready,

    input  logic[ADDR_WIDTH-1:0]         s_axil_araddr,
    input  logic[2:0]                    s_axil_arprot,
    input  logic                         s_axil_arvalid,
    output logic                         s_axil_arready,

    output logic[DATA_WIDTH-1:0]         s_axil_rdata,
    output logic[1:0]                    s_axil_rresp,
    output logic                         s_axil_rvalid,
    input  logic                         s_axil_rready
);

logic[ADDR_WIDTH-1:0] memory[MEMORY_DEPTH];
//initial $readmemh("StereoTest.hex", memory); Wie kann ich außerhalb dieser Datei memory bespielen
//Address Write
logic[ADDR_WIDTH-1:0] aw_address = 'b0;
always @(posedge aclk) begin
		s_axil_awready <= 1;
end

always @(posedge aclk) begin
	if (s_axil_awvalid && s_axil_awready) begin //Never add any other conditions. This is likely to break axi
		aw_address <= s_axil_awaddr;
    end
end

//Write
always @(posedge aclk) begin
		s_axil_wready <= 1;
end

always @(posedge aclk) begin
	if (s_axil_wvalid && s_axil_wready) begin //Never add any other conditions. This is likely to break axi
    if(s_axil_wstrb[0]) memory[aw_address][7 -: 8] <= s_axil_wdata[7 -: 8];
    if(s_axil_wstrb[1]) memory[aw_address][15 -: 8] <= s_axil_wdata[15 -: 8];
    if(s_axil_wstrb[2]) memory[aw_address][23 -: 8] <= s_axil_wdata[23 -: 8];
    if(s_axil_wstrb[3]) memory[aw_address][31 -: 8] <= s_axil_wdata[31 -: 8];
  end
end

//Write response
logic next_bvalid; //Assign your valid logic to this signal
assign next_bvalid = 1;
always @(posedge aclk) begin
	if (!aresetn)
		s_axil_bvalid <= 0;
	else if (!s_axil_bvalid || s_axil_bready) begin
		s_axil_bvalid <= next_bvalid;
    end
end

//Address Read
logic[ADDR_WIDTH-1:0] ar_address = 'b0;
always @(posedge aclk) begin
		s_axil_arready <= 1;
end

always @(posedge aclk) begin
	if (s_axil_arvalid && s_axil_arready) begin //Never add any other conditions. This is likely to break axi
		ar_address <= s_axil_araddr;
    end
end

//Read
logic next_rvalid;
assign next_rvalid = 1;
always @(posedge aclk) begin
	if (!aresetn)
		s_axil_rvalid <= 0;
	else if (!s_axil_rvalid || s_axil_rready) begin
		s_axil_rvalid <= next_rvalid;
    end
end

always @(posedge aclk) begin
	if (!aresetn)
		s_axil_rdata <= 0;
	else if (!s_axil_rvalid || s_axil_rready)
	begin
		s_axil_rdata <= memory[ar_address];

		if (!next_rvalid)
			s_axil_rdata <= 0;
	end
end
endmodule
