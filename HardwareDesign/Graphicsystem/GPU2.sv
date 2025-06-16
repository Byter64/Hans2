enum logic { 
	UPSCALE, 
	DOWNSCALE
} ScaleType;

module GPU_Pip1 (
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

module GPU_Pip2 (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[31:0] re_base_address,
    input  logic[15:0] re_x,
    input  logic[15:0] re_y,
    input  logic[15:0] re_image_width,
    input  logic[15:0] re_height,
    
    output logic[31:0] se_memory_address,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

logic[31:0] buffer;
wire[31:0] result = re_base_address + ((re_x) << 1) + ((re_image_width * re_y) << 1);;

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
        end
    end
    FULL: begin
        re_ready <= 1;
        se_valid <= 1;
        if(re_handshake && !se_handshake) begin
            re_ready <= 0;
            se_valid <= 1;
            state <= BUF_FULL;
            buffer <= result;
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
        end
    BUF_FULL: begin
        re_ready <= 0;
        se_valid <= 1;
        if(se_handshake) begin
            re_ready <= 1;
            se_valid <= 1;
            state <= FULL;
            se_memory_address <= buffer;
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

module GPU_Pip3 (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[31:0] re_address,
    
    output logic[15:0] se_memory_address,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

logic[31:0] buffer;
wire[31:0] result = re_base_address + ((re_x) << 1) + ((re_image_width * re_y) << 1);;

//output_buffer
enum logic[1:0] {
    EMPTY,
    FULL,
    BUF_FULL
} State;
endmodule

/*
1. Spritesheetposition und Screeposition (skalierung und spiegelung!) generieren - pip1
2. Speicheradresse berechnen            - pip2
3. Pixel lesen
4. (Optional) Color table auflösen
5. Pixelschreiben
*/

/*
Skalieren
Spiegeln
color table

Rechteck zeichnen
Linie zeichnen
*/