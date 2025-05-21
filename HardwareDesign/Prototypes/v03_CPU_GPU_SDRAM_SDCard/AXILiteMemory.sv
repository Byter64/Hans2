//This memory does not use s_axil_wstrb!! You can't mask the writing data
//EDIT: uses s_axil_wstrb now :)
module AXILiteMemory #(
    parameter OFFSET = 0, //The address of the first byte in the bootloader
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
initial $readmemh("C:/Users/Yanni/Desktop/Hans2/HardwareDesign/Prototypes/v03_CPU_GPU_SDRAM_SDCard/Software/firmware32.hex", memory);

//Address Write
logic[ADDR_WIDTH-1:0] aw_address = 'b0;
logic[31:0] aw_address_real;
assign aw_address_real = (s_axil_awvalid && s_axil_awready ? s_axil_awaddr : aw_address) - OFFSET;
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
    if(s_axil_wstrb[0]) memory[aw_address_real[31:2]][7 -: 8] <= s_axil_wdata[7 -: 8];
    if(s_axil_wstrb[1]) memory[aw_address_real[31:2]][15 -: 8] <= s_axil_wdata[15 -: 8];
    if(s_axil_wstrb[2]) memory[aw_address_real[31:2]][23 -: 8] <= s_axil_wdata[23 -: 8];
    if(s_axil_wstrb[3]) memory[aw_address_real[31:2]][31 -: 8] <= s_axil_wdata[31 -: 8];
  end
end

//Write response
always @(posedge aclk) begin
	if (!aresetn)
		s_axil_bvalid <= 0;
	else if (!s_axil_bvalid || s_axil_bready) begin
		s_axil_bvalid <= 1;
  end
end

//Address Read
logic[ADDR_WIDTH-1:0] ar_address = 'b0;
logic[31:0] ar_address_real;
assign ar_address_real = (s_axil_arvalid && s_axil_arready ? s_axil_araddr : ar_address) - OFFSET;
always @(posedge aclk) begin
		s_axil_arready <= 1;
end

always @(posedge aclk) begin
	if (s_axil_arvalid && s_axil_arready) begin //Never add any other conditions. This is likely to break axi
		ar_address <= s_axil_araddr;
    end
end

//Read
//This is not AXI compliant, but I could not think of a better way to invalidate s_axil_rdata if address is written at the sime time as data is read
assign s_axil_rvalid = !aresetn ? 0 : !(s_axil_arvalid && s_axil_arready);

logic[31:0] read_data;
always @(*) begin
    case (ar_address_real[1:0])
      2'b00: s_axil_rdata = (read_data >>  0) & 'hFFFFFFFF;
      2'b01: s_axil_rdata = (read_data >>  8) & 'hFF;
      2'b10: s_axil_rdata = (read_data >> 16) & 'hFFFF;
      2'b11: s_axil_rdata = (read_data >> 24) & 'hFF;
    endcase
end


always @(posedge aclk) begin
	if (!aresetn)
		read_data <= 0;
	else if (!s_axil_rvalid || s_axil_rready)
	begin
    read_data <= memory[ar_address_real[31:2]];
	end
end
endmodule
