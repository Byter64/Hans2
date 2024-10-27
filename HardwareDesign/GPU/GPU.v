module gpu #
(
    parameter FB_WIDTH = 160,
    parameter FB_HEIGHT = 120
)
(
    input clk,
    input rstn,

    //MEM INTERFACE
    input       [15:0] mem_rdata,  //The data that was read
    output      [31:0] mem_addr,  //The address of the memory

    //CONTROL INTERFACE: Draw
    input  [31:0] ctrl_address,  //The base address to take the pixel data for the image from
    input  [15:0] ctrl_address_x,//The x axis offset to the base address
    input  [15:0] ctrl_address_y,//The y axis offset to the base address
    input  [15:0] ctrl_sheetsize,//The width of the spritesheet
    input  [15:0] ctrl_width,    //The width of the image to be drawn
    input  [15:0] ctrl_height,   //The height of the image to be drawn
    input  [15:0] ctrl_x,        //Left position of the image to be drawn
    input  [15:0] ctrl_y,        //Top position of the image to be drawn
    input         ctrl_draw,     //Tells the GPU to execute a draw call
    
    input         ctrl_clear,    //Tells the GPU to clear the framebuffer with ctrl_clear_color
    input  [15:0] ctrl_clear_color,//The color with which the framebuffer will be cleared


    output        crtl_busy,     //Tells the controller that the gpu is busy and not open for new commands

    //Framebuffer interface
    output reg[7:0]  fb_x,     //The x coordinate
    output reg[7:0]  fb_y,     //The y coordinate
    output reg[15:0] fb_color, //The color
    output reg       fb_write  //Tells the frame buffer to write color to (fb_x, fb_y)
);

reg old_ctrl_draw;
reg old_ctrl_clear;
wire command_draw = old_ctrl_draw == 0 && ctrl_draw == 1;
wire command_clear = old_ctrl_clear == 0 && ctrl_clear == 1;

always @(posedge clk) begin
    old_ctrl_clear <= ctrl_clear;
    old_ctrl_draw <= ctrl_draw;

    if(rstn == 1) begin
        old_ctrl_clear <= 0;
        old_ctrl_draw <= 0;
    end
end

localparam IDLE = 0;
localparam DRAW = 1;
localparam CLEAR = 2;
reg[1:0] next_state = IDLE;
reg[1:0] state = 0;

always @(*) begin
    case (state)
        IDLE: begin
            next_state <= command_draw ? DRAW : command_clear ? CLEAR : IDLE;
        end
        DRAW: begin
            next_state <= drawing ? DRAW : IDLE;
        end
        CLEAR: begin
            next_state <= drawing ? DRAW : IDLE;
        end
    endcase
end

always @(posedge clk) begin
    state <= next_state;

    if(rstn == 1) begin
        state <= IDLE;
    end
end


reg[31:0] draw_address;
reg[15:0] draw_address_x;
reg[15:0] draw_address_y;
reg[15:0] draw_sheetsize;
reg[15:0] draw_width;
reg[15:0] draw_height;
reg[15:0] draw_x;
reg[15:0] draw_y;

always @(next_state) begin
    case(next_state)
    default: begin
        draw_address <= ctrl_address;
        draw_address_x <= ctrl_address_x;
        draw_address_y <= ctrl_address_y;
        draw_sheetsize <= ctrl_sheetsize;
        draw_width <= ctrl_width;
        draw_height <= ctrl_height;
        draw_x <= ctrl_x;
        draw_y <= ctrl_y;
    end
    DRAW: begin
        
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

always @(next_state) begin
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
wire[7:0] next_pos_x = pos_x_1 == max_x ? draw_x : pos_x_1;
wire[7:0] next_pos_y = pos_x_1 == max_x ? pos_y_1 : pos_y;

always @(posedge clk) begin
    if(next_state != IDLE && state == IDLE) begin
        pos_x <= 0;
        pos_y <= 0;
        drawing <= 1;
    end
    if(drawing) begin
        pos_x <= next_pos_x;
        pos_y <= next_pos_y;
        drawing <= pos_y_1 != max_y;
    end

    if(rstn == 1) begin
        drawing <= 0;
    end
end

assign mem_addr = draw_address + draw_address_x + next_pos_x + ((draw_address_y + next_pos_y) * draw_width);
reg[15:0] draw_color;

always @(posedge clk) begin
    case (next_state)
        IDLE: begin 
            draw_color <= mem_rdata;
        end
        DRAW: begin
            draw_color <= mem_rdata;
        end
        CLEAR: begin
            draw_color <= clear_color;
        end
    endcase
end

assign fb_write = drawing;
assign fb_x = draw_x + pos_x;
assign fb_y = draw_y + pos_y;
assign fb_color = draw_color;

endmodule