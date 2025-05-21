module Controller (
    input  logic clk,

    input logic [31:0]                       s_axil_rdata,
    input logic [1:0]                        s_axil_rresp,
    input logic                              s_axil_rvalid,
    output logic                             s_axil_rready,

    input  logic cont_data,
    output logic cont_clk = 0,
    output logic cont_activate
);

logic[11:0] controller_btns;

logic[15:0] cont_state = 0;
logic[10:0] state = START;
localparam START = 0;
localparam DATA_START = 3;
localparam DATA_END = 3 + 2 * 16; //16 states, each 2 fast clock cycles


/////////////////// R /////////////////////
logic next_rvalid; //Assign your valid logic to this signal
logic[31:0] next_rData; //Assign the data here
assign next_rvalid = 1;
assign next_rData = controller_btns;

always_ff @(posedge aclk) begin
    if (!aresetn)
        s_axil_rvalid <= 0;
    else if (!s_axil_rvalid || s_axil_rready) begin
        s_axil_rvalid <= next_rvalid;
    end
end

always_ff @(posedge aclk) begin
    if (!aresetn)
        s_axil_rdata <= 0;
    else begin
        s_axil_rdata <= next_rData;
    end
end
///////////// AXI LITE END ////////////////////

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