module memory 
#(
    parameter WIDTH = 16,
    parameter DEPTH = 1
) 
(
    input clk,
    input[$clog2(DEPTH) - 1 : 0] address,
    input[WIDTH - 1 : 0] w_data,
    input w_write,                  //Tells memory to write

    output[WIDTH - 1 : 0] r_data
);

reg[WIDTH - 1 : 0] mem[0 : DEPTH - 1];

assign r_data = mem[address];

always @(posedge clk) begin
    if(w_write) begin
        mem[address] <= w_data;
    end
end

endmodule