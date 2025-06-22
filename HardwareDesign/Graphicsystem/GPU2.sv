typedef enum logic { 
	UPSCALE, 
	DOWNSCALE
} ScaleType;

typedef enum logic[4:0] {
    BIT_1 = 5'd1,
    BIT_2 = 5'd2,
    BIT_4 = 5'd4,
    BIT_8 = 5'd8,
    BIT_16 = 5'd16 //This is special, because it needs a left shift instead of a right shift
} CTType; //Colour table type

typedef enum logic[3:0] {
	RECTANGLE,
	LINE
} Shape;

typedef enum logic {
	MEMORY,
	COLOUR
} ColourSource;

module GPU #(
    parameter FB_WIDTH = 400,
    parameter FB_HEIGHT = 240
) (
    input logic clk,
    input logic rst,

    input  logic[31:0]  image_start,
    input  logic[15:0]  image_x,
    input  logic[15:0]  image_y,
    input  logic[15:0]  image_width,
    input  logic[15:0]  image_scale_x,
    input  logic[15:0]  image_scale_y,
    input  logic        image_flip_x,
    input  logic        image_flip_y,
    input  CTType       ct_type,
    input  logic        ct_enable,
    input  logic[15:0]  ct_offset,
    input  logic[15:0]  excerpt_width,
    input  logic[15:0]  excerpt_height,
    input  logic[15:0]  screen_x,
    input  logic[15:0]  screen_y,
    input  logic[15:0]  draw_colour,
    input  Shape        draw_shape,
    input  ColourSource draw_colour_source,
    input  logic        command_draw,
    output logic        is_busy,

    //AXI-L MASTER
    output logic[31:0]                       m_axil_araddr,
    output logic[2:0]                        m_axil_arprot,
    output logic                             m_axil_arvalid,
    input  logic                             m_axil_arready,
    input  logic [31:0]                      m_axil_rdata,
    input  logic [1:0]                       m_axil_rresp,
    input  logic                             m_axil_rvalid,
    output logic                             m_axil_rready,

    //Colour Table memory
    output logic[15:0] ct_address,
    input  logic[15:0] ct_colour,

    //Framebuffer
    output logic[15:0] fb_x,
    output logic[15:0] fb_y,
    output logic[15:0] fb_colour,
    output logic       fb_write
);

logic       st1_rect_re_ready;
logic[15:0] st1_rect_sprite_sheet_x;
logic[15:0] st1_rect_sprite_sheet_y;
logic[15:0] st1_rect_screen_x;
logic[15:0] st1_rect_screen_y;
logic       st1_rect_se_valid;
logic       st2_re_ready;
logic[31:0] st2_memory_address;
logic[31:0] st2_sprite_sheet_address;
logic[15:0] st2_framebuffer_x;
logic[15:0] st2_framebuffer_y;
logic       st2_se_valid;
logic       st3_re_ready;
logic[15:0] st3_data;
logic[15:0] st3_framebuffer_x;
logic[15:0] st3_framebuffer_y;
logic       st3_se_valid;
logic       st4_re_ready;
wire        st3_se_ready;
logic[15:0] st4_colour;
logic[15:0] st4_framebuffer_x;
logic[15:0] st4_framebuffer_y;
logic       st4_se_valid;
logic       st5_re_ready;

assign st3_se_ready = ct_enable ? st4_re_ready : st5_re_ready;
assign is_busy = !(st1_rect_re_ready && st2_re_ready && st3_re_ready && st4_re_ready && st5_re_ready);

GPU_1_Rectangle #(
    .FB_WIDTH(FB_WIDTH),
    .FB_HEIGHT(FB_HEIGHT)
) Stage1_Rect (
    .clk(clk),
    .rst(rst),
    
    .re_valid(command_draw),
    .re_ready(st1_rect_re_ready),
    .re_sprite_sheet_x(image_x),
    .re_sprite_sheet_y(image_y),
    .re_screen_x(screen_x),
    .re_screen_y(screen_y),
    .re_width(excerpt_width),
    .re_height(excerpt_height),
    .re_scale_x(image_scale_x),
    .re_scale_y(image_scale_y),
    .re_mirror_x(image_flip_x),
    .re_mirror_y(image_flip_y),

    .se_sprite_sheet_x(st1_rect_sprite_sheet_x),
    .se_sprite_sheet_y(st1_rect_sprite_sheet_y),
    .se_screen_x(st1_rect_screen_x),
    .se_screen_y(st1_rect_screen_y),
    .se_valid(st1_rect_se_valid),
    .se_ready(st2_re_ready)
);

GPU_2_Address Stage2 
(
    .clk(clk),
    .rst(rst),

    .re_valid(st1_rect_se_valid),
    .re_ready(st2_re_ready),
    .re_base_address(image_start),
    .re_x(st1_rect_sprite_sheet_x),
    .re_y(st1_rect_sprite_sheet_y),
    .re_image_width(image_width),
    .re_ct_type(ct_type),
    .re_framebuffer_x(st1_rect_screen_x),
    .re_framebuffer_y(st1_rect_screen_y),

    .se_memory_address(st2_memory_address),
    .se_sprite_sheet_address(st2_sprite_sheet_address),
    .se_framebuffer_x(st2_framebuffer_x),
    .se_framebuffer_y(st2_framebuffer_y),
    .se_valid(st2_se_valid),
    .se_ready(st3_re_ready)
);

GPU_3_Memory Stage3 
(
    .clk(clk),
    .rst(rst),

    .re_valid(st2_se_valid),
    .re_ready(st3_re_ready),
    .re_address(st2_memory_address),
    .re_sprite_sheet_address(st2_sprite_sheet_address),
    .re_ct_type(ct_type),
    .re_framebuffer_x(st2_framebuffer_x),
    .re_framebuffer_y(st2_framebuffer_y),

    .axi_arready(m_axil_arready),
    .axi_arvalid(m_axil_arvalid),
    .axi_araddr(m_axil_araddr),
    .axi_rready(m_axil_rready),
    .axi_rvalid(m_axil_rvalid),
    .axi_rdata(m_axil_rdata),

    .se_data(st3_data),
    .se_framebuffer_x(st3_framebuffer_x),
    .se_framebuffer_y(st3_framebuffer_y),
    .se_valid(st3_se_valid),
    .se_ready(st3_se_ready)
);


GPU_4_ColourTable Stage4 
(
    .clk(clk),
    .rst(rst),

    .re_valid(st3_se_valid && ct_enable),
    .re_ready(st4_re_ready),
    .re_ct_address(st3_data),
    .re_ct_offset(ct_offset),
    .re_framebuffer_x(st3_framebuffer_x),
    .re_framebuffer_y(st3_framebuffer_y),

    .mem_address(ct_address),
    .mem_data(ct_colour),

    .se_colour(st4_colour),
    .se_framebuffer_x(st4_framebuffer_x),
    .se_framebuffer_y(st4_framebuffer_y),
    .se_valid(st4_se_valid),
    .se_ready(st5_re_ready)
);

GPU_5_Framebuffer Stage5 
(
    .clk(clk),
    .rst(rst),

    .re_valid(ct_enable ? st4_se_valid : st3_se_valid),
    .re_ready(st5_re_ready),
    .re_x(ct_enable ? st4_framebuffer_x : st3_framebuffer_x),
    .re_y(ct_enable ? st4_framebuffer_y : st3_framebuffer_y),
    .re_colour(draw_colour_source == COLOUR ? draw_colour : ct_enable ? st4_colour : st3_data),

    .fb_x(fb_x),
    .fb_y(fb_y),
    .fb_colour(fb_colour),
    .fb_write(fb_write)
);
endmodule

module GPU_1_Rectangle #(
    parameter FB_WIDTH,
    parameter FB_HEIGHT
) (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[15:0] re_sprite_sheet_x,
    input  logic[15:0] re_sprite_sheet_y,
    input  logic[15:0] re_screen_x,
    input  logic[15:0] re_screen_y,
    input  logic[15:0] re_width,
    input  logic[15:0] re_height,
	input  logic[15:0] re_scale_x, //signed
	input  logic[15:0] re_scale_y, //signed
	input  logic	   re_mirror_x,
	input  logic	   re_mirror_y,
    
    output logic[15:0] se_sprite_sheet_x,
    output logic[15:0] se_sprite_sheet_y,
	output logic[15:0] se_screen_x,
    output logic[15:0] se_screen_y,
    output logic se_valid,
    input  logic se_ready
);

typedef enum logic {
    IDLE,
    GENERATING
} State;

State state = IDLE;
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

logic[15:0] start_screen_x;
logic[15:0] start_screen_y;
logic[15:0] start_ss_x;
logic[15:0] start_ss_y;
logic[15:0] width;
logic[15:0] height;
logic[15:0] scale_x;
logic[15:0] scale_y;
ScaleType   scale_type_x;
ScaleType   scale_type_y;
logic	    mirror_x;
logic	    mirror_y;

logic[15:0] x;
logic[15:0] y;
logic[15:0] max_x; //exclusive
logic[15:0] max_y; //exclusive
logic[15:0] sub_x; //subcounter for scaling
logic[15:0] sub_y; //subcounter for scaling
logic[15:0] ss_x;
logic[15:0] ss_y;

logic[15:0] max_sub_x;  //inclusive (used for UPSCALE)
logic[15:0] max_sub_y;  //inclusive (used for UPSCALE)

assign se_sprite_sheet_x = ss_x;
assign se_sprite_sheet_y = ss_y;

always_ff @(posedge clk) begin
	case(state)
	IDLE: begin
		if(re_handshake) begin
			sub_x <= 0;
			sub_y <= 0;
			ss_x <= re_sprite_sheet_x;
			ss_y <= re_sprite_sheet_y;
			
            max_sub_x <= $signed(re_scale_x) < $signed(0) ? (-re_scale_x - 1) : (re_scale_x - 1);
            max_sub_y <= $signed(re_scale_y) < $signed(0) ? (-re_scale_y - 1) : (re_scale_y - 1);
		end
	end
	GENERATING: begin
		if(scale_type_x == UPSCALE) begin
            if(se_handshake) begin 
			    sub_x <= sub_x + 1;

			    if(sub_x == max_sub_x) begin
                    sub_x <= 0;
                    ss_x <= ss_x + 1;
                end
            end
		end
        else if(scale_type_x == DOWNSCALE) begin
            if(se_handshake) begin
                ss_x <= ss_x + scale_x;
            end
        end

        if(x == max_x) begin
            ss_x <= start_ss_x;
        end

        if(scale_type_y == UPSCALE) begin
            if(x == max_x) begin
                sub_y <= sub_y + 1;

			    if(sub_y == max_sub_y) begin
                    sub_y <= 0;
                    ss_y <= ss_y + 1;
                end
            end
		end
        else if(scale_type_x == DOWNSCALE) begin
            if(x == max_x) begin 
                ss_y <= ss_y + scale_y;
            end
        end
	end

	endcase
end

assign se_screen_x = mirror_x ? (start_screen_x + (width - 1) - x) : (start_screen_x + x);
assign se_screen_y = mirror_y ? (start_screen_y + (height - 1) - y) : (start_screen_y + y);

always_ff @(posedge clk) begin
    case(state)
    IDLE: begin
        re_ready <= 1;
        if (re_handshake) begin
            state <= GENERATING;
            re_ready <= 0;
            se_valid <= 1;

			start_screen_x <= 		re_screen_x;
			start_screen_y <= 		re_screen_y;
			start_ss_x		<=		re_sprite_sheet_x;
			start_ss_y		<=		re_sprite_sheet_y;
			width <= 		re_width;
			height <= 		re_height;
			scale_x <= 		$signed(re_scale_x) < $signed(0) ? -re_scale_x : re_scale_x;
			scale_y <= 		$signed(re_scale_y) < $signed(0) ? -re_scale_y : re_scale_y;
			scale_type_x <= ScaleType'($signed(re_scale_x) < $signed(0) ? DOWNSCALE : UPSCALE);
			scale_type_y <= ScaleType'($signed(re_scale_y) < $signed(0) ? DOWNSCALE : UPSCALE);
			mirror_x     <= re_mirror_x;
			mirror_y     <= re_mirror_y;

            x <= 0;
            y <= 0;
            max_x <= re_width;
            max_y <= re_height;

            if(re_scale_x == 0 || re_scale_y == 0)
                state <= IDLE;
        end
    end
    GENERATING: begin
        if(se_handshake) begin
            x <= x + 1;
        end
        
        if(x == max_x) begin
            x <= 0;
            y <= y + 1;
        end
        if(y == max_y) begin
            re_ready <= 1;
            se_valid <= 0;
            state <= IDLE;
        end

        if(se_screen_x >= FB_WIDTH || se_screen_y >= FB_HEIGHT) begin
            re_ready <= 1;
            se_valid <= 0;
            state <= IDLE;
        end
    end
    endcase

    if(rst) begin
        state <= IDLE;
        re_ready <= 0;
        se_valid <= 0;
    end
end
endmodule

module GPU_2_Address (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[31:0] re_base_address,
    input  logic[15:0] re_x,
    input  logic[15:0] re_y,
    input  logic[15:0] re_image_width,
    input  CTType      re_ct_type,
    input  logic[15:0] re_framebuffer_x,
    input  logic[15:0] re_framebuffer_y,
    
    output logic[31:0] se_memory_address,
    output logic[31:0] se_sprite_sheet_address,
    output logic[15:0] se_framebuffer_x,
    output logic[15:0] se_framebuffer_y,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

logic[31:0] buffer_memory_address;
logic[31:0] buffer_ss_address;
logic[15:0] buffer_framebuffer_x;
logic[15:0] buffer_framebuffer_y;

//This is a long path. Maybe split it up into two cycles???
wire[31:0] ss_address = re_x + re_image_width * re_y; //1D sprite sheet address
wire[31:0] result = re_base_address + (ss_address * re_ct_type >> 3);

//output_buffer
typedef enum logic[1:0] {
    EMPTY,
    FULL,
    BUF_FULL
} State;

State state = EMPTY;

`ifndef SYNTHESIS
logic[9 * 8 - 1: 0] dbg_state;
always_comb begin
    case (state)
        EMPTY: dbg_state = "EMPTY";
        FULL: dbg_state  = "FULL";
        BUF_FULL: dbg_state   = "BUF_FULL";
    endcase
end
`endif

always_ff @(posedge clk) begin
    case (state)
    EMPTY: begin
        re_ready <= 1;
        se_valid <= 0;
        if(re_handshake) begin
            re_ready <= 1;
            se_valid <= 1;
            state <= FULL;
            se_memory_address <= result;
            se_sprite_sheet_address <= ss_address;
            se_framebuffer_x <= re_framebuffer_x;
            se_framebuffer_y <= re_framebuffer_y;
        end
    end
    FULL: begin
        re_ready <= 1;
        se_valid <= 1;
        if(re_handshake && !se_handshake) begin
            re_ready <= 0;
            se_valid <= 1;
            state <= BUF_FULL;
            buffer_memory_address <= result;
            buffer_ss_address <= ss_address;
            buffer_framebuffer_x <= re_framebuffer_x;
            buffer_framebuffer_y <= re_framebuffer_y;
        end
        else if(!re_handshake && se_handshake) begin
            re_ready <= 1;
            se_valid <= 0;
            state <= EMPTY;
        end
        else if(re_handshake && se_handshake) begin
            re_ready <= 1;
            se_valid <= 1;
            state <= FULL;
            se_memory_address <= result;
            se_sprite_sheet_address <= ss_address;
            se_framebuffer_x <= re_framebuffer_x;
            se_framebuffer_y <= re_framebuffer_y;
        end
    end
    BUF_FULL: begin
        re_ready <= 0;
        se_valid <= 1;
        if(se_handshake) begin
            re_ready <= 0;
            se_valid <= 1;
            state <= FULL;
            se_memory_address <= buffer_memory_address;
            se_sprite_sheet_address <= buffer_ss_address;
            se_framebuffer_x <= buffer_framebuffer_x;
            se_framebuffer_y <= buffer_framebuffer_y;
        end
    end
    endcase

    if(rst) begin
        state <= EMPTY;
        re_ready <= 0;
        se_valid <= 0;
    end
end
endmodule


module GPU_3_Memory (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[31:0] re_address,
    input  logic[31:0] re_sprite_sheet_address,
    input  CTType      re_ct_type,
    input  logic[15:0] re_framebuffer_x,
    input  logic[15:0] re_framebuffer_y,

    //axi lite master read channels
    input  logic       axi_arready,
    output logic       axi_arvalid,
    output logic[31:0] axi_araddr,
    output logic       axi_rready,
    input  logic       axi_rvalid,
    input  logic[31:0] axi_rdata,

    output logic[15:0] se_data, //this can be either a colour or an entry to a colour table
    output logic[15:0] se_framebuffer_x,
    output logic[15:0] se_framebuffer_y,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;
wire axi_ar_handshake = axi_arready && axi_arvalid;
wire axi_r_handshake = axi_rready && axi_rvalid;

typedef enum logic[2:0] {
    IDLE,
    SET_ADDRESS,
    GET_DATA,
    DATA_READY,
    DATA_QUICK
} State;

State state;
`ifndef SYNTHESIS
logic[11 * 8 - 1: 0] dbg_state;
always_comb begin
    case (state)
        IDLE: dbg_state = "IDLE";
        SET_ADDRESS: dbg_state = "SET_ADDRESS";
        GET_DATA: dbg_state = "GET_DATA";
        DATA_READY: dbg_state = "DATA_READY";
        DATA_QUICK: dbg_state = "DATA_QUICK";
    endcase
end
`endif

logic[31:0] cache_addr;
logic[31:0] cache_ss_addr;
logic[31:0] cache_data;
logic[15:0] cache_framebuffer_x;
logic[15:0] cache_framebuffer_y;

logic[15:0] bitmask;
wire[31:0] bit_address = re_sprite_sheet_address * re_ct_type;
logic[15:0] shift_amount;

//This is a long path. Maybe split it up into two cycles???
wire[15:0] quick_result = (cache_data >> shift_amount) & bitmask;
wire[15:0] axi_result   = (axi_rdata >> shift_amount) & bitmask;

always_ff @(posedge clk) begin
    case (state)
        IDLE: begin
            re_ready <= 1;
            se_valid <= 0;
            axi_arvalid <= 0;
            axi_rready <= 0;
            if(re_handshake) begin
                re_ready <= 0;
                axi_araddr <= {re_address[31:2], 2'b00};
                cache_addr <= re_address;
                cache_ss_addr <= re_sprite_sheet_address;
                cache_framebuffer_x <= re_framebuffer_x;
                cache_framebuffer_y <= re_framebuffer_y;
                bitmask <= (1 << re_ct_type) - 1;
                shift_amount <= 31 - (bit_address[4:0] + (re_ct_type - 1));
                
                if(cache_addr[31:2] == re_address[31:2]) begin
                    state <= DATA_QUICK;
                    se_framebuffer_x <= re_framebuffer_x;
                    se_framebuffer_y <= re_framebuffer_y;
                end
                else begin
                    state <= SET_ADDRESS;
                    axi_arvalid <= 1;
                    se_valid <= 0;
                end
            end
        end
        SET_ADDRESS: begin
            re_ready <= 0;
            se_valid <= 0;
            if(axi_ar_handshake) begin
                axi_arvalid <= 0;
                axi_rready <= 1;
                state <= GET_DATA;
            end
        end
        GET_DATA: begin
            if(axi_r_handshake) begin
                se_valid <= 1;
                axi_rready <= 0;
                se_data <= axi_result;
                cache_data <= axi_rdata;
                se_framebuffer_x <= cache_framebuffer_x;
                se_framebuffer_y <= cache_framebuffer_y;
                state <= DATA_READY;
            end
        end
        DATA_READY: begin
            se_valid <= 1;
            re_ready <= 0;
            if(se_handshake) begin
                se_valid <= 0;
                re_ready <= 1;
                state <= IDLE;
            end
        end
        DATA_QUICK: begin
            se_valid <= 1;
            re_ready <= 0;
            se_data <= quick_result;
            if(se_handshake) begin
                se_valid <= 0;
                re_ready <= 1;
                state <= IDLE;
            end
        end
    endcase

    if(rst) begin
        state <= IDLE;
        re_ready <= 0;
        se_valid <= 0;
    end
end

endmodule


module GPU_4_ColourTable (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[15:0] re_ct_address,
    input  logic[15:0] re_ct_offset,
    input  logic[15:0] re_framebuffer_x,
    input  logic[15:0] re_framebuffer_y,

    //This memory must have the data ready after one clock cycle!!!
    output logic[15:0] mem_address,
    input  logic[15:0] mem_data,

    output logic[15:0] se_colour,
    output logic[15:0] se_framebuffer_x,
    output logic[15:0] se_framebuffer_y,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

assign se_colour = mem_data;

always_ff @(posedge clk) begin
    re_ready <= 1;


    if(re_handshake) begin
        mem_address <= (re_ct_address << 1) + re_ct_offset;
        se_framebuffer_x <= re_framebuffer_x;
        se_framebuffer_y <= re_framebuffer_y;
        se_valid <= 1;
    end
    else begin
        se_valid <= 0;
    end

    if(rst) begin
        re_ready <= 0;
        se_valid <= 0;
    end
end
endmodule


module GPU_5_Framebuffer (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[15:0] re_x,
    input  logic[15:0] re_y,
    input  logic[15:0] re_colour,

    output logic[15:0] fb_x,
    output logic[15:0] fb_y,
    output logic[15:0] fb_colour,
    output logic       fb_write
);
wire re_handshake = re_valid && re_ready;

always_ff @(posedge clk) begin
    re_ready <= 1;

    if(re_handshake) begin
        fb_x <= re_x;
        fb_y <= re_y;
        fb_colour <= re_colour;
        fb_write <= 1;
    end
    else begin
        fb_write <= 0;
    end

    if(rst) begin
        re_ready <= 0;
        fb_write <= 0;
    end
end
endmodule

/*
1. Spritesheetposition und Screenposition (skalierung und spiegelung!) generieren - 1_Rectangle //TODO: add line
2. Speicheradressen berechnen           - 2_Address
3. Pixel/CT Index lesen                 - 3_Memory
4. (Optional) Color table auflösen      - 4_ColourTable
5. Pixelschreiben                       - 5_Framebuffer


TODO: If coloursorce is color, stages 2 to 4 should be skipped!!!
*/