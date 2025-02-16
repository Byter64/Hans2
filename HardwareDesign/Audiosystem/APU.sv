import ChannelData::*;

module APU #(
    parameter channelCount = 8;
) (
    input clk,
    input rst

    input clk_1024khz,
    input clk_64khz,

    I2S.Transmitter i2s
    /*Wishbone Interface*/
);

assign i2s.bclk = clk_1024khz;
assign i2s.lrclk = clk_64khz;

ChannelData channelDatas[channelCount];

endmodule