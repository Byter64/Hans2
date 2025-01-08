module BufferController (
    input clk,
    input reset,
    input swapIn,
    input vSync,
    input isSynchronized,

    output reg fbGPU,
    output fbHDMI
);

reg[1:0] state;
reg[1:0] nextState;
localparam IDLE = 0;
localparam WAIT = 1;
localparam SWAP = 2;

reg oldSwapIn;
reg oldVSync;

always@(*) begin
    case (state)
        IDLE: nextState <= (oldSwapIn == 0 && swapIn == 1) ? (isSynchronized ? WAIT : SWAP) : state;
        WAIT: nextState <= (oldVSync == 0 && vSync == 1) ? SWAP : state;
        SWAP: nextState <= IDLE;
        default: nextState <= IDLE;
    endcase
end

always @(posedge clk) begin
    state <= nextState;
end

always @(posedge clk) begin
    oldSwapIn <= swapIn;
    oldVSync <= vSync;

    if(reset) begin
        state <= 0;
        oldSwapIn <= 0;
        oldVSync <= 0;
    end
end

always @(posedge clk) begin
    if(state == SWAP) begin
        fbGPU <= ~fbGPU;
    end
end
assign fbHDMI = ~fbGPU;

endmodule