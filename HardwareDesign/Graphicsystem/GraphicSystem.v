//yosys -p"read_verilog ULX3S_hdmi\TMDS_encoder.v HDMI_Out.v GPU.v BufferController.v Framebuffer.v GraphicSystem.v; synth_ecp5 -json Ausgabe.json"

module GraphicSystem 
(
    input clk25Mhz,
    input gpuClk,
    input bufferControllerClk,
    input reset,
    output[3:0] gpdiDp,
    output hdmi_pixClk,
    output hdmi_vSync,

    input swapBuffers,
    input isVSynced,

    input[15:0]  gpu_MemData,
    input        gpu_MemValid,
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

wire[9:0]   gpu_FbX;
wire[8:0]   gpu_FbY;
wire[15:0]  gpu_FbColor;
wire        gpu_FbWrite;
wire[10:0]  hdmi_nextX;
wire[10:0]  hdmi_nextY;
wire        hdmi_hSync;
wire[15:0]  fb2_dataOutA;
wire[15:0]  fb2_dataOutB;
wire bfCont_fbGPU;
wire bfCont_fbHDMI;
wire[15:0]  fb1_dataOutA;
wire[15:0]  fb1_dataOutB;
wire[16:0] gpu_fbAddress = gpu_FbX + gpu_FbY * SCREEN_WIDTH;
wire[16:0] hdmi_fbAddress = ((hdmi_nextX >> 1) + (hdmi_nextY >> 1) * SCREEN_WIDTH); //this halves the resoluton from 480x800 to 240x400
wire[15:0] hdmi_color = bfCont_fbHDMI == 0 ? fb1_dataOutB : fb2_dataOutB;

BufferController bfCont(
    .clk(bufferControllerClk),
    .reset(reset),
    .swapIn(swapBuffers),
    .vSync(hdmi_vSync),
    .isSynchronized(isVSynced),

    .fbGPU(bfCont_fbGPU),
    .fbHDMI(bfCont_fbHDMI)
);

Framebuffer #(
    .WIDTH(16),
    .DEPTH(SCREEN_HEIGHT * SCREEN_WIDTH)
) fb1 (
    .clkA(hdmi_pixClk),
    .dataInA(gpu_FbColor),
    .addressA(gpu_fbAddress),
    .writeEnableA(bfCont_fbGPU == 1'b0 ? gpu_FbWrite : 1'b0),
    
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
    .clkA(hdmi_pixClk),
    .dataInA(gpu_FbColor),
    .addressA(gpu_fbAddress),
    .writeEnableA(bfCont_fbGPU == 1'b1 ? gpu_FbWrite : 1'b0),

    .clkB(hdmi_pixClk),
    .dataInB(16'b0),
    .addressB(hdmi_fbAddress),
    .writeEnableB(1'b0),

    .dataOutA(fb2_dataOutA),
    .dataOutB(fb2_dataOutB)
);


/*The gpu_mem... and gpu_Ctrl... signals are direct in-/outputs on the GraphicSystem*/
GPU #(
    .FB_WIDTH(SCREEN_WIDTH),
    .FB_HEIGHT(SCREEN_HEIGHT)
) gpu (
    .clk(gpuClk),
    .reset(reset),
    //MEM INTERFACE
    .mem_data(gpu_MemData),
    .mem_valid(gpu_MemValid),
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


HDMI_Out hdmi_Out 
(
    //In
    .clk_25mhz(clk25Mhz),
    .red({hdmi_color[15:11], 3'b0}),
    .green({hdmi_color[10:6], 3'b0}),
    .blue({hdmi_color[5:1], 3'b0}),

    //Out
    .pixclk(hdmi_pixClk),
    .nextX(hdmi_nextX),
    .nextY(hdmi_nextY),
    .hSync(hdmi_hSync),
    .vSync(hdmi_vSync),
    .gpdi_dp(gpdiDp)

);

endmodule