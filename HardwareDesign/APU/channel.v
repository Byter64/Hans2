module channel 
#(
    parameter WIDTH = 16
)
(
    input clk,
    input rstn,

    input[WIDTH-1:0] volume, //Signed int. Note, that only the highest 4 bit will be used for actual sound volume
    input[WIDTH-1:0] duty_cycle, //In ticks. How many ticks within the period is the wave high
    input[WIDTH-1:0] period, //Period time in ticks

    output[WIDTH-1:0] wave
);

reg[WIDTH-1:0] period_counter = 0;
assign wave = period_counter < duty_cycle ? volume : ~volume;

always @(posedge clk) begin
    if(rstn == 0) begin
        period_counter <= 0;
    end else begin
        period_counter = period_counter + 1;
        if(period_counter + 1 == period) begin
            period_counter <= 0;
        end
    end
end
    
endmodule