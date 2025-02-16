module Decoder (
    input clk,
    input rst,

    input[11:0] encodedDelta,
    output[15:0] sample
);

logic[12:0] delta;

assign delta[12:1] = encodedDelta;
assign delta[0] = 1'b0;

always_ff @(posedge clk) begin
    sample <= sample + delta;
    
    if(rst) begin
        sample <= 0;
    end
end

endmodule