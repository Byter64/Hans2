module fifo #(
    parameter DATA_WIDTH = 8,
    parameter MAX_QUEUE_SIZE = 1024
)(
    input logic clk,
    input logic rst,
    input logic enqueue,
    input logic dequeue,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out,
    output logic empty,
    output logic full,
    output logic [$clog2(MAX_QUEUE_SIZE):0] queue_size
);
    // Queue structure
    reg [DATA_WIDTH-1:0] queue_data [MAX_QUEUE_SIZE-1:0];
    //Pointer to first element of the queue
    reg [$clog2(MAX_QUEUE_SIZE)-1:0] beginning = 0;
    //Pointer to last element of the queue
    reg [$clog2(MAX_QUEUE_SIZE)-1:0] ending = -1;

    // Queue empty and full flags
    assign empty = (queue_size == 0);
    assign full = (queue_size == MAX_QUEUE_SIZE);

    always_ff @(posedge clk) begin
        if (enqueue && (!full || dequeue)) begin
            queue_data[beginning] <= data_in;
        end
    end

    always_ff @(posedge clk) begin
        data_out <= queue_data[ending];
    end

    always_ff @(posedge clk) begin
        if (enqueue && !full) begin
            queue_size <= queue_size + 1'b1;
        end
        if (dequeue && !empty) begin
            queue_size <= queue_size - 1'b1;
        end
        if(enqueue && dequeue) begin
            queue_size <= queue_size;
        end
        if(rst) begin
            queue_size <= 0;
        end
    end

    always_ff @(posedge clk) begin
        if (enqueue && (!full || dequeue)) begin
            beginning <= (beginning + 1'b1);
        end
        if(rst) begin
            beginning <= 1'b0;
        end
    end
    always_ff @(posedge clk) begin
        if (dequeue && (!empty || enqueue)) begin
            ending <= (ending + 1'b1);
        end
        if(rst) begin
            ending <= -1;
        end
    end
endmodule