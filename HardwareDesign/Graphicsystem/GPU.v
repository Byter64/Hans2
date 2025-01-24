`timescale 1ns/1ps

module GPU #
(
    parameter FB_WIDTH = 400,
    parameter FB_HEIGHT = 240
)
(
    input clk,
    input reset,

    //MEM INTERFACE
    input       [15:0] mem_data,    //The data that was read
    input              mem_valid,   //High, if mem_data is valid
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

localparam IDLE = 1;
localparam DRAW = 2;
localparam CLEAR = 4;

localparam I_IDLE = 0;
localparam I_DRAW = 1;
localparam I_CLEAR = 2;

reg[2:0] next_state;
reg[2:0] state = IDLE; //Don't remove initial value. Else yosys will make this an fsm, which for some reason breaks the functionality

reg[31:0] draw_address;
reg[15:0] draw_address_x;
reg[15:0] draw_address_y;
reg[15:0] draw_image_width;
reg[$clog2(FB_WIDTH)+1:0] draw_width;
reg[$clog2(FB_HEIGHT)+1:0] draw_height;
reg[$clog2(FB_WIDTH)+1:0] draw_x;
reg[$clog2(FB_HEIGHT)+1:0] draw_y;

reg[15:0] clear_color;

reg old_ctrl_draw;
reg old_ctrl_clear;
wire command_draw = old_ctrl_draw == 0 && ctrl_draw == 1;
wire command_clear = old_ctrl_clear == 0 && ctrl_clear == 1;

reg drawing = 0;
wire[$clog2(FB_WIDTH)+1:0] max_x = draw_width;
wire[$clog2(FB_HEIGHT)+1:0] max_y = draw_height;
reg[$clog2(FB_WIDTH)+1:0] pos_x = 0;
reg[$clog2(FB_HEIGHT)+1:0] pos_y = 0;
wire[$clog2(FB_WIDTH)+1:0] pos_x_1 = pos_x + 1;
wire[$clog2(FB_HEIGHT)+1:0] pos_y_1 = pos_y + 1;
wire[$clog2(FB_WIDTH)+1:0] next_pos_x = drawing ? (pos_x_1 == max_x ? 0 : pos_x_1) : 0;
wire[$clog2(FB_HEIGHT)+1:0] next_pos_y = drawing ? (pos_x_1 == max_x ? pos_y_1 : pos_y) : 0;

wire next_drawing = pos_y < max_y;
reg[15:0] draw_color;
//Because bounds start at 0 and the comparison is unsigned, we only need one comparison
wire x_in_bounds = fb_x < FB_WIDTH;
wire y_in_bounds = fb_y < FB_HEIGHT;
//draw_color[0] is the transparency bit
assign fb_write = next_drawing && draw_color[0] && x_in_bounds && y_in_bounds;
assign fb_x = draw_x + pos_x;
assign fb_y = draw_y + pos_y;
assign fb_color = draw_color;


assign crtl_busy = !state[I_IDLE] || !next_state[I_IDLE];





always @(posedge clk) begin
    old_ctrl_clear <= ctrl_clear;
    old_ctrl_draw <= ctrl_draw;

    if(reset) begin
        old_ctrl_clear <= 0;
        old_ctrl_draw <= 0;
    end
end


always @(*) begin
    if(state[I_DRAW])
        next_state <= drawing ? DRAW : IDLE;
    else if(state[I_CLEAR])
        next_state <= drawing ? CLEAR : IDLE;
    else //IDLE
        next_state <= command_draw ? DRAW : command_clear ? CLEAR : IDLE;
end

always @(posedge clk) begin
    state <= next_state;

    if(reset) begin
        state <= IDLE;
    end
end


//Don't give these initial values because they will become latches and yosys dies and what not
//Does apply for any reg that is set in a combinational always

always @(posedge clk) begin
    if(next_state[I_IDLE]) begin
        draw_address <= ctrl_address;
        draw_address_x <= ctrl_address_x;
        draw_address_y <= ctrl_address_y;
        draw_image_width <= ctrl_image_width;
        draw_width <= ctrl_width;
        draw_height <= ctrl_height;
        draw_x <= ctrl_x;
        draw_y <= ctrl_y;
    end else if (next_state[I_DRAW]) begin
        //Don't read from ctrl anymore so that the controller can already
        //prepare data for the next call
    end else if (next_state[I_CLEAR]) begin
        draw_width <= FB_WIDTH;
        draw_height <= FB_HEIGHT;
        draw_x <= 0;
        draw_y <= 0;
    end
end



always @(posedge clk) begin
    if(!state[I_CLEAR])
        clear_color <= ctrl_clear_color;
    else
        clear_color <= clear_color;
end


always @(posedge clk) begin
    if(!next_state[I_IDLE] && state[I_IDLE]) begin
        drawing <= 1;
    end

    if(drawing && (mem_valid || !state[I_DRAW])) begin
        pos_x <= next_pos_x;
        pos_y <= next_pos_y;
        drawing <= next_drawing;
    end
    else begin
        pos_x <= 0;
        pos_y <= 0;
    end

    if(reset) begin
        drawing <= 0;
    end
end

assign mem_read = next_state[I_DRAW];
assign mem_addr = draw_address + draw_address_x + next_pos_x + ((draw_address_y + next_pos_y) * draw_image_width);

always @(*) begin
    if(!state[I_CLEAR])
        draw_color <= mem_data;
    else
        draw_color <= clear_color;
end


endmodule