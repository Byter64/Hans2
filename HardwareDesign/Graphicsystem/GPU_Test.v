//yosys -p"read_verilog ULX3S_hdmi\TMDS_encoder.v HDMI_Out.v GPU.v GPU_Test.v; synth_ecp5 -json Ausgabe.json"

module HDMI_Test (
    input clk_25mhz,
    output[3:0] gpdi_dp
);

localparam SCREEN_WIDTH = 400;
localparam SCREEN_HEIGHT = 240;

//Framebuffer sozusagen
reg[15:0] frameBuffer[0:SCREEN_WIDTH * SCREEN_HEIGHT];
//initial $readmemh("testbild.txt", frameBuffer);
//Framebuffer sozusagen Ende

//HDMI Out
reg[15:0] pixelData;
wire[7:0] red, green, blue;
wire[10:0] nextX, nextY;
wire hSync, vSync;
wire pixclk;


wire[18:0] nextPixel = ((nextX >> 1) + (nextY >> 1) * SCREEN_WIDTH);
assign red   = {pixelData[15:11], 3'b0};
assign green = {pixelData[10:6], 3'b0};
assign blue  = {pixelData[5:1], 3'b0};


always @(posedge pixclk) pixelData <= frameBuffer[nextPixel];

HDMI_Out HDMI_Out 
(
    .clk_25mhz(clk_25mhz),
    .red(red),
    .green(green),
    .blue(blue),

    .pixclk(pixclk),
    .nextX(nextX),
    .nextY(nextY),
    .hSync(hSync),
    .vSync(vSync),
    .gpdi_dp(gpdi_dp)

);
//HDMI Out Ende

//GPU
reg[15:0] memory[0:SCREEN_WIDTH * SCREEN_HEIGHT];
initial $readmemh("testbild2.txt", memory);

wire GPU_Clk;
reg[15:0] GPU_MemData;
wire[31:0] GPU_MemAddr;
wire GPU_MemRead;

wire[15:0] GPU_CtrlAddress, GPU_CtrlAddressX, GPU_CtrlAddressY;
wire[15:0] GPU_CtrlImageWidth;
wire[9:0] GPU_CtrlWidth;
wire[8:0] GPU_CtrlHeight;
wire[9:0] GPU_CtrlX;
wire[8:0] GPU_CtrlY;
reg GPU_CtrlDraw;

wire[15:0] GPU_CtrlClearColor;
reg GPU_CtrlClear;
wire GPU_CtrlBusy;
wire[8:0] GPU_FbX;
wire[7:0] GPU_FbY;
wire[15:0] GPU_FbColor;
wire GPU_FbWrite;

assign GPU_Clk = pixclk;
always @(posedge GPU_Clk) if(GPU_MemRead) GPU_MemData <= memory[GPU_MemAddr];

reg[6:0] counterX = 0;
wire[6:0] counterXNext = counterX < 72 ? counterX+1 : 0;
reg counterY = 0; //Gibt nur 2 Reihen im Testbild
reg oldVSync = 0;
reg vSyncCounter = 0;
reg[1:0] drawState = 0;
always @(posedge pixclk) begin
    oldVSync <= vSync;
    GPU_CtrlDraw <= 0;
    GPU_CtrlClear <= 0;
    if(oldVSync == 0 && vSync == 1 && drawState == 0) begin
        vSyncCounter <= vSyncCounter + 1;
        if(vSyncCounter == 0) begin
            GPU_CtrlClear <= 1;
            drawState <= 1;
            counterX <= counterXNext;
            if(counterXNext == 0) counterY <= ~counterY;            
        end
    end

    if(drawState == 1 && GPU_CtrlBusy == 0) begin
        GPU_CtrlDraw <= 1;
        drawState <= 0;
    end

    if(drawState == 2 && GPU_CtrlBusy == 0) begin
        GPU_CtrlDraw <= 1;
        drawState <= 0;
    end
end

assign GPU_CtrlAddress = 0;
assign GPU_CtrlAddressX = counterX[6:2] * 21;
assign GPU_CtrlAddressY = counterY * 23;
assign GPU_CtrlX = 40;
assign GPU_CtrlY = 40;
assign GPU_CtrlImageWidth = 19 * 21; //19 Bilder mit Breite 21
assign GPU_CtrlWidth = 21;
assign GPU_CtrlHeight = 23;

assign GPU_CtrlClearColor = 16'b1101100010110111; //R5G5B5A1
always @(posedge pixclk) if(GPU_FbWrite) frameBuffer[GPU_FbX + GPU_FbY * SCREEN_WIDTH] <= GPU_FbColor;

GPU GPU (
    .clk(GPU_Clk),
    .reset(1'b0),

    //MEM INTERFACE
    .mem_data(GPU_MemData),
    .mem_valid(1'b1),
    .mem_addr(GPU_MemAddr), //out
    .mem_read(GPU_MemRead), //out

    //CONTROL INTERFACE: Draw
    .ctrl_address(GPU_CtrlAddress),
    .ctrl_address_x(GPU_CtrlAddressX),
    .ctrl_address_y(GPU_CtrlAddressY),
    .ctrl_image_width(GPU_CtrlImageWidth),
    .ctrl_width(GPU_CtrlWidth),
    .ctrl_height(GPU_CtrlHeight),
    .ctrl_x(GPU_CtrlX),
    .ctrl_y(GPU_CtrlY),
    .ctrl_draw(GPU_CtrlDraw),

    //CONTROL INTERFACE: Clear
    .ctrl_clear_color(GPU_CtrlClearColor),
    .ctrl_clear(GPU_CtrlClear),

    //Output
    .crtl_busy(GPU_CtrlBusy),


    //FRAMEBUFFER INTERFACE
    .fb_x(GPU_FbX),
    .fb_y(GPU_FbY),
    .fb_color(GPU_FbColor),
    .fb_write(GPU_FbWrite)
);
//GPU Ende
endmodule