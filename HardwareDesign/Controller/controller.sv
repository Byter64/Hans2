module Controller (
    input  logic clk,

    input  logic                                aclk,
    input  logic                                aresetn,
    output logic [31:0]                         s_axil_rdata,
    output logic [1:0]                          s_axil_rresp,
    output logic                                s_axil_rvalid,
    input  logic                                s_axil_rready,

    input  logic cont0_data,
    output logic cont0_clk = 0,
    output logic cont0_activate,

    input  logic cont1_data,
    output logic cont1_clk,
    output logic cont1_activate
);

assign s_axil_rresp = 0;
assign cont1_clk = cont0_clk;
assign cont1_activate = cont0_activate;

logic[15:0] controller0_btns;
logic[15:0] controller1_btns;

localparam START = 0;
localparam DATA_START = 3;
localparam DATA_END = 3 + 2 * 16; //16 states, each 2 fast clock cycles
logic[15:0] cont0_state = 0;
logic[15:0] cont1_state = 0;
logic[10:0] state = START;


/////////////////// R /////////////////////
logic next_rvalid; //Assign your valid logic to this signal
logic[31:0] next_rData; //Assign the data here
assign next_rvalid = 1;
assign next_rData = {controller1_btns, controller0_btns};

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

assign cont0_activate = state == 0 || state == 1;
always_ff @(posedge clk) begin
    if(state >= DATA_START && state < DATA_END) begin
        cont0_clk <= ~cont0_clk;
    end else begin
        cont0_clk <= 0;
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
        cont0_state <= {~cont0_data, cont0_state[15:1]};
    end
    if(state == DATA_END) begin
        controller0_btns <= cont0_state[11:0];
    end
    if(state > DATA_END) begin
        cont0_state <= 0;
    end
end

always_ff @(posedge inv_cont_clk) begin
    if(state >= DATA_START && state < DATA_END) begin
        cont1_state <= {~cont1_data, cont1_state[15:1]};
    end
    if(state == DATA_END) begin
        controller1_btns <= cont1_state[11:0];
    end
    if(state > DATA_END) begin
        cont1_state <= 0;
    end
end

endmodule