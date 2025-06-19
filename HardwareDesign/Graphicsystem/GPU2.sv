enum logic { 
	UPSCALE, 
	DOWNSCALE
} ScaleType;

enum logic[4:0] {
    BIT_1 = 4'd1,
    BIT_2 = 4'd2,
    BIT_4 = 4'd4,
    BIT_8 = 4'd8,
    BIT_16 = 4'd16, //This is special, because it needs a left shift instead of a right shift
} CTType; //Colour table type

module GPU_1_Rectangle (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[15:0] re_start_x,
    input  logic[15:0] re_start_y,
    input  logic[15:0] re_width,
    input  logic[15:0] re_height,
	input  logic[15:0] re_scale_x, //signed
	input  logic[15:0] re_scale_y, //signed
	input  logic	   re_mirror_x,
	input  logic	   re_mirror_y,
    
	//These vectors are quite large because I am afraid of overflows
    output logic[31:0] se_sprite_sheet_x,
    output logic[31:0] se_sprite_sheet_y,
	output logic[15:0] se_screen_x,
    output logic[15:0] se_screen_y,
    output logic se_valid,
    input  logic se_ready
)

enum logic {
    IDLE,
    GENERATING
} State;

State state = IDLE;
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

logic[15:0] start_x;
logic[15:0] start_y;
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
logic[15:0] max_x; //inclusive
logic[15:0] max_y; //inclusive
logic[15:0] sub_x; //subcounter for scaling
logic[15:0] sub_y; //subcounter for scaling
logic[31:0] ss_x;  //sprite_sheet_x  (quite large)
logic[31:0] ss_y;  //sprite_sheet_y  (quite large)

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
			ss_x <= re_start_x;
			ss_y <= re_start_y;
			max_ss_x  <= $signed(re_scale_x) < $signed(0) ? (-re_scale_x - 1) : (re_scale_x - 1);
			max_ss_y  <= $signed(re_scale_y) < $signed(0) ? (-re_scale_y - 1) : (re_scale_y - 1);

            max_sub_x <= $signed(re_scale_x) < $signed(0) ? (-re_scale_x - 1) : (re_scale_x - 1);
            max_sub_y <= $signed(re_scale_y) < $signed(0) ? (-re_scale_y - 1) : (re_scale_y - 1);
		end
	end
	GENERATING: begin
		if(scale_type_x == UPSCALE) begin
            if(se_handshake) begin 
			    sub_x <= sub_x + 1;
            end

			if(sub_x == max_sub_x) begin
                sub_x <= 0;
                ss_x <= ss_x + 1;
            end
		end
        else if(scale_type_x == DOWNSCALE) begin
            if(se_handshake) begin
                ss_x <= ss_x + scale_x;
            end
        end

        if(scale_type_y == UPSCALE) begin
            if(x == max_x) begin
                sub_y <= sub_y + 1;
            end

			if(sub_y == max_sub_y) begin
                sub_y <= 0;
                ss_y <= ss_y + 1;
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

always_ff @(posedge clk) begin
	se_screen_x <= mirror_x ? (start_x + (width - 1) - x) : (start_x + x);
	se_screen_y <= mirror_y ? (start_y + (height - 1) - y) : (start_y + y);
end

always_ff @(posedge clk) begin
    case(state)
    IDLE: begin
        re_ready <= 1;
        if (re_handshake) begin
            state <= GENERATING;
            re_ready <= 0;
            se_valid <= 1;

			start_x <= 		re_start_x;
			start_y <= 		re_start_y;
			width <= 		re_width;
			height <= 		re_height;
			scale_x <= 		$signed(re_scale_x) < $signed(0) ? -re_scale_x : re_scale_x;
			scale_y <= 		$signed(re_scale_y) < $signed(0) ? -re_scale_y : re_scale_y;
			scale_type_x <= $signed(re_scale_x) < $signed(0) ? DOWNSCALE : UPSCALE;
			scale_type_y <= $signed(re_scale_y) < $signed(0) ? DOWNSCALE : UPSCALE;
			mirror_x     <= re_mirror_x;
			mirror_y     <= re_mirror_y;

            x <= 0;
            y <= 0;
            max_x <= re_width - 1;
            max_y <= re_height - 1;
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
    end
    
    if (rst) begin
        state <= IDLE;
        se_valid <= 0;
        re_ready <= 0;
    end
    endcase
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
    input  logic[15:0] re_height,
    input  CTType      re_ct_type,
    input  logic       re_use_ct,
    
    output logic[31:0] se_memory_address,
    output logic[31:0] se_sprite_sheet_address,
    output CTType      se_ct_type,
    output logic       se_use_ct,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

logic[31:0] buffer_memory_address;
logic[31:0] buffer_ss_address;
CTType      buffer_ct_type;
logic       buffer_use_ct;

//This is a long path. Maybe split it up into two cycles???
wire[31:0] ss_address = re_x + re_image_width * re_y; //1D sprite sheet address
wire[31:0] result = re_base_address + (ss_address * re_ct_type >> 3);

//output_buffer
enum logic[1:0] {
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
            se_ct_type <= re_ct_type;
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
            buffer_ss_address =< ss_address;
            buffer_ct_type <= re_ct_type;
            buffer_use_ct <= re_use_ct;
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
            se_ct_type <= re_ct_type;
            se_use_ct <= re_use_ct;
        end
    BUF_FULL: begin
        re_ready <= 0;
        se_valid <= 1;
        if(se_handshake) begin
            re_ready <= 1;
            se_valid <= 1;
            state <= FULL;
            se_memory_address <= buffer_memory_address;
            se_sprite_sheet_address <= buffer_ss_address;
            se_ct_type <= buffer_ct_type;
            se_use_ct <= buffer_use_ct;
        end
    end
    end
    endcase

    else if(se_handshake) begin
        se_valid <= 0;
    end

    if(se_handshake || se_valid == 0)
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
    input  logic       re_use_ct,

    //axi lite slave read channels
    input  logic       axi_arready,
    output logic       axi_arvalid,
    output logic[31:0] axi_araddr,
    output logic       axi_rready,
    output logic       axi_rvalid,
    output logic[31:0] axi_rdata,

    output logic[15:0] se_data, //this can be either a colour or an entry to a colour table
    output logic       se_use_ct,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;
wire axi_ar_handshake = axi_arready && axi_arvalid;
wire axi_r_handshake = axi_rready && axi_rvalid;

enum logic[1:0] {
    IDLE,
    SET_ADDRESS,
    GET_DATA,
    DATA_READY
} State;

State state;
`ifndef SYNTHESIS
logic[9 * 8 - 1: 0] dbg_state;
always_comb begin
    case (state)
        IDLE: dbg_state = "IDLE";
        SET_ADDRESS: dbg_state = "SET_ADDRESS";
        GET_DATA: dbg_state = "GET_DATA";
        DATA_READY: dbg_state = "DATA_READY";
    endcase
end
`endif

logic[31:0] cache_addr;
logic[31:0] cache_ss_addr;
CTType      cache_ct_type;
logic       cache_use_ct;
logic[31:0] cache_data;

//This is a long path. Maybe split it up into two cycles???
wire[15:0] bitmask = (1 << re_ct_type) - 1;
wire[15:0] shift_amount = 31 - (re_sprite_sheet_address * re_ct_type)[4:0] + (re_ct_type - 1);
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
                cache_ct_type <= re_ct_type;
                cache_use_ct <= re_use_ct;
                
                if(cache_addr[31:2] == re_address[31:2]) begin
                    state <= DATA_READY;
                    se_valid <= 1;
                    se_data <= quick_result;
                    se_use_ct <= re_use_ct;
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
                se_use_ct <= cache_use_ct;
                cache_data <= axi_rdata;
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
    endcase
end

endmodule


module GPU_4_ColourTable (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[15:0] re_ct_base_address,
    input  logic[15:0] re_ct_offset,

    //This memory must have the data ready after one clock cycle!!!
    output logic[15:0] mem_address,
    input  logic[15:0] mem_data,

    output logic[15:0] se_colour,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

assign re_ready = 1;
assign se_colour = mem_data;

always_ff @(posedge clk) begin
    if(re_handshake) begin
        mem_address <= re_base_address + re_ct_offset;
        se_valid <= 1;
    end
    else begin
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

assign re_ready = 1;

always_ff @(posedge clk) begin
    if(re_handshake) begin
        fb_x <= re_x;
        fb_y <= re_y;
        fb_colour <= fb_write;
        fb_write <= 1;
    end
    else begin
        fb_write <= 0;
    end
end
endmodule

/*
1. Spritesheetposition und Screenposition (skalierung und spiegelung!) generieren - 1_Rectangle //TODO: add line
2. Speicheradressen berechnen           - 2_Address
3. Pixel/CT Index lesen                 - 3_Memory //TODO: add constant colour
4. (Optional) Color table auflösen      - 4_ColourTable
5. Pixelschreiben                       - 5_Framebuffer
*/

/*
Skalieren
Spiegeln
color table

Rechteck zeichnen
Linie zeichnen

TODO: Set ct_type to BIT_16, if use_ct == false
TODO: Implement a reset in all stages
TODO: Pass-through all data until it is not needed anymore
*/