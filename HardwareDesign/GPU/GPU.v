//IMPORTANT: The ctrl_* signals will be taken 2 cycles after ctrl_draw has been raised
module gpu 
#(
    parameter QUEUE_DEPTH = 8,
    parameter FB_WIDTH = 120,
    parameter FB_HEIGHT = 160
)
(
    input clk,
    input rstn,

    //MEM INTERFACE
    output reg  [15:0] mem_addr,  //The address of the memory
    output reg  [15:0] mem_wdata, //The data to be written
    output reg         mem_write, //Tells the memory if read or write
    input       [15:0] mem_rdata,  //The data that was read

    //CONTROL INTERFACE
    input  [31:0] ctrl_address,  //The base address to take the pixel data for the image from
    input  [15:0] ctrl_address_x,//The x axis offset to the base address
    input  [15:0] ctrl_address_y,//The y axis offset to the base address
    input  [15:0] ctrl_sheetsize,//The width of the spritesheet
    input  [15:0] ctrl_width,    //The width of the image to be drawn
    input  [15:0] ctrl_height,   //The height of the image to be drawn
    input  [15:0] ctrl_x,        //Left position of the image to be drawn
    input  [15:0] ctrl_y,        //Top position of the image to be drawn
    input         ctrl_draw,     //Tells the GPU to save the given ctrl data and push it into the render queue
    input         ctrl_clear,    //Tells the GPU to clear the framebuffer with ctrl_clear_color
    input  [15:0] ctrl_clear_color,//The color with which the framebuffer will be cleared
    output        ctrl_full,     //Tells the controller that the render queue is currently full. Draw requests will be ignored

    output reg[7:0]  fb_x,     //The x coordinate
    output reg[7:0]  fb_y,     //The y coordinate
    output reg[15:0] fb_color, //The color
    output reg       fb_write  //Tells the frame buffer to write color to (fb_x, fb_y)
);

reg old_ctrl_draw;

// | 143:112 | 111:96 | 95:80 | 79:64 | 63:48 | 47:32 | 31:16 |  15:0  |
// |  addr   | addr_x | addr_y| sheet | width | height|   x   |    y   |
wire[143:0] queue_o_data;
wire queue_empty;
wire queue_pop;
wire queue_push = old_ctrl_draw == 0 && ctrl_draw == 1;
reg pop = 0;

wire[31:0] active_address;
wire[15:0] active_address_x;
wire[15:0] active_address_y;
wire[15:0] active_sheetsize;
wire[15:0] active_width;
wire[15:0] active_height;
wire[15:0] active_x;
wire[15:0] active_y;


assign active_address = queue_o_data[143:112];
assign active_address_x = queue_o_data[111:96];
assign active_address_y = queue_o_data[95:80];
assign active_sheetsize = queue_o_data[79:64];
assign active_width = queue_o_data[63:48];
assign active_height = queue_o_data[47:32];
assign active_x = queue_o_data[31:16];
assign active_y = queue_o_data[15:0];
assign queue_pop = pop;

queue
#(
    .DEPTH(QUEUE_DEPTH),
    .WIDTH(32 * 1 + 16 * 7)
)
queue_drawcalls
(
    .clk(clk),
    .rstn(rstn),
    .i_data({ctrl_address, ctrl_address_x, ctrl_address_y, ctrl_sheetsize, ctrl_width, ctrl_height, ctrl_x, ctrl_y}),
    .push(queue_push),
    .o_data(queue_o_data),
    .pop(queue_pop),
    .full(ctrl_full),
    .empty(queue_empty)
);

always @(posedge clk) begin
    if(rstn == 0) begin
        queue_push <= 0;
        old_ctrl_draw <= 0;
    end
    else begin
        old_ctrl_draw <= ctrl_draw;
    end
end

//Draw onto framebuffer
reg [7:0] x;
reg [7:0] y;
reg [7:0] old_x;
reg [7:0] old_y;
reg [8:0] state;

localparam IDLE = 0;
localparam LOADQUEUE_0 = 1;
localparam LOADQUEUE_1 = 2;
localparam DRAW = 3;
localparam FINISH = 4;
localparam CLEAR_FB = 5;

always @(posedge clk) begin
    if(rstn == 0) begin
        x <= 0;
        y <= 0;
        old_x <= 0;
        old_y <= 0;
        state <= 0;
    end
    else
    begin
        mem_write <= 0;
        pop <= 0;
        fb_write <= 0;
        case (state)
            IDLE: begin
                x <= 1;
                y <= 0;
                old_x <= 0;
                old_y <= 0;
                if(!queue_empty) begin 
                    state <= LOADQUEUE_0;
                    pop <= 1;
                end
                else if(ctrl_clear) begin
                    state <= CLEAR_FB;
                end
            end
            LOADQUEUE_0: begin
                //Waiting for queue to pop
                state <= LOADQUEUE_1;
            end
            LOADQUEUE_1: begin
                mem_addr <= active_address + active_address_x + active_address_y * active_sheetsize;
                state <= DRAW;
            end
            DRAW: begin
                mem_addr <= active_address + active_address_x + x + (active_address_y + y) * active_sheetsize; //BITSHIFTEN

                old_x <= x;
                old_y <= y;
                x <= x + 1;
                if(x >= active_width - 1) begin
                    x <= 0;
                    y <= y + 1;
                    if(y >= active_height - 1) begin
                        state <= FINISH;
                    end
                end

                fb_x <= active_x + old_x;
                fb_y <= active_y + old_y;
                fb_color <= mem_rdata;
                fb_write <= 1;
            end
            FINISH: begin

                fb_x <= active_x + old_x;
                fb_y <= active_y + old_y;
                fb_color <= mem_rdata;
                fb_write <= 1;

                state <= IDLE;
            end

            CLEAR_FB: begin
                fb_x <= old_x;
                fb_y <= old_y;
                fb_write <= 1;
                fb_color <= ctrl_clear_color;

                old_x <= old_x + 1;
                if(old_x >= FB_WIDTH - 1) begin
                    old_x <= 0;
                    old_y <= old_y + 1;
                    if(old_y >= FB_HEIGHT - 1) begin
                        state <= IDLE;
                    end
                end
            end
        endcase
    end
end

endmodule