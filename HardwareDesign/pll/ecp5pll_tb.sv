`timescale 1ns/1ps
module ecp5pll_tb;

    // Global parameters
    localparam HALF_CLOCK_CYCLE = 5;
    localparam CLOCK_CYCLE = 2 * HALF_CLOCK_CYCLE;

    // Global logic
    logic clk;
    logic [3:0] clk_o;

    // Clock generation
    initial clk = 0;
    always #(HALF_CLOCK_CYCLE) clk = ~clk;
    


    ecp5pll #(
        .out0_hz(25000000),
        .out1_hz(50000000),
        .out2_hz(75000000),
        .out3_hz(100000000),
        .out0_deg(90),
        .out1_deg(120),
        .out2_deg(150),
        .out3_deg(180)
    ) uut (
        .clk_i(clk),
        .clk_o(clk_o)
    );

    // Testbench execution
    initial begin
        #1000;
        $finish;
    end

    // Generate VCD file if enabled
    `ifndef VCD
        initial begin
            $dumpfile("ecp5pll_tb.vcd");
            $dumpvars(0, ecp5pll_tb);
        end
    `endif

endmodule
