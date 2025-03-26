module ClockGenerator(
    input logic clk_25mhz,

    output logic clk_1024khz = 0,
    output logic clk_64khz = 0,
    output logic clk_32khz = 0
);

/* CLOCK GENERATION */
logic clk_100mhz;
`ifdef SYNTHESIS
ecp5pll
#(
    .in_hz   (25000000),
    .out0_hz(100000000), .out0_tol_hz(50)
)
ecp5pll_inst
(
    .clk_i(clk_25mhz),
    .clk_o({clk_100mhz})
);
`else
initial clk_100mhz = 0;
always #5 clk_100mhz = ~clk_100mhz;
`endif

logic[9:0] clk_1024khz_counter = 0;
always_ff @(posedge clk_100mhz) begin
    clk_1024khz_counter <= clk_1024khz_counter + 1;
    if(clk_1024khz_counter + 1 == 49) begin
        clk_1024khz_counter <= 0;
        clk_1024khz <= ~clk_1024khz;
    end
end

logic[9:0] clk_64khz_counter = 0;
always_ff @(posedge clk_1024khz) begin
    clk_64khz_counter <= clk_64khz_counter + 1;
    if(clk_64khz_counter + 1 == 8) begin
        clk_64khz_counter <= 0;
        clk_64khz <= ~clk_64khz;
    end
end 

logic[9:0] clk_32khz_counter = 0;
always_ff @(posedge clk_1024khz) begin
    clk_32khz_counter <= clk_32khz_counter + 1;
    if(clk_32khz_counter + 1 == 16) begin
        clk_32khz_counter <= 0;
        clk_32khz <= ~clk_32khz;
    end
end 

endmodule