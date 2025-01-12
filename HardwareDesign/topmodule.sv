`include "pll/ecp5pll.sv"
module topmodule (
    input  logic clk_25mhz,
    input logic [7:0] btn,

    output logic [7:0] led
);

/////////// RESET ///////////////////
    logic reset;

/////////// CLOCK ///////////////////

    logic clock_slow;
    logic clock_middle;
    logic clock_fast;
    logic clock_faster;
    ecp5pll
    #(
        .in_hz(25000000),
        .out0_hz(40000000),                 .out0_tol_hz(0),
        .out1_hz(50000000), .out1_deg( 90), .out1_tol_hz(0),
        .out2_hz(25200000), .out2_deg(180), .out2_tol_hz(0),
        .out3_hz(20000000), .out3_deg(300), .out3_tol_hz(0)
    )
    ecp5pll_inst
    (
        .clk_i(clk_25mhz),
        .clk_o({clock_faster,clock_fast,clock_middle,clock_slow})
    );

endmodule