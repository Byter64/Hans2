module HDMI_Test (
    input clk_25mhz,
    output[3:0] gpdi_dp,
);

reg[15:0] image[0:400*240];
reg[15:0] pixelData;
wire[7:0] red, green, blue;
wire[10:0] nextX, nextY;
wire pixclk;

initial begin
    $readmemh("testbild.txt", image);
end

wire[18:0] nextPixel = ((nextX >> 1) + (nextY >> 1) * 400);
assign red   = {pixelData[15:11], 3'b0};
assign green = {pixelData[10:6], 3'b0};
assign blue  = {pixelData[5:1], 3'b0};


always @(posedge pixclk) begin
    pixelData <= image[nextPixel];
end

HDMI_Out HDMI_Out 
(
    .clk_25mhz(clk_25mhz),
    .red(red),
    .green(green),
    .blue(blue),

    .pixclk(pixclk),
    .nextX(nextX),
    .nextY(nextY),
    .gpdi_dp(gpdi_dp)

);

endmodule