//yosys -p"read_verilog ULX3S_hdmi\TMDS_encoder.v HDMI_Out.v GPU.v BufferController.v Framebuffer.v GraphicSystem.v; synth_ecp5 -json Ausgabe.json"

localparam DATA_WIDTH = 32;
localparam ADDR_WIDTH = 32;
localparam STRB_WIDTH = 4;

module GraphicSystem
(
    input clk25Mhz,
    input cpuClk,
    input reset,
    output[3:0] gpdiDp,
    output hdmi_pixClk,

    input logic                              aclk,
    input logic                              aresetn,
    //AXI-L SLAVE
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

    //AXI-L MASTER
    output logic[ADDR_WIDTH-1:0]             m_axil_araddr,
    output logic[2:0]                        m_axil_arprot,
    output logic                             m_axil_arvalid,
    input logic                              m_axil_arready,
    input logic [DATA_WIDTH-1:0]             m_axil_rdata,
    input logic [1:0]                        m_axil_rresp,
    input logic                              m_axil_rvalid,
    output logic                             m_axil_rready,

    output logic[15:0] ct_address,
    input  logic[15:0] ct_colour
);

typedef enum logic[7:0] {
    IMAGE_START             = 0,
    IMAGE_X                 = 4,
    IMAGE_Y                 = 8,
    IMAGE_WIDTH             = 12,
    IMAGE_SCALE_X           = 16,
    IMAGE_SCALE_Y           = 20,
    IMAGE_FLIP_X            = 24,
    IMAGE_FLIP_Y            = 28,
    COLOUR_TABLE_TYPE       = 32,
    COLOUR_TABLE_OFFSET     = 36,
    EXCERPT_WIDTH           = 40,
    EXCERPT_HEIGHT          = 44,
    SCREEN_X                = 48,
    SCREEN_Y                = 52,
    DRAW_COLOUR             = 56,
    DRAW_SHAPE              = 60,
    DRAW_COLOUR_SOURCE      = 64,
    COMMAND_DRAW            = 68,
    IS_BUSY                 = 72,

    VSYNC                   = 76,
    HSYNC                   = 80,

    COMMAND_SWAP_BUFFERS    = 84,
    VSYNC_BUFFER_SWAP       = 88
} DataIndex;

DataIndex activeWriteDataIndex;
DataIndex activeReadDataIndex;

logic[31:0]  image_start;
logic[15:0]  image_x;
logic[15:0]  image_y;
logic[15:0]  image_width;
logic[15:0]  image_scale_x;
logic[15:0]  image_scale_y;
logic        image_flip_x;
logic        image_flip_y;
CTType       ct_type;
logic        ct_enable;
logic[15:0]  ct_offset;
logic[15:0]  excerpt_width;
logic[15:0]  excerpt_height;
logic[15:0]  screen_x;
logic[15:0]  screen_y;
logic[15:0]  draw_colour;
Shape        draw_shape;
ColourSource draw_colour_source;
logic        command_draw;
logic        is_busy;
logic        vSync;
logic        hSync;
logic        swapBuffers;
logic        vSyncBufferSwap;

//START - AXI SLAVE IMPLEMENTATION

//Address write
always_ff @(posedge aclk) s_axil_awready <= 1;
always_ff @(posedge aclk) begin
	if (s_axil_awvalid && s_axil_awready) begin 
		activeWriteDataIndex <= DataIndex'(s_axil_awaddr);
    end
end

//Write
always_ff @(posedge aclk) s_axil_wready <= 1;

always_ff @(posedge aclk) begin
    command_draw <= 0;
    swapBuffers <= 0;

	if (s_axil_wvalid && s_axil_wready) begin
		case (activeWriteDataIndex)
            IMAGE_START         : image_start <= s_axil_wdata;
            IMAGE_X             : image_x <= s_axil_wdata;
            IMAGE_Y             : image_y <= s_axil_wdata;
            IMAGE_WIDTH         : image_width <= s_axil_wdata;
            IMAGE_SCALE_X       : image_scale_x <= s_axil_wdata;
            IMAGE_SCALE_Y       : image_scale_y <= s_axil_wdata;
            IMAGE_FLIP_X        : image_flip_x <= s_axil_wdata;
            IMAGE_FLIP_Y        : image_flip_y <= s_axil_wdata;
            COLOUR_TABLE_TYPE   : begin
                if(!s_axil_wdata[5])
                    {ct_enable, ct_type} <= {1'b0, BIT_16};
                else
                    {ct_enable, ct_type} <= s_axil_wdata;
            end
            COLOUR_TABLE_OFFSET : ct_offset <= s_axil_wdata;
            EXCERPT_WIDTH       : excerpt_width <= s_axil_wdata;
            EXCERPT_HEIGHT      : excerpt_height <= s_axil_wdata;
            SCREEN_X            : screen_x <= s_axil_wdata;
            SCREEN_Y            : screen_y <= s_axil_wdata;
            DRAW_COLOUR         : draw_colour <= s_axil_wdata;
            DRAW_SHAPE          : draw_shape <= Shape'(s_axil_wdata);
            DRAW_COLOUR_SOURCE  : draw_colour_source <= ColourSource'(s_axil_wdata);
            COMMAND_DRAW        : command_draw <= s_axil_wdata;
            COMMAND_SWAP_BUFFERS: swapBuffers <= s_axil_wdata;
            VSYNC_BUFFER_SWAP   : vSyncBufferSwap <= s_axil_wdata;
        endcase
    end

    if(reset) begin
        ct_enable <= 0;
        ct_type <= BIT_16;
        ct_offset <= 'h2000;
        draw_shape <= RECTANGLE;
        draw_colour_source <= MEMORY;
        image_width <= 1;
        image_start <= 'h2010000;
        image_flip_x <= 0;
        image_flip_y <= 0;
        image_scale_x <= 1;
        image_scale_y <= 1;
        image_x <= 0;
        image_y <= 0;
    end
end

//Write response
assign s_axil_bresp = 0;
always_ff @(posedge aclk) begin
	if (!aresetn)
		s_axil_bvalid <= 0;
	else if (!s_axil_bvalid || s_axil_bready) begin
		s_axil_bvalid <= 1;
    end
end

//Address read
always_ff @(posedge aclk) s_axil_arready <= 1;
always_ff @(posedge aclk) begin
	if (s_axil_arvalid && s_axil_arready) begin
		activeReadDataIndex <= DataIndex'(s_axil_araddr);
    end
end

//Read
logic[DATA_WIDTH-1:0] next_rdata;
logic old_s_ar_handshake;

always_ff @(posedge aclk) begin
    old_s_ar_handshake <= s_axil_arvalid && s_axil_arready;
end

assign s_axil_rresp = 1;

//This is not AXI compliant, but I could not think of a better way to invalidate s_axil_rdata if address is written at the sime time as data is read
assign s_axil_rvalid = !aresetn ? 0 : (!(s_axil_arvalid && s_axil_arready) && !old_s_ar_handshake);

always_comb begin
    case (activeReadDataIndex)
        IMAGE_START         : next_rdata = image_start;
        IMAGE_X             : next_rdata = image_x;
        IMAGE_Y             : next_rdata = image_y;
        IMAGE_WIDTH         : next_rdata = image_width;
        IMAGE_SCALE_X       : next_rdata = image_scale_x;
        IMAGE_SCALE_Y       : next_rdata = image_scale_y;
        IMAGE_FLIP_X        : next_rdata = image_flip_x;
        IMAGE_FLIP_Y        : next_rdata = image_flip_y;
        COLOUR_TABLE_TYPE   : next_rdata = {ct_enable, ct_type};
        COLOUR_TABLE_OFFSET : next_rdata = ct_offset;
        EXCERPT_WIDTH       : next_rdata = excerpt_width;
        EXCERPT_HEIGHT      : next_rdata = excerpt_height;
        SCREEN_X            : next_rdata = screen_x;
        SCREEN_Y            : next_rdata = screen_y;
        DRAW_COLOUR         : next_rdata = draw_colour;
        DRAW_SHAPE          : next_rdata = draw_shape;
        DRAW_COLOUR_SOURCE  : next_rdata = draw_colour_source;
        IS_BUSY             : next_rdata = is_busy;
        
        VSYNC: next_rdata = vSync;
        HSYNC: next_rdata = hSync;
        
        VSYNC_BUFFER_SWAP   : next_rdata = vSyncBufferSwap;

        VSYNC_BUFFER_SWAP: next_rdata = vSyncBufferSwap;
        default: next_rdata = 0;
    endcase
end

always_ff @(posedge aclk) begin
	if (!aresetn)
		s_axil_rdata <= 0;
	else if (!s_axil_rvalid || s_axil_rready)
	begin
		s_axil_rdata <= next_rdata;
	end
end
//END - AXI SLAVE IMPLEMENTATION

localparam SCREEN_WIDTH = 400;
localparam SCREEN_HEIGHT = 240;

wire[15:0]   gpu_fb_x;
wire[15:0]   gpu_fb_y;
wire[15:0]  gpu_fb_colour;
wire        gpu_fb_write;
wire[15:0]  hdmi_nextX;
wire[15:0]  hdmi_nextY;
wire        hdmi_hSync;
wire bfCont_fbGPU;
wire bfCont_fbHDMI;
wire[15:0]  fb2_dataOutA;
wire[15:0]  fb2_dataOutB;
wire[15:0]  fb1_dataOutA;
wire[15:0]  fb1_dataOutB;
wire[16:0] gpu_fbAddress = gpu_fb_x + gpu_fb_y * SCREEN_WIDTH;
`define ROTATE_FRAME_BUFFER
`ifdef ROTATE_FRAME_BUFFER
wire[16:0] hdmi_fbAddress = SCREEN_WIDTH - (hdmi_nextX / 2) + ((SCREEN_HEIGHT - (hdmi_nextY / 2)) * SCREEN_WIDTH); //this halves the resoluton from 480x800 to 240x400
`else 
wire[16:0] hdmi_fbAddress = (hdmi_nextX / 2) + ((hdmi_nextY / 2) * SCREEN_WIDTH); //this halves the resoluton from 480x800 to 240x400
`endif
wire[15:0] hdmi_color = bfCont_fbHDMI == 0 ? fb1_dataOutB : fb2_dataOutB;

BufferController bfCont(
    .clk(cpuClk),
    .reset(reset),
    .swapIn(swapBuffers),
    .vSync(vSync),
    .isSynchronized(vSyncBufferSwap),

    .fbGPU(bfCont_fbGPU),
    .fbHDMI(bfCont_fbHDMI)
);

Framebuffer #(
    .WIDTH(16),
    .DEPTH(SCREEN_HEIGHT * SCREEN_WIDTH)
) fb1 (
    .clkA(cpuClk),
    .dataInA(gpu_fb_colour),
    .addressA(gpu_fbAddress),
    .writeEnableA(bfCont_fbGPU == 1'b0 ? gpu_fb_write : 1'b0),

    .clkB(hdmi_pixClk),
    .dataInB(16'b0),
    .addressB(hdmi_fbAddress),
    .writeEnableB(1'b0),

    .dataOutA(fb1_dataOutA),
    .dataOutB(fb1_dataOutB)
);

Framebuffer #(
    .WIDTH(16),
    .DEPTH(SCREEN_HEIGHT * SCREEN_WIDTH)
) fb2 (
    .clkA(cpuClk),
    .dataInA(gpu_fb_colour),
    .addressA(gpu_fbAddress),
    .writeEnableA(bfCont_fbGPU == 1'b1 ? gpu_fb_write : 1'b0),

    .clkB(hdmi_pixClk),
    .dataInB(16'b0),
    .addressB(hdmi_fbAddress),
    .writeEnableB(1'b0),

    .dataOutA(fb2_dataOutA),
    .dataOutB(fb2_dataOutB)
);

GPU #(
    .FB_WIDTH(SCREEN_WIDTH),
    .FB_HEIGHT(SCREEN_HEIGHT)
) GPU (
    .clk(cpuClk),
    .rst(reset),
    
    .image_start(image_start),
    .image_x(image_x),
    .image_y(image_y),
    .image_width(image_width),
    .image_scale_x(image_scale_x),
    .image_scale_y(image_scale_y),
    .image_flip_x(image_flip_x),
    .image_flip_y(image_flip_y),
    .ct_type(ct_type),
    .ct_enable(ct_enable),
    .ct_offset(ct_offset),
    .excerpt_width(excerpt_width),
    .excerpt_height(excerpt_height),
    .screen_x(screen_x),
    .screen_y(screen_y),
    .draw_colour(draw_colour),
    .draw_shape(draw_shape),
    .draw_colour_source(draw_colour_source),
    .command_draw(command_draw),
    .is_busy(is_busy),

    .m_axil_araddr(m_axil_araddr),
    .m_axil_arprot(m_axil_arprot),
    .m_axil_arvalid(m_axil_arvalid),
    .m_axil_arready(m_axil_arready),
    .m_axil_rdata(m_axil_rdata),
    .m_axil_rresp(m_axil_rresp),
    .m_axil_rvalid(m_axil_rvalid),
    .m_axil_rready(m_axil_rready),

    .ct_address(ct_address),
    .ct_colour(ct_colour),

    .fb_x(gpu_fb_x),
    .fb_y(gpu_fb_y),
    .fb_colour(gpu_fb_colour),
    .fb_write(gpu_fb_write)
);


HDMI_Out hdmi_Out
(
    //In
    .clk_25mhz(clk25Mhz),
    .red({hdmi_color[15:11], 3'b0}),
    .green({hdmi_color[10:6], 3'b0}),
    .blue({hdmi_color[5:1], 3'b0}),

    //Out
    .pixclk(hdmi_pixClk),
    .nextX(hdmi_nextX[10:0]),
    .nextY(hdmi_nextY[10:0]),
    .hSync(hSync),
    .vSync(vSync),
    .gpdi_dp(gpdiDp)

);

endmodule