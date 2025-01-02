`timescale 1ns/1ps

module GPU #
(
    parameter FB_WIDTH = 400,
    parameter FB_HEIGHT = 240
)
(
    input clk,
    input enable,

    //MEM INTERFACE
    input       [15:0] mem_data,    //The data that was read
    output      [31:0] mem_addr,    //The address of the memory
    output             mem_read,    //High, If data should be read

    //CONTROL INTERFACE: Draw
    input  [31:0] ctrl_address,  //The base address to take the pixel data for the excerpt from
    input  [15:0] ctrl_address_x,//The x axis offset to the base address
    input  [15:0] ctrl_address_y,//The y axis offset to the base address
    input  [15:0] ctrl_image_width,//The width of the image
    input  [$clog2(FB_WIDTH)+1:0]  ctrl_width,    //The width of the excerpt to be drawn
    input  [$clog2(FB_HEIGHT)+1:0] ctrl_height,   //The height of the excerpt to be drawn
    input  [$clog2(FB_WIDTH)+1:0]  ctrl_x,        //Left position of the excerpt to be drawn on the screen
    input  [$clog2(FB_HEIGHT)+1:0] ctrl_y,        //Top position of the excerpt to be drawn on the screen
    input         ctrl_draw,     //Tells the GPU to execute a draw call
    
    //CONTROL INTERFACE: Clear
    input  [15:0] ctrl_clear_color, //The color with which the framebuffer will be cleared
    input         ctrl_clear,       //Tells the GPU to clear the framebuffer with ctrl_clear_color


    output        crtl_busy,     //Tells the controller that the gpu is busy and not open for new commands

    //FRAMEBUFFER INTERFACE
    output[$clog2(FB_WIDTH):0]    fb_x,     //The x coordinate
    output[$clog2(FB_HEIGHT):0]   fb_y,     //The y coordinate
    output[15:0]  fb_color, //The color
    output        fb_write  //Tells the frame buffer to write color to (fb_x, fb_y)
);
/*localparam FB_WIDTH = 400;
localparam FB_HEIGHT = 240;
*/
assign crtl_busy = drawing;
assign mem_read = next_state == DRAW;

reg old_ctrl_draw;
reg old_ctrl_clear;
wire command_draw = old_ctrl_draw == 0 && ctrl_draw == 1;
wire command_clear = old_ctrl_clear == 0 && ctrl_clear == 1;

always @(posedge clk) begin
    old_ctrl_clear <= ctrl_clear;
    old_ctrl_draw <= ctrl_draw;

    if(enable == 0) begin
        old_ctrl_clear <= 0;
        old_ctrl_draw <= 0;
    end
end

localparam IDLE = 1;
localparam DRAW = 2;
localparam CLEAR = 4;
reg[2:0] next_state;
reg[2:0] state = 0;

always @(*) begin
    case (state)
        default: begin
            next_state <= command_draw ? DRAW : command_clear ? CLEAR : IDLE;
        end
        DRAW: begin
            next_state <= drawing ? DRAW : IDLE;
        end
        CLEAR: begin
            next_state <= drawing ? CLEAR : IDLE;
        end
    endcase
end

always @(posedge clk) begin
    state <= next_state;

    if(enable == 0) begin
        state <= IDLE;
    end
end


//Don't give these initial values because they will become latches and yosys dies and what not
//Does apply for any reg that is set in a combinational always
reg[31:0] draw_address;
reg[15:0] draw_address_x;
reg[15:0] draw_address_y;
reg[15:0] draw_image_width;
reg[$clog2(FB_WIDTH)+1:0] draw_width;
reg[$clog2(FB_HEIGHT)+1:0] draw_height;
reg[$clog2(FB_WIDTH)+1:0] draw_x;
reg[$clog2(FB_HEIGHT)+1:0] draw_y;

always @(posedge clk) begin
    case(next_state)
    IDLE: begin
        draw_address <= ctrl_address;
        draw_address_x <= ctrl_address_x;
        draw_address_y <= ctrl_address_y;
        draw_image_width <= ctrl_image_width;
        draw_width <= ctrl_width;
        draw_height <= ctrl_height;
        draw_x <= ctrl_x;
        draw_y <= ctrl_y;
    end
    DRAW: begin
        //Don't read from ctrl anymore so that the controller can already
        //prepare data for the next call

    end
    CLEAR: begin
        draw_width <= FB_WIDTH;
        draw_height <= FB_HEIGHT;
        draw_x <= 0;
        draw_y <= 0;
    end
    endcase
end


reg[15:0] clear_color;

always @(*) begin
    case(next_state)
    default: begin
        clear_color <= ctrl_clear_color;
    end
    CLEAR: begin
        
    end
    endcase
end

reg drawing = 0;
wire[7:0] max_x = draw_width;
wire[7:0] max_y = draw_height;
reg[7:0] pos_x = 0;
reg[7:0] pos_y = 0;
wire[7:0] pos_x_1 = pos_x + 1;
wire[7:0] pos_y_1 = pos_y + 1;
wire[7:0] next_pos_x = drawing ? (pos_x_1 == max_x ? 0 : pos_x_1) : 0;
wire[7:0] next_pos_y = drawing ? (pos_x_1 == max_x ? pos_y_1 : pos_y) : 0;

always @(posedge clk) begin
    if(next_state != IDLE && state == IDLE) begin
        pos_x <= 0;
        pos_y <= 0;
        drawing <= 1;
    end
    if(drawing) begin
        pos_x <= next_pos_x;
        pos_y <= next_pos_y;
        drawing <= pos_y_1 != max_y || pos_x_1 != max_x;
    end

    if(enable == 0) begin
        drawing <= 0;
    end
end

assign mem_addr = draw_address + draw_address_x + next_pos_x + ((draw_address_y + next_pos_y) * draw_image_width);
reg[15:0] draw_color;

always @(posedge clk) begin
    case (next_state)
        IDLE: begin 
            draw_color <= mem_data;
        end
        DRAW: begin
            draw_color <= mem_data;
        end
        CLEAR: begin
            draw_color <= clear_color;
        end
    endcase
end

//Because bounds start at 0 und the comparison is unsigned, we only need one comparison
wire x_in_bounds = fb_x < FB_WIDTH;
wire y_in_bounds = fb_y < FB_HEIGHT;
//draw_color[0] is the transparency bit
assign fb_write = drawing && draw_color[0] && x_in_bounds && y_in_bounds;
assign fb_x = draw_x + pos_x;
assign fb_y = draw_y + pos_y;
assign fb_color = draw_color;

endmodule