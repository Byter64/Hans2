`timescale 1ps/1ps

module main_tb (
    
);

reg tb_clk = 0;
reg tb_rstn = 0;
reg[31:0] tb_ctrl_address = 0;
reg[15:0] tb_ctrl_address_x = 0;
reg[15:0] tb_ctrl_address_y = 0;
reg[15:0] tb_ctrl_sheetsize = 0;
reg[15:0] tb_ctrl_width = 0;
reg[15:0] tb_ctrl_height = 0;
reg[15:0] tb_ctrl_x = 0;
reg[15:0] tb_ctrl_y = 0;
reg tb_ctrl_draw = 0;
reg tb_ctrl_clear = 0;
reg[15:0] tb_ctrl_clear_color = 0;

wire[15:0] gpu_mem_addr;
wire[15:0] gpu_mem_wdata;
wire gpu_mem_write;
wire[15:0] gpu_mem_rdata;
wire gpu_ctrl_full;
wire[7:0] gpu_fb_x;
wire[7:0] gpu_fb_y;
wire[15:0] gpu_fb_color;
wire gpu_fb_write;

gpu gpu 
(
    .clk(tb_clk),
    .rstn(tb_rstn),
    .mem_addr(gpu_mem_addr),
    .mem_wdata(gpu_mem_wdata),
    .mem_write(gpu_mem_write),
    .mem_rdata(memory_r_data),
    
    .ctrl_address(tb_ctrl_address),
    .ctrl_address_x(tb_ctrl_address_x),
    .ctrl_address_y(tb_ctrl_address_y),
    .ctrl_sheetsize(tb_ctrl_sheetsize),
    .ctrl_width(tb_ctrl_width),
    .ctrl_height(tb_ctrl_height),
    .ctrl_x(tb_ctrl_x),
    .ctrl_y(tb_ctrl_y),
    .ctrl_draw(tb_ctrl_draw),
    .ctrl_full(gpu_ctrl_full),
    .ctrl_clear(tb_ctrl_clear),
    .ctrl_clear_color(tb_ctrl_clear_color),
    
    .fb_x(gpu_fb_x),
    .fb_y(gpu_fb_y),
    .fb_color(gpu_fb_color),
    .fb_write(gpu_fb_write)
);

wire[15:0] memory_r_data;
localparam MEM_DEPTH = 1024;
memory
#(
    .WIDTH(16),
    .DEPTH(MEM_DEPTH)
)
memory
(
    .clk(tb_clk),
    .address(gpu_mem_addr),
    .w_data(gpu_mem_wdata),
    .w_write(gpu_mem_write),
    .r_data(memory_r_data)
);

always @(tb_clk) begin
    #1 tb_clk <= ~tb_clk;
end

initial begin
    $dumpvars(0, main_tb);
    for(integer i = 0; i < MEM_DEPTH; i++) begin
        memory.mem[i] <= i;
        $dumpvars(0, memory.mem[i]);
    end
    for(integer i = 0; i < 8; i++)begin
        $dumpvars(0, gpu.queue_drawcalls.valid[i]);
        $dumpvars(0, gpu.queue_drawcalls.queue[i]);
    end

    tb_clk <= 1;
    #10 tb_rstn <= 1;

    #20 tb_ctrl_address <= 8;
    #6 tb_ctrl_address_x <= 2;
    #6 tb_ctrl_address_y <= 2;
    #6 tb_ctrl_sheetsize <= 64;
    #6 tb_ctrl_width <= 8;
    #6 tb_ctrl_height <= 16;
    #6 tb_ctrl_x <= 1;
    #6 tb_ctrl_y <= 1;
    #6 tb_ctrl_draw <= 1;
    #6 tb_ctrl_draw <= 0;
    
    
     tb_ctrl_address <= 5;
     tb_ctrl_address_x <= 2;
     tb_ctrl_address_y <= 1;
     tb_ctrl_sheetsize <= 47;
     tb_ctrl_width <= 5;
     tb_ctrl_height <= 32;
     tb_ctrl_x <= 55;
     tb_ctrl_y <= 55;
    #2 tb_ctrl_draw <= 1;
    #2 tb_ctrl_draw <= 0;

    #4 tb_ctrl_address <= 11111;
    tb_ctrl_address_x <= 2;
    tb_ctrl_address_y <= 1;
    tb_ctrl_sheetsize <= 50;
    tb_ctrl_width <= 2;
    tb_ctrl_height <= 4;
    tb_ctrl_x <= 55;
    tb_ctrl_y <= 55;
    #2 tb_ctrl_draw <= 1;
    #2 tb_ctrl_draw <= 0;

    #1000 tb_ctrl_clear <= 1;
    #6 tb_ctrl_clear <= 0;

    #100000 $finish;
end

endmodule
