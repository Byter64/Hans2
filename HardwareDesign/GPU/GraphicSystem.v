//yosys -p"read_verilog ULX3S_hdmi\TMDS_encoder.v HDMI_Out.v GPU.v BufferController.v Framebuffer.v GraphicSystem.v; synth_ecp5 -json Ausgabe.json"

module GraphicSystem 
(
    input clk25Mhz,
    input cpuClk,
    input reset,
    input[3:0] gpdiDp,

    input swapBuffers,
    input isVSynced,

    input[15:0]  gpu_MemData,
    output[31:0] gpu_MemAddr,
    output       gpu_MemRead,
    input[31:0]  gpu_CtrlAddress,
    input[15:0]  gpu_CtrlAddressX,
    input[15:0]  gpu_CtrlAddressY,
    input[15:0]  gpu_CtrlImageWidth,
    input[10:0]  gpu_CtrlWidth,
    input[9:0]   gpu_CtrlHeight,
    input[10:0]  gpu_CtrlX,
    input[9:0]   gpu_CtrlY,
    input        gpu_CtrlDraw,
    input[15:0]  gpu_CtrlClearColor,
    input        gpu_CtrlClear,
    output       gpu_CtrlBusy
);

localparam SCREEN_WIDTH = 400;
localparam SCREEN_HEIGHT = 240;

assign bfCont_clk   = cpuClk;
assign hdmi_clk25Mhz = clk25Mhz;
assign fb1_clkA     = hdmi_pixClk;
assign fb1_clkB     = hdmi_pixClk;
assign fb2_clkA     = hdmi_pixClk;
assign fb2_clkB     = hdmi_pixClk;
assign gpu_Clk      = hdmi_pixClk;

assign bfCont_swapIn = swapBuffers;
assign bfCont_vSync = hdmi_vSync;
assign bfCont_isSynchronized = isVSynced;

wire[15:0] gpu_fbAddress = gpu_FbX + gpu_FbY * SCREEN_WIDTH;
wire[16:0] hdmi_fbAddress = ((hdmi_nextX >> 1) + (hdmi_nextY >> 1) * SCREEN_WIDTH); //this halves the resoluton from 480x800 to 240x400

assign fb1_dataInA = gpu_FbColor;
assign fb1_addressA = gpu_fbAddress;
assign fb1_writeEnableA = bfCont_fbGPU == 0 ? gpu_FbWrite : 0;
assign fb1_dataInB = 0;
assign fb1_addressB = hdmi_fbAddress;
assign fb1_writeEnableB = 0;

assign fb2_dataInA = gpu_FbColor;
assign fb2_addressA = gpu_fbAddress;
assign fb2_writeEnableA = bfCont_fbGPU == 1 ? gpu_FbWrite : 0;
assign fb2_dataInB = 0;
assign fb2_addressB = hdmi_fbAddress;
assign fb2_writeEnableB = 0;


wire[15:0] hdmi_color = bfCont_fbHDMI == 0 ? fb1_dataOutB : fb2_dataOutB;
assign hdmi_red   = {hdmi_color[15:11], 3'b0};
assign hdmi_green = {hdmi_color[10:6], 3'b0};
assign hdmi_blue  = {hdmi_color[5:1], 3'b0};


wire bfCont_clk;
wire bfCont_swapIn;
wire bfCont_vSync;
wire bfCont_isSynchronized;
wire bfCont_fbGPU;
wire bfCont_fbHDMI;
BufferController bfCont(
    .clk(bfCont_clk),
    .reset(reset),
    .swapIn(bfCont_swapIn),
    .vSync(bfCont_vSync),
    .isSynchronized(bfCont_isSynchronized),

    .fbGPU(bfCont_fbGPU),
    .fbHDMI(bfCont_fbHDMI)
);

wire        fb1_clkA;
wire[15:0]  fb1_dataInA;
wire[16:0]  fb1_addressA;
wire        fb1_writeEnableA;
wire[15:0]  fb1_dataOutA;
wire        fb1_clkB;
wire[15:0]  fb1_dataInB;
wire[16:0]  fb1_addressB;
wire        fb1_writeEnableB;
wire[15:0]  fb1_dataOutB;
Framebuffer #(
    .WIDTH(16),
    .DEPTH(SCREEN_HEIGHT * SCREEN_WIDTH)
) fb1 (
    .clkA(fb1_clkA),
    .dataInA(fb1_dataInA),
    .addressA(fb1_addressA),
    .writeEnableA(fb1_writeEnableA),
    .dataOutA(fb1_dataOutA),
    .clkB(fb1_clkB),
    .dataInB(fb1_dataInB),
    .addressB(fb1_addressB),
    .writeEnableB(fb1_writeEnableB),
    .dataOutB(fb1_dataOutB)
);

wire        fb2_clkA;
wire[15:0]  fb2_dataInA;
wire[16:0]  fb2_addressA;
wire        fb2_writeEnableA;
wire[15:0]  fb2_dataOutA;
wire        fb2_clkB;
wire[15:0]  fb2_dataInB;
wire[16:0]  fb2_addressB;
wire        fb2_writeEnableB;
wire[15:0]  fb2_dataOutB;
Framebuffer #(
    .WIDTH(16),
    .DEPTH(SCREEN_HEIGHT * SCREEN_WIDTH)
) fb2 (
    .clkA(fb2_clkA),
    .dataInA(fb2_dataInA),
    .addressA(fb2_addressA),
    .writeEnableA(fb2_writeEnableA),
    .dataOutA(fb2_dataOutA),
    .clkB(fb2_clkB),
    .dataInB(fb2_dataInB),
    .addressB(fb2_addressB),
    .writeEnableB(fb2_writeEnableB),
    .dataOutB(fb2_dataOutB)
);


wire        gpu_Clk;
/*The gpu_mem... and gpu_Ctrl... signals are direct in-/outputs on the GraphicSystem*/
wire[9:0]   gpu_FbX;
wire[8:0]   gpu_FbY;
wire[15:0]  gpu_FbColor;
wire        gpu_FbWrite;
GPU #(
    .FB_WIDTH(SCREEN_WIDTH),
    .FB_HEIGHT(SCREEN_HEIGHT)
) gpu (
    .clk(gpu_Clk),
    .reset(reset),
    //MEM INTERFACE
    .mem_data(gpu_MemData),
    .mem_addr(gpu_MemAddr),
    .mem_read(gpu_MemRead),
    //CONTROL INTERFACE: Draw
    .ctrl_address(gpu_CtrlAddress),
    .ctrl_address_x(gpu_CtrlAddressX),
    .ctrl_address_y(gpu_CtrlAddressY),
    .ctrl_image_width(gpu_CtrlImageWidth),
    .ctrl_width(gpu_CtrlWidth),
    .ctrl_height(gpu_CtrlHeight),
    .ctrl_x(gpu_CtrlX),
    .ctrl_y(gpu_CtrlY),
    .ctrl_draw(gpu_CtrlDraw),
    //CONTROL INTERFACE: Clear
    .ctrl_clear_color(gpu_CtrlClearColor),
    .ctrl_clear(gpu_CtrlClear),
    .crtl_busy(gpu_CtrlBusy),
    //FRAMEBUFFER INTERFACE
    .fb_x(gpu_FbX),
    .fb_y(gpu_FbY),
    .fb_color(gpu_FbColor),
    .fb_write(gpu_FbWrite)
);

wire        hdmi_clk25Mhz;
wire[7:0]   hdmi_red;
wire[7:0]   hdmi_green;
wire[7:0]   hdmi_blue;
wire        hdmi_pixClk;
wire[10:0]  hdmi_nextX;
wire[10:0]  hdmi_nextY;
wire        hdmi_hSync;
wire        hdmi_vSync;
wire[3:0]   hdmi_gpdiDp;
HDMI_Out hdmi_Out 
(
    //In
    .clk_25mhz(hdmi_clk25Mhz),
    .red(hdmi_red),
    .green(hdmi_green),
    .blue(hdmi_blue),

    //Out
    .pixclk(hdmi_pixClk),
    .nextX(hdmi_nextX),
    .nextY(hdmi_nextY),
    .hSync(hdmi_hSync),
    .vSync(hdmi_vSync),
    .gpdi_dp(hdmi_gpdiDp)

);

endmodule