module queue #(
    parameter DEPTH = 8,
    parameter WIDTH = 32
) (
    input clk,
    input rstn,

    input  [WIDTH - 1 : 0]  i_data, //The next data to push
    input                   push,   //Tells the queue to push i_data

    output reg[WIDTH - 1 : 0] o_data, //The popped out data
    input                     pop,    //Tells the queue to pop. If empty, result is undefinied
    output                    full,   //Tells if queue is full
    output                    empty   //Tells if queue is empty
);

reg [WIDTH - 1 :0] queue [0 : DEPTH - 1];
reg                valid [0 : DEPTH - 1]; //Valid bit for the queue
assign full = valid[0];
assign empty = !valid[DEPTH - 1];

always @(posedge clk) begin
    if(rstn == 0) begin
        for(integer i = 0; i < DEPTH; i++)
            valid[i] <= 0;
        o_data <= 0;
    end
    else 
    begin
        if(push && !full) begin
            queue[0] <= i_data;
            valid[0] <= 1;
        end

        for(integer i = 0; i < DEPTH - 1; i++) begin
            if(valid[i] && !valid[i + 1]) begin
                queue[i + 1] <= queue[i];
                valid[i + 1] <= valid[i];
                valid[i] <= 0;
            end
        end

        if(pop) begin
            o_data <= queue[DEPTH - 1];
            valid[DEPTH - 1] <= 0;
        end
    end
end


endmodule