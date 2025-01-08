module BufferController (
    input clk,
    input reset,
    input swapIn,
    input vSync,
    input isSynchronized,

    output reg fbGPU,
    output fbHDMI
);

reg[1:0] state = 0;
localparam WAIT = 1;
localparam SWAP = 2;

reg oldSwapIn;
reg oldVSync;

always @(posedge clk) begin
    if(state == SWAP) begin
        fbGPU <= ~fbGPU;
    end
end
assign fbHDMI = ~fbGPU;


always @(posedge clk) begin
    oldSwapIn <= swapIn;
    oldVSync <= vSync;

    if(isSynchronized) begin
        if(state == 0 && oldSwapIn == 0 && swapIn == 1) begin
            state <= WAIT;
        end
        if(state == WAIT && oldVSync == 0 && vSync == 1) begin
            state <= SWAP;
        end
        if(state == SWAP) begin
            state <= 0;
        end
    end
    else begin
        if(state == 0 && oldSwapIn == 0 && swapIn == 1) begin
            state <= SWAP;
        end
        if(state == SWAP) begin
            state <= 0;
        end
    end

    if(reset) begin
        state <= 0;
        oldSwapIn <= 0;
        oldVSync <= 0;
    end
end

endmodule