module top (
    input[6:0] btn,
    input clk_25mhz,
    output[3:0] audio_l,
    output[3:0] audio_r
);

assign audio_l = wave[15:12];
assign audio_r = wave[15:12];

reg[18:0] clk_div = 0;
wire clk_195khz = clk_div[6];
wire clk_190hz = clk_div[17];

always @(posedge clk_25mhz) begin
    clk_div <= clk_div + 1;
end

always @(posedge clk_190hz) begin
    if(btn[1])
        period <= period - 1;
    if(btn[2])
        period <= period + 1;

    if(btn[4])
        duty_cycle <= duty_cycle - 1;
    if(btn[3])
        duty_cycle <= duty_cycle + 1;

    if(btn[5])
        volume <= volume - 128;
    if(btn[6])
        volume <= volume + 128;
end

reg[15:0] volume = 'b0110000000000000;
reg[15:0] duty_cycle = 110;
reg[15:0] period = 440;
wire[15:0] wave;

channel 
#(
    .WIDTH(16)
)
channel 
(
    .clk(clk_195khz),
    .rstn(1),
    .volume(volume),
    .duty_cycle(duty_cycle),
    .period(period),
    .wave(wave)
);

endmodule