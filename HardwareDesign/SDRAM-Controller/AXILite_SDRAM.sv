module AXILite_SDRAM #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = DATA_WIDTH / 8
)
(
    //SDRAM

    input logic clk_130mhz,
    input logic resetn,
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
    output logic [1:0]                       s_axil_bresp = 0,
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

logic[31:0] axi_write_data;
logic[31:0] axi_read_data;

typedef enum logic[1:0] 
{ 
    IDLE            = 2'b00,
    READ            = 2'b01,
    WRITE           = 2'b10,
    WAIT_ACKNOWLEDGE= 2'b11
} Action;

typedef enum logic[1:0] 
{ 
    NONE            = 2'b00,
    HALF_WORD       = 2'b01,
    WORD_0          = 2'b10,
    WORD_1          = 2'b11
} Type;

Action action = IDLE;
Action next_action;

Type address_type = NONE;
Type next_address_type;

logic[24:0] address;
logic[15:0] write_data;
logic       write_enable;
logic[15:0] read_data;
logic[31:0] read_data_full;
logic       read_enable;
logic       read_ready;
logic       is_busy;
sdram_controller SDRAM_Controller 
(
    //Host Interface
    .wr_addr(address[24:1]),
    .wr_data(write_data),
    .wr_enable(write_enable), //This may need to be synced
    .rd_addr(address[24:1]),
    .rd_data(read_data),
    .rd_ready(read_ready), //This must be synced
    .rd_enable(read_enable), //This may need to be synced
    .busy(is_busy),
    .rst_n(resetn),
    .clk(clk_130mhz), //Expects 133 MHz
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

logic read_ready_slow;
logic read_ready_old;
logic read_ready_trigger;
always_ff @(posedge clk_130mhz) read_ready_old <= read_ready;
always_ff @(posedge clk_130mhz) if(read_ready_old == 0 && read_ready) read_ready_trigger <= 1
                                else if(read_ready_slow == 1) read_ready_trigger <= 0;
always_ff @(posedge aclk) if(read_ready_trigger) read_ready_slow <= 1 else read_ready_slow <= 0;

assign write_data = next_address_type == WORD_1 ? axi_write_data[31:16] : axi_write_data[15:0];

always_ff @(posedge clk_130mhz) begin
    if (address_type == WORD_1)
        read_data_full[31:16] <= read_data;
    if(address_type == WORD_0 || address_type == HALF_WORD)
        read_data_full[15:0] <= read_data;
end

always_comb begin
    next_action = action;
    case (action)
        IDLE: begin
            if (!is_busy) begin
                if(s_axil_wvalid && s_axil_wready) begin
                    next_action = WRITE;
                end else if (s_axil_rready) begin
                    next_action = READ;
                end
            end
        end
        WRITE: begin
            if(address_type == HALF_WORD || address_type == WORD_1) begin
                next_action = IDLE;
            end
        end
        READ: begin
            if((address_type == HALF_WORD || address_type == WORD_1) && read_ready_slow) begin
                next_action = IDLE;
            end
        end
    endcase

    if(!resetn) next_action = IDLE; 
end

always @(*) begin
    next_address_type = address_type; 
    case (address_type)
        NONE: begin
            if(next_action != IDLE) begin
                case (address[1:0])
                    2'b00 : next_address_type = WORD_0;
                    //2'b00 : next_action = ??;
                    2'b10 : next_address_type = HALF_WORD;
                    //2'b00 : next_action = ??;
                endcase
            end
        end
        HALF_WORD: begin
            if(action != READ || read_ready_slow)
                next_address_type = NONE;
        end
        WORD_0: begin
            if(!is_busy && (action != READ || read_ready_slow)) begin
                next_address_type = WORD_1;
            end
        end
        WORD_1: begin
            if(action != READ || read_ready_slow) begin
                next_address_type = NONE;
            end
        end
    endcase

    if(!resetn) begin 
        next_address_type = NONE;
    end
end

always_ff @(posedge aclk) begin
    action <= next_action;
    address_type <= next_address_type;
end

always_ff @(posedge aclk) begin
    write_enable <= 0;
    read_enable <= 0;

    //control signals for the SDRAM-Controller
    if(action == IDLE && next_action == WRITE) begin
        write_enable <= 1;
    end else if (action == WRITE && next_address_type == WORD_1) begin
        write_enable <= 1;
    end

    //control signals for the SDRAM-Controller
    if(action == IDLE && next_action == READ) begin
        read_enable <= 1;
    end else if (action == READ && next_address_type == WORD_1) begin
        read_enable <= 1;
    end
end

//Address Write
logic[24:0] write_address;
logic[24:0] read_address;
logic[24:0] write_address_real;
logic[24:0] read_address_real;
assign write_address_real = s_axil_awvalid && s_axil_awready ? s_axil_awaddr : write_address;
always @(posedge aclk) begin
	s_axil_awready <= 1;
end

always @(posedge aclk) begin
	if (s_axil_awvalid && s_axil_awready) begin //Never add any other conditions. This is likely to break axi
		write_address <= s_axil_awaddr[24:0];
    end
end

//Write
always @(posedge aclk) begin
		s_axil_wready <= action == IDLE;
end

 
always @(posedge aclk) begin
    if (s_axil_wvalid && s_axil_wready) begin //Never add any other conditions. This is likely to break axi
        axi_write_data <= s_axil_wdata;
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
assign read_address_real = s_axil_arvalid && s_axil_arready ? s_axil_araddr : read_address;
always @(posedge aclk) begin
		s_axil_arready <= 1;
end

always @(posedge aclk) begin
	if (s_axil_arvalid && s_axil_arready) begin //Never add any other conditions. This is likely to break axi
		read_address <= s_axil_araddr[24:0];
    end
end

//Read
//This is not AXI compliant, but I could not think of a better way to invalidate s_axil_rdata if address is written at the sime time as data is read
assign s_axil_rvalid = !aresetn ? 0 : !(s_axil_arvalid && s_axil_arready) && !is_busy;


always @(posedge aclk) begin
	if (!aresetn)
		s_axil_rdata <= 0;
	else if (!s_axil_rvalid || s_axil_rready)
	begin
    s_axil_rdata <= read_data;
	end
end
    
assign address = action == WRITE ? write_address_real : read_address_real;

endmodule