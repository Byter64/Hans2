module AddressConverter (
    input clk,
    input rst,

    input[31:0] address12,
    output[11:0] data12,
    output data12_valid,

    output[31:0] address8,
    output read,
    input[7:0] data8,
    input data8_ready,
);
//Direkt nach dem reset müssen die ersten zwei bytes geladen werden!!
    
logic[31:0] address8_1;
logic[31:0] address8_2;
logic isEven
assign address8_1 = (address12 * 3) >> 1;
assign address8_2 = address8_1 + 1;
assign isEven = !address12[0];

logic[31:0] old_address12;
logic addressChanged;
always_ff @(posedge clk) old_address12 <= address12;
assign addressChanged = address12 != old_address12;

assign data12 = isEven ? 
endmodule