// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for DCSC in ECP5U/M, LIFMD
//
// $Header: $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DCSC (CLK0, CLK1, SEL1, SEL0, MODESEL, DCSOUT);
  input  CLK0, CLK1, SEL1, SEL0, MODESEL;
  output DCSOUT;

  parameter DCSMODE = "POS";

     wire hold_val;
    wire  sel_force;
    wire  [1:0] sel;
    reg  [8:0] dcs_fuse_set;
                                                                                                       
    wire  clk_out;
                                                                                                       
wire clk_sel_force_out;
wire dcs;
wire dcs_1;
wire bufgceclk0;
wire bufgceclk0_1;
wire bufgceclk1;
wire bufgceclk1_1;
wire buf0;
wire buf1;
wire gnd_v;
wire vcc_v;
wire clk_dcs_out;
wire gnd_v_clk_out;
wire vcc_v_clk_out;
                                                                                                       
wire clk0_in;
wire clk1_in;
reg last_clk0_in, last_clk1_in;
reg  sel_clk0;
reg  sel_clk1;
wire buf0_clk_out;
wire buf1_clk_out;


   buf  (CLK0B, CLK0);
   buf  (CLK1B, CLK1);
   buf  (sel[1], SEL1);
   buf  (sel[0], SEL0);
   buf  (sel_force, MODESEL);
   buf  (DCSOUT, clk_out);

  initial 
  begin
     sel_clk0 = 1'b0;
     sel_clk1 = 1'b0;
     last_clk0_in = 1'b0;
     last_clk1_in = 1'b0;

     if (DCSMODE == "NEG")
        dcs_fuse_set = 9'h0; 
     else if (DCSMODE == "POS")
        dcs_fuse_set = 9'h108; 
     else if (DCSMODE == "CLK0_LOW")
        dcs_fuse_set = 9'h084;
     else if (DCSMODE == "CLK0_HIGH")
        dcs_fuse_set = 9'h18c;
     else if (DCSMODE == "CLK1_LOW")
        dcs_fuse_set = 9'h042;
     else if (DCSMODE == "CLK1_HIGH")
        dcs_fuse_set = 9'h14a;
     else if (DCSMODE == "CLK0")
        dcs_fuse_set = 9'h0a5;
     else if (DCSMODE == "CLK1")
        dcs_fuse_set = 9'h1ad;
     else if (DCSMODE == "LOW")
        dcs_fuse_set = 9'h0e7;
     else if (DCSMODE == "HIGH")
        dcs_fuse_set = 9'h1ef;

  end

  reg CLK0B_reg, CLK1B_reg;

  always@ (CLK0B, CLK1B)
  begin
     CLK0B_reg <= CLK0B;
     CLK1B_reg <= CLK1B;
  end

  always@ (clk0_in, clk1_in)
  begin
     last_clk0_in <= clk0_in;
     last_clk1_in <= clk1_in;
  end

assign clk_sel_force_out = (sel == 2'b01) ? CLK0B : (sel == 2'b10) ? CLK1B : 0;
                                                                                                       
assign dcs_0        = dcs_fuse_set == 9'h0;
assign dcs_1        = dcs_fuse_set == 9'h108;
assign bufgceclk0   = dcs_fuse_set == 9'h084;
assign bufgceclk0_1 = dcs_fuse_set == 9'h18c;
assign bufgceclk1   = dcs_fuse_set == 9'h042;
assign bufgceclk1_1 = dcs_fuse_set == 9'h14a;
assign buf0         = dcs_fuse_set == 9'h0a5;
assign buf1         = dcs_fuse_set == 9'h1ad;
assign gnd_v        = dcs_fuse_set == 9'h0e7;
assign vcc_v        = dcs_fuse_set == 9'h1ef;

assign clk_out = sel_force ? clk_sel_force_out : buf0 ? buf0_clk_out : buf1 ? buf1_clk_out : gnd_v ? gnd_v_clk_out : vcc_v ? vcc_v_clk_out : clk_dcs_out;
                                                                                                       
assign buf0_clk_out         = CLK0B;
assign buf1_clk_out         = CLK1B;
assign gnd_v_clk_out        = 1'b0;
assign vcc_v_clk_out        = 1'b1;
                                                                                                       
assign hold_val = dcs_1 | bufgceclk0_1 | bufgceclk1_1;

assign clk0_inv = ~CLK0B;
assign clk1_inv = ~CLK1B;

assign clk0_inv_inv = ~clk0_inv;
assign clk1_inv_inv = ~clk1_inv;

assign clk0_in = hold_val ? clk0_inv_inv : clk0_inv;
assign clk1_in = hold_val ? clk1_inv_inv : clk1_inv;

//assign clk0_in = hold_val ? CLK0B : ~CLK0B;
//assign clk1_in = hold_val ? CLK1B : ~CLK1B;
                                                                                                       
wire sel_clk0_rstn;
wire sel_clk1_rstn;
wire clk0_sel;
wire clk1_sel;
                                                                                                       
wire clk_and;
wire clk_or ;


  always@ (clk0_in, negedge sel_clk0_rstn)
  begin
     if (sel_clk0_rstn == 1'b0)
     begin
        sel_clk0 <= 1'b0;
     end
     else if (clk0_in === 1'b1 && last_clk0_in === 1'b0)
     begin
        begin
           sel_clk0 <= sel[0];
        end
     end
  end

  always@ (clk1_in, negedge sel_clk1_rstn)
  begin
     if (sel_clk1_rstn == 1'b0)
     begin
        sel_clk1 <= 1'b0;
     end
     else if (clk1_in === 1'b1 && last_clk1_in === 1'b0)
     begin
        begin
           sel_clk1 <= sel[1];
        end
     end
  end

assign sel_clk0_rstn = ~(sel_clk1) & ~(bufgceclk1 | bufgceclk1_1);
assign sel_clk1_rstn = ~(sel_clk0) & ~(bufgceclk0 | bufgceclk0_1);
                                                                                                       
assign clk0_sel = sel_clk0 ? CLK0B : hold_val;
assign clk1_sel = sel_clk1 ? CLK1B : hold_val;
                                                                                                       
assign clk_and = clk0_sel & clk1_sel;
assign clk_or  = clk0_sel | clk1_sel;
                                                                                                       
assign clk_dcs_out = (sel[1] & sel[0]) ? hold_val : hold_val ? clk_and : clk_or;


endmodule

`endcelldefine
