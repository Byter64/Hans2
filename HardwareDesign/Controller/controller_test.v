module cont_test (
    input[6:0] btn,
    input clk_25mhz,
    output reg[7:0] led,

    input cont_data,
    output reg cont_clk = 0,
    output cont_activate
);

//yosys -p"read_verilog controller_test.v; synth_ecp5 -json ausgabe.json"


reg clk = 0; //"fast clock" at 166,67 kHz
reg[7:0] clk_counter = 0;
wire[7:0] clk_counter_next = clk_counter + 1;

always @(posedge clk_25mhz) begin
    if(clk_counter_next == 150)
    begin
        clk_counter <= 0;
        clk <= ~clk;
    end
    else
        clk_counter <= clk_counter_next;
end

localparam START = 0;
localparam DATA_START = 3;
localparam DATA_END = 3 + 2 * 16; //16 states, each 2 fast clock cycles

reg[15:0] cont_state = 0;
reg[10:0] state = START;

always @(posedge clk) begin
    state <= state + 1;
end

assign cont_activate = state == 0 || state == 1;
always @(posedge clk) begin
    if(state >= DATA_START && state < DATA_END) 
        cont_clk <= ~cont_clk;
    else
        cont_clk <= 0;
end


reg inv_cont_clk = 0;
always @(posedge clk) begin
    if(state >= DATA_START - 2 && state < DATA_END) 
        inv_cont_clk <= ~inv_cont_clk;
    else
        inv_cont_clk <= 1;
end


always @(posedge inv_cont_clk) begin
    if(state >= DATA_START && state < DATA_END)
        cont_state <= {~cont_data, cont_state[15:1]};
    if(state == DATA_END)
        led <= cont_state[7:0];
    
    if(state > DATA_END)
        cont_state <= 0;
end

endmodule
