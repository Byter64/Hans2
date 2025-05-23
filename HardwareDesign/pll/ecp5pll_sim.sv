`timescale 1ns/1ns
module ecp5pll
#(
  parameter integer in_hz      =  25000000,
  parameter integer out0_hz    =  50000000,
  parameter integer out0_deg   =         0, // keep 0
  parameter integer out0_tol_hz=         0, // tolerance: if freq differs more, then error
  parameter integer out1_hz    =  50000000,
  parameter integer out1_deg   =         0,
  parameter integer out1_tol_hz=         0,
  parameter integer out2_hz    =  50000000,
  parameter integer out2_deg   =         0,
  parameter integer out2_tol_hz=         0,
  parameter integer out3_hz    =  50000000,
  parameter integer out3_deg   =         0,
  parameter integer out3_tol_hz=         0,
  parameter integer reset_en   =         0,
  parameter integer standby_en =         0,
  parameter integer dynamic_en =         0
)
(
  input  logic       clk_i,
  output logic [3:0] clk_o,
  input        reset,
  input        standby,
  input  [1:0] phasesel,
  input        phasedir, phasestep, phaseloadreg,
  output       locked
);

logic [3:0] derived_clks = 0;

real clk0_delay = (10.0**9/out0_hz)/2.0;
real clk1_delay = (10.0**9/out1_hz)/2.0;
real clk2_delay = (10.0**9/out2_hz)/2.0;
real clk3_delay = (10.0**9/out3_hz)/2.0;

real clk0_shift_delay = ((out0_deg%360.0)/360.0)*clk0_delay;
real clk1_shift_delay = ((out1_deg%360.0)/360.0)*clk1_delay;
real clk2_shift_delay = ((out2_deg%360.0)/360.0)*clk2_delay;
real clk3_shift_delay = ((out3_deg%360.0)/360.0)*clk3_delay;

always #(clk0_delay) derived_clks[0] <= ~derived_clks [0];
always #(clk1_delay) derived_clks[1] <= ~derived_clks [1];
always #(clk2_delay) derived_clks[2] <= ~derived_clks [2];
always #(clk3_delay) derived_clks[3] <= ~derived_clks [3];

assign #clk0_shift_delay clk_o[0] = derived_clks[0];
assign #clk1_shift_delay clk_o[1] = derived_clks[1];
assign #clk2_shift_delay clk_o[2] = derived_clks[2];
assign #clk3_shift_delay clk_o[3] = derived_clks[3];

endmodule
