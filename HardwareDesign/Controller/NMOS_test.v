module nmos_test (
    input[6:0] btn,
    input clk_25mhz,
    output[7:0] led,
    output reg audio_sclk = 0
);

reg[22:0] counter = 0;
reg[22:0] next = counter + 1;
reg counting = 0;
wire fire1 = btn[1];
reg old_fire1;

assign led[7] = fire1;
assign led[6] = counting;
assign led[5:0] = counter[22:18];

always @(posedge clk_25mhz) begin
    if(fire1 == 1 && old_fire1 == 0) begin
        audio_sclk <= ~audio_sclk; 
        counting <= 1;
    end
    if(next == 0)
        counting <= 0;
    
    if(counting)
        counter <= next;
    else
        counter <= 0;
    old_fire1 <= fire1;
end

endmodule