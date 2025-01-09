//yosys -p"read_verilog ULX3S_hdmi\TMDS_encoder.v HDMI_Out.v GPU.v BufferController.v Framebuffer.v GraphicSystem.v GraphicSystem_Test.v; synth_ecp5 -json Ausgabe.json"


module GraphicSystem_Test (
    input clk_25mhz,
    output[3:0] gpdi_dp
);


wire swapBuffers;
wire isVSynced;
wire gpu_MemData;
wire gpu_MemAddr;
wire gpu_MemRead;
wire gpu_CtrlAddress;
wire gpu_CtrlAddressX;
wire gpu_CtrlAddressY;
wire gpu_CtrlImageWidth;
wire gpu_CtrlWidth;
wire gpu_CtrlHeight;
wire gpu_CtrlX;
wire gpu_CtrlY;
wire gpu_CtrlDraw;
wire gpu_CtrlClearColor;
wire gpu_CtrlClear;
wire gpu_CtrlBusy;

GraphicSystem graphicSystem 
(
    .clk25Mhz(clk_25mhz),
    .cpuClk(clk_25mhz),
    .reset(1'b0),
    .gpdiDp(gpdi_dp),
    .swapBuffers,
    .isVSynced,
    .gpu_MemData,
    .gpu_MemAddr,
    .gpu_MemRead,
    .gpu_CtrlAddress,
    .gpu_CtrlAddressX,
    .gpu_CtrlAddressY,
    .gpu_CtrlImageWidth,
    .gpu_CtrlWidth,
    .gpu_CtrlHeight,
    .gpu_CtrlX,
    .gpu_CtrlY,
    .gpu_CtrlDraw,
    .gpu_CtrlClearColor,
    .gpu_CtrlClear,
    .gpu_CtrlBusy
);

endmodule