//yosys -p"read_verilog ULX3S_hdmi\TMDS_encoder.v HDMI_Out.v GPU.v BufferController.v Framebuffer.v GraphicSystem.v GraphicSystem_Test.v; synth_ecp5 -json Ausgabe.json"


module GraphicSystem_Test (
    input clk_25mhz,
    output[3:0] gpdi_dp
);

reg[15:0] memory[18354];
initial $readmemh("testbild2.txt", memory);

reg[7:0] state = 0;
localparam WAIT1 = 0;
localparam SET_CLEAR_DATA = 1;
localparam SET_CLEAR = 2;
localparam WAIT2 = 3;
localparam SET_DRAW_DATA = 4;
localparam SET_DRAW = 5;
localparam WAIT3 = 6;
localparam SWAP_BUFFER = 7;
localparam WAIT4 = 8;

reg[7:0] counterX = 0;
wire[7:0] counterXNext = counterX < 144 ? counterX+1 : 0;
reg counterY = 0; //Gibt nur 2 Reihen im Testbild
reg old_hdmi_vSync = 0;
always @(posedge hdmi_pixClk) begin
    old_hdmi_vSync <= hdmi_vSync;
    gpu_CtrlClear <= 0;
    gpu_CtrlDraw <= 0;
    swapBuffers <= 0;

    case (state)
        WAIT1: begin
            if(!gpu_CtrlBusy) 
                state <= SET_CLEAR_DATA;
        end
        SET_CLEAR_DATA: begin
            state <= SET_CLEAR;
            //This line causes combinational loops?!?!?
            //gpu_CtrlClearColor <= gpu_CtrlClearColor + 1;
        end
        SET_CLEAR: begin
            gpu_CtrlClear <= 1;
            state <= WAIT2;
        end
        WAIT2: begin
            if(!gpu_CtrlBusy)
                state <= SET_DRAW_DATA;
        end
        SET_DRAW_DATA: begin
            counterX <= counterXNext;
            if(counterXNext == 0) counterY <= ~counterY;

            gpu_CtrlAddress <= 0;
            gpu_CtrlAddressX <= counterX[7:3] * 21;
            gpu_CtrlAddressY <= counterY * 23;
            gpu_CtrlImageWidth <= 19 * 21; //19 Bilder mit Breite 21
            gpu_CtrlWidth <= 21;
            gpu_CtrlHeight <= 23;
            gpu_CtrlX <= 40;
            gpu_CtrlY <= 40;
            state <= SET_DRAW;
        end
        SET_DRAW: begin
            gpu_CtrlDraw <= 1;
            state <= WAIT3;
        end
        WAIT3: begin
            if(!gpu_CtrlBusy)
                state <= SWAP_BUFFER;
        end
        SWAP_BUFFER: begin
            swapBuffers <= 1;
            state <= WAIT4;
        end
        WAIT4: begin
            if(hdmi_vSync == 1 && old_hdmi_vSync == 0)
                state <= WAIT1; 
        end
    endcase
end

always @(posedge hdmi_pixClk) begin
    gpu_MemData <= memory[gpu_MemAddr];
end


reg         swapBuffers;
reg         isVSynced = 1'b1;
reg[15:0]   gpu_MemData;
wire[31:0]  gpu_MemAddr;
wire        gpu_MemRead;
reg[31:0]   gpu_CtrlAddress;
reg[15:0]   gpu_CtrlAddressX;
reg[15:0]   gpu_CtrlAddressY;
reg[15:0]   gpu_CtrlImageWidth;
reg[10:0]   gpu_CtrlWidth;
reg[9:0]    gpu_CtrlHeight;
reg[10:0]   gpu_CtrlX;
reg[9:0]    gpu_CtrlY;
reg         gpu_CtrlDraw;
reg[15:0]   gpu_CtrlClearColor = 16'b1101100010110111;
reg         gpu_CtrlClear;
wire        gpu_CtrlBusy;
wire        hdmi_pixClk;
wire        hdmi_vSync;

GraphicSystem graphicSystem 
(
    .clk25Mhz(clk_25mhz),
    .cpuClk(hdmi_pixClk),
    .reset(1'b0),
    .gpdiDp(gpdi_dp),
    .hdmi_pixClk(hdmi_pixClk),
    .hdmi_vSync(hdmi_vSync),
    .swapBuffers(swapBuffers),
    .isVSynced(isVSynced),
    .gpu_MemData(gpu_MemData),
    .gpu_MemValid(1'b1),
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