//yosys -p"read_verilog ULX3S_hdmi\TMDS_encoder.v HDMI_Out.v GPU.v BufferController.v Framebuffer.v GraphicSystem.v GraphicSystem_Test.v; synth_ecp5 -json Ausgabe.json"


module GraphicSystem_Test (
    input clk_25mhz,
    output[3:0] gpdi_dp
);


reg  swapBuffers;
reg  isVSynced;
reg[15:0]  gpu_MemData;
wire[31:0] gpu_MemAddr;
wire gpu_MemRead;
reg[31:0]  gpu_CtrlAddress;
reg[15:0]  gpu_CtrlAddressX;
reg[15:0]  gpu_CtrlAddressY;
reg[15:0]  gpu_CtrlImageWidth;
reg[10:0]  gpu_CtrlWidth;
reg[9:0]  gpu_CtrlHeight;
reg[10:0]  gpu_CtrlX;
reg[9:0]  gpu_CtrlY;
reg  gpu_CtrlDraw;
reg[15:0]  gpu_CtrlClearColor;
reg  gpu_CtrlClear;
wire gpu_CtrlBusy;

GraphicSystem graphicSystem 
(
    .clk25Mhz(clk_25mhz),
    .cpuClk(clk_25mhz),
    .reset(1'b0),
    .gpdiDp(gpdi_dp),
    .swapBuffers(swapBuffers),
    .isVSynced(isVSynced),
    .gpu_MemData(gpu_MemData),
    .gpu_MemValid(gpu_MemValid),
    .gpu_MemAddr(gpu_MemAddr),
    .gpu_MemRead(gpu_MemRead),
    .gpu_CtrlAddress(gpu_CtrlAddress),
    .gpu_CtrlAddressX(gpu_CtrlAddressX),
    .gpu_CtrlAddressY(gpu_CtrlAddressY),
    .gpu_CtrlImageWidth(gpu_CtrlImageWidth),
    .gpu_CtrlWidth(gpu_CtrlWidth),
    .gpu_CtrlHeight(gpu_CtrlHeight),
    .gpu_CtrlX(gpu_CtrlX),
    .gpu_CtrlY(gpu_CtrlY),
    .gpu_CtrlDraw(gpu_CtrlDraw),
    .gpu_CtrlClearColor(gpu_CtrlClearColor),
    .gpu_CtrlClear(gpu_CtrlClear),
    .gpu_CtrlBusy(gpu_CtrlBusy)
);

endmodule