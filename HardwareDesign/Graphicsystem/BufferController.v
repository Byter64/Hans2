module BufferController (
    input clk,
    input reset,
    input swapIn,
    input vSync,
    input isSynchronized,

    output reg fbGPU = 0,
    output fbHDMI
);

localparam IDLE = 0;
localparam WAIT = 1;
localparam SWAP = 2;

reg[1:0] state = IDLE;
reg[1:0] nextState = IDLE;

reg oldSwapIn = 0;
reg oldVSync = 0;

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

    if(reset) 
        state <= IDLE;
end

always @(posedge clk) begin
    oldSwapIn <= swapIn;
    oldVSync <= vSync;

    if(reset) begin
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