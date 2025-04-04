module Controller (
    input  logic clk,
    output logic[11:0] controller_btns,

    input  logic cont_data,
    output logic cont_clk = 0,
    output logic cont_activate
);



logic[15:0] cont_state = 0;
logic[10:0] state = START;
localparam START = 0;
localparam DATA_START = 3;
localparam DATA_END = 3 + 2 * 16; //16 states, each 2 fast clock cycles

always_ff @(posedge clk) begin
    state <= state + 1;
end

assign cont_activate = state == 0 || state == 1;
always_ff @(posedge clk) begin
    if(state >= DATA_START && state < DATA_END) begin
        cont_clk <= ~cont_clk;
    end else begin
        cont_clk <= 0;
    end
end


logic inv_cont_clk = 0;
always_ff @(posedge clk) begin
    if(state >= DATA_START - 2 && state < DATA_END) begin
        inv_cont_clk <= ~inv_cont_clk;
    end else begin
        inv_cont_clk <= 1;
    end
end


always_ff @(posedge inv_cont_clk) begin
    if(state >= DATA_START && state < DATA_END) begin
        cont_state <= {~cont_data, cont_state[15:1]};
    end
    if(state == DATA_END) begin
        controller_btns <= cont_state[11:0];
    end
    if(state > DATA_END) begin
        cont_state <= 0;
    end
end

endmodule