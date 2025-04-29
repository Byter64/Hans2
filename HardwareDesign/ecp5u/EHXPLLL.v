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
// Simulation Library File for EHXPLLL in ECP5U/M
// Revision: rel-14
//    10/03/14 – Updated module pll_pll
// End Revision
// $Header: 
// need change the rtl
// change1 add extra clkintfb output ports
// change2 add the geedbk_path parameter
// change3 add if else parameter assign pll_fb_info
`celldefine
`timescale 1 ns / 10 fs

module EHXPLLL(CLKI, CLKFB, PHASESEL1, PHASESEL0, PHASEDIR, PHASESTEP, PHASELOADREG, STDBY, 
   PLLWAKESYNC, RST, ENCLKOP, ENCLKOS, ENCLKOS2, ENCLKOS3, 
   CLKOP, CLKOS, CLKOS2, CLKOS3, LOCK, INTLOCK, 
   REFCLK, CLKINTFB );

parameter FIN = "100.0000";
parameter CLKI_DIV = 1;
parameter CLKFB_DIV = 1;
parameter CLKOP_DIV = 1;
parameter CLKOS_DIV = 1;
parameter CLKOS2_DIV = 1;
parameter CLKOS3_DIV = 1;
parameter CLKOP_ENABLE = "ENABLED";
parameter CLKOS_ENABLE = "DISABLED";
parameter CLKOS2_ENABLE = "DISABLED";
parameter CLKOS3_ENABLE = "DISABLED";
parameter CLKOP_CPHASE = 0;
parameter CLKOS_CPHASE = 0;
parameter CLKOS2_CPHASE = 0;
parameter CLKOS3_CPHASE = 0;
parameter CLKOP_FPHASE = 0;
parameter CLKOS_FPHASE = 0;
parameter CLKOS2_FPHASE = 0;
parameter CLKOS3_FPHASE = 0;
parameter FEEDBK_PATH = "CLKOP";
parameter CLKOP_TRIM_POL = "RISING";
parameter CLKOP_TRIM_DELAY = 0;
parameter CLKOS_TRIM_POL = "RISING";
parameter CLKOS_TRIM_DELAY = 0;
parameter OUTDIVIDER_MUXA = "DIVA";
parameter OUTDIVIDER_MUXB = "DIVB";
parameter OUTDIVIDER_MUXC = "DIVC";
parameter OUTDIVIDER_MUXD = "DIVD";
parameter PLL_LOCK_MODE = 0;   // 2 => sticky, 0 => non-sticky
parameter PLL_LOCK_DELAY = 200;
parameter REFIN_RESET = "DISABLED";
parameter SYNC_ENABLE = "DISABLED";
parameter INT_LOCK_STICKY = "ENABLED";
parameter DPHASE_SOURCE = "DISABLED";
parameter STDBY_ENABLE = "DISABLED";
parameter PLLRST_ENA = "DISABLED";
parameter INTFB_WAKE = "DISABLED";
 

input  CLKI, CLKFB, PHASESEL1, PHASESEL0, PHASEDIR, PHASESTEP;
input  PHASELOADREG, STDBY, PLLWAKESYNC, RST;
input  ENCLKOP, ENCLKOS, ENCLKOS2, ENCLKOS3;
output CLKOP, CLKOS, CLKOS2, CLKOS3, LOCK, INTLOCK, REFCLK;
output CLKINTFB;

wire [1:0] PHASESELB;
supply0 GND;
supply1 VCC;

buf U101 (REFCLK, CLKI);
buf U6 (CLKIB, CLKI);
buf U7 (FBB, CLKFB);
buf U81 (RSTB, RST);
buf U34 (PHASESELB[1], PHASESEL1);
buf U35 (PHASESELB[0], PHASESEL0);
buf U36 (PHASEDIRB, PHASEDIR);

reg          mc1_pllpdn, mc1_refin_reset, mc1_pllrst_ena, mc1_stdby, mc1_intfb;
reg   [2:0]  mc1_sel_ref1, mc1_sel_ref2;
reg   [3:0]  mc1_sel_fbk;
reg   [1:0]  mc1_clkmux_fb;
reg   [6:0]  mc1_divref;
reg   [6:0]  mc1_divfbk;
reg              mc1_int_lock_sticky;
reg   [2:0]  mc1_lock_sel;
reg   [1:0]  mc1_lock;
reg   [6:0]  mc1_rprog;
reg   [1:0]  mc1_dprog;
reg   [4:0]  mc1_iprog;
reg   [2:0]  mc1_kprog, mc1_gprog;
reg   [3:0]  mc1_gmcsel;
reg          mc1_gmc_preset, mc1_gmc_reset, mc1_lf_preset, mc1_lf_reset;
reg          mc1_lf_resgrnd, mc1_float_icp, mc1_force_vfilter;
reg          mc1_en_up, mc1_test_icp;
reg   [1:0]  mc1_gmcref_sel;
reg          mc1_en_filteropamp;
reg   [2:0]  mc1_phia, mc1_phib, mc1_phic, mc1_phid;
reg   [6:0]  mc1_dela, mc1_delb, mc1_delc, mc1_deld;
reg   [6:0]  mc1_diva, mc1_divb, mc1_divc, mc1_divd;
reg          mc1_sel_outa, mc1_sel_outb, mc1_sel_outc, mc1_sel_outd;
reg   [3:0]  mc1_enable_clk;
reg          mc1_enable_sync, mc1_dyn_source;
reg   [2:0]  mc1_mfgout2_sel, mc1_mfgout1_sel;
reg          mc1_vco_noreset, mc1_trimop_bypass_n, mc1_trimos_bypass_n;
reg   [3:0]  mc1_clkop_trim, mc1_clkos_trim;
reg          mc1_stdby_analogon;
reg   [15:0] mc1_reserved;

initial
begin
   mc1_pllpdn = 0;
   mc1_refin_reset = (REFIN_RESET == "ENABLED") ? 1'b1 : 1'b0;
   mc1_pllrst_ena = (PLLRST_ENA == "ENABLED") ? 1'b1 : 1'b0;
   mc1_intfb = (INTFB_WAKE == "ENABLED") ? 1'b1 : 1'b0;
   mc1_stdby = (STDBY_ENABLE == "ENABLED") ? 1'b1 : 1'b0;
   mc1_sel_ref1 = 3'b000;
   mc1_sel_ref2 = 3'b000;
   mc1_sel_fbk  = (FEEDBK_PATH == "INT_OP") ? 4'b1110 : (FEEDBK_PATH == "INT_OS") ? 4'b1101 : (FEEDBK_PATH == "INT_OS2") ? 4'b1100 : (FEEDBK_PATH == "INT_OS3") ? 4'b1011 : 4'b0000;  

   mc1_clkmux_fb = 2'b00;
   mc1_divref = (CLKI_DIV - 1); 
   mc1_divfbk = (CLKFB_DIV - 1);
   mc1_int_lock_sticky = (INT_LOCK_STICKY == "ENABLED") ? 1'b1 : 1'b0;
   mc1_lock_sel = PLL_LOCK_MODE;
   mc1_lock = 2'b00;
   mc1_rprog = 7'b0000000;
   mc1_dprog = 2'b00;
   mc1_iprog = 5'b00000;
   mc1_kprog = 3'b00;
   mc1_gprog = 3'b00;
   mc1_gmcsel = 4'b0000;
   mc1_gmc_preset = 1'b0;
   mc1_gmc_reset = 1'b0;
   mc1_lf_preset = 1'b0;
   mc1_lf_reset = 1'b0;
   mc1_lf_resgrnd = 1'b0;
   mc1_float_icp = 1'b0;
   mc1_force_vfilter = 1'b0;
   mc1_en_up = 1'b0;
   mc1_test_icp = 1'b0;
   mc1_gmcref_sel = 2'b00;
   mc1_en_filteropamp = 1'b0;
   mc1_phia = CLKOP_FPHASE;
   mc1_phib = CLKOS_FPHASE;
   mc1_phic = CLKOS2_FPHASE;
   mc1_phid = CLKOS3_FPHASE;
   mc1_dela = CLKOP_CPHASE;
   mc1_delb = CLKOS_CPHASE;
   mc1_delc = CLKOS2_CPHASE;
   mc1_deld = CLKOS3_CPHASE;
   mc1_diva = (CLKOP_DIV - 1);
   mc1_divb = (CLKOS_DIV - 1);
   mc1_divc = (CLKOS2_DIV - 1);
   mc1_divd = (CLKOS3_DIV - 1);
   mc1_sel_outa = (OUTDIVIDER_MUXA == "DIVA") ? 1'b0 : 1'b1;
   mc1_sel_outb = (OUTDIVIDER_MUXB == "DIVB") ? 1'b0 : 1'b1;
   mc1_sel_outc = (OUTDIVIDER_MUXC == "DIVC") ? 1'b0 : 1'b1;
   mc1_sel_outd = (OUTDIVIDER_MUXD == "DIVD") ? 1'b0 : 1'b1;
   mc1_enable_clk[0] = (CLKOP_ENABLE == "ENABLED") ? 1'b1 : 1'b0;
   mc1_enable_clk[1] = (CLKOS_ENABLE == "ENABLED") ? 1'b1 : 1'b0;
   mc1_enable_clk[2] = (CLKOS2_ENABLE == "ENABLED") ? 1'b1 : 1'b0;
   mc1_enable_clk[3] = (CLKOS3_ENABLE == "ENABLED") ? 1'b1 : 1'b0;
   mc1_enable_sync = (SYNC_ENABLE == "ENABLED") ? 1'b1 : 1'b0;
   mc1_dyn_source = (DPHASE_SOURCE == "ENABLED") ? 1'b1 : 1'b0;
   mc1_mfgout2_sel = 3'b000;
   mc1_mfgout1_sel = 3'b000;
   mc1_vco_noreset = 1'b0;
   mc1_trimop_bypass_n = 1'b1;
   mc1_trimos_bypass_n = 1'b1;
   mc1_clkop_trim[3] = (CLKOP_TRIM_POL == "RISING") ? 1'b1 : 1'b0;
   mc1_clkop_trim[2:0] = CLKOP_TRIM_DELAY;
   mc1_clkos_trim[3] = (CLKOS_TRIM_POL == "RISING") ? 1'b1 : 1'b0;
   mc1_clkos_trim[2:0] = CLKOS_TRIM_DELAY;
   mc1_stdby_analogon = 1'b0;
   mc1_reserved = 16'h0000;

   if ((FEEDBK_PATH == "CLKOP" || FEEDBK_PATH == "INT_OP") && OUTDIVIDER_MUXA == "DIVA" && ((CLKOP_CPHASE-CLKOP_DIV+1)*8+CLKOP_FPHASE)*360/(8*CLKOP_DIV) != 0)
         begin
            $display ("Warning! FEEDBK_PATH is CLKOP or INT_OP, there should be no static phase shift on CLKOP");
         end
   else if ((FEEDBK_PATH == "CLKOS" || FEEDBK_PATH == "INT_OS") && OUTDIVIDER_MUXB == "DIVB" && ((CLKOS_CPHASE-CLKOS_DIV+1)*8+CLKOS_FPHASE)*360/(8*CLKOS_DIV) != 0)
         begin
            $display ("Warning! FEEDBK_PATH is CLKOS or INT_OS, there should be no static phase shift on CLKOS");
         end
   else if ((FEEDBK_PATH == "CLKOS2" || FEEDBK_PATH == "INT_OS2") && OUTDIVIDER_MUXC == "DIVC" && ((CLKOS2_CPHASE-CLKOS2_DIV+1)*8+CLKOS2_FPHASE)*360/(8*CLKOS2_DIV) != 0)
         begin
            $display ("Warning! FEEDBK_PATH is CLKOS2 or INT_OS2, there should be no static phase shift on CLKOS2");
         end
   else if ((FEEDBK_PATH == "CLKOS3" || FEEDBK_PATH == "INT_OS3") && OUTDIVIDER_MUXD == "DIVD" && ((CLKOS3_CPHASE-CLKOS3_DIV+1)*8+CLKOS3_FPHASE)*360/(8*CLKOS3_DIV) != 0)
         begin
            $display ("Warning! FEEDBK_PATH is CLKOS3 or INT_OS3, there should be no static phase shift on CLKOS3");
         end

end


defparam PLL_INST.pll_lock_delay = PLL_LOCK_DELAY;
defparam PLL_INST.FEEDBK_PATH = FEEDBK_PATH;

pll_pll PLL_INST (
  .refclk1({7'b0000000, CLKIB}),          // [7:0]
  .refclk2(8'h00),          // [7:0]
  .fbkclk({10'h000, FBB}),          // [10:0]
  .done_cfg(1'b1),
  .stdby(STDBY),
  .pllreset(RSTB),
  .refin_sel(1'b0),
  .pll_wakeup_sync(PLLWAKESYNC),
  .enclkop(ENCLKOP),
  .enclkos(ENCLKOS),
  .enclkos2(ENCLKOS2),
  .enclkos3(ENCLKOS3),
  .cib_load_reg(PHASELOADREG),
  .cib_dyn_sel(PHASESELB),       // [1:0]
  .cib_rotate(PHASESTEP),
  .cib_direction(PHASEDIRB),
  .cib_input(2'b00),       // [1:0]
  .iref_10upwr(2'b00),       // [1:0]
  .vccpll(VCC),
  .vsspll(GND),
  .clkop(CLKOP),
  .clkos(CLKOS),
  .clkos2(CLKOS2),
  .clkos3(CLKOS3),
  .refmuxclk(),
  .lock(LOCK),
  .int_lock(INTLOCK),
  .clkintfb(CLKINTFB),
  .pll_mfgout2(),
  .pll_mfgout1(),
  .pfd_up(),
  .pfd_dn(),
  .extcon(),
//power pins
    .vccdpll(), 
    .vssdpll(),
    .mc1_no_pllreset(),
//mem cells  
  .mc1_pllpdn(mc1_pllpdn),
  .mc1_refin_reset(mc1_refin_reset),
  .mc1_pllrst_ena(mc1_pllrst_ena),
  .mc1_stdby(mc1_stdby),
  .mc1_intfb(mc1_intfb),
  .mc1_sel_ref1(mc1_sel_ref1),       // [2:0]
  .mc1_sel_ref2(mc1_sel_ref2),       // [2:0]
  .mc1_sel_fbk(mc1_sel_fbk),        // [3:0]
  .mc1_clkmux_fb(mc1_clkmux_fb),        // [1:0]
  .mc1_divref(mc1_divref),           // [6:0]
  .mc1_divfbk(mc1_divfbk),           // [6:0]
  .mc1_int_lock_sticky(mc1_int_lock_sticky),
  .mc1_lock_sel(mc1_lock_sel),           // [2:0]
  .mc1_lock(mc1_lock),              // [1:0]
  .mc1_rprog(mc1_rprog),             // [6:0]
  .mc1_dprog(mc1_dprog),             // [1:0]
  .mc1_iprog(mc1_iprog),             // [1:0]
  .mc1_kprog(mc1_kprog),             // [2:0]
  .mc1_gprog(mc1_gprog),             // [2:0]

  .mc1_gmcsel(mc1_gmcsel),            // [3:0]
  .mc1_gmc_preset(mc1_gmc_preset),
  .mc1_gmc_reset(mc1_gmc_reset),
  .mc1_lf_preset(mc1_lf_preset),
  .mc1_lf_reset(mc1_lf_reset),
  .mc1_lf_resgrnd(mc1_lf_resgrnd),
  .mc1_float_icp(mc1_float_icp),
  .mc1_force_vfilter(mc1_force_vfilter),
  .mc1_en_up(mc1_en_up),
  .mc1_test_icp(mc1_test_icp),
  .mc1_gmcref_sel(mc1_gmcref_sel),            // [1:0]
  .mc1_en_filteropamp(mc1_en_filteropamp),
  .mc1_phia(mc1_phia),                 // [2:0]
  .mc1_phib(mc1_phib),                 // [2:0]
  .mc1_phic(mc1_phic),                 // [2:0]
  .mc1_phid(mc1_phid),                 // [2:0]
  .mc1_dela(mc1_dela),                 // [6:0]
  .mc1_delb(mc1_delb),                 // [6:0]
  .mc1_delc(mc1_delc),                 // [6:0]
  .mc1_deld(mc1_deld),                 // [6:0]
  .mc1_diva(mc1_diva),                 // [6:0]
  .mc1_divb(mc1_divb),                 // [6:0]
  .mc1_divc(mc1_divc),                 // [6:0]
  .mc1_divd(mc1_divd),                 // [6:0]

  .mc1_sel_outa(mc1_sel_outa),
  .mc1_sel_outb(mc1_sel_outb),
  .mc1_sel_outc(mc1_sel_outc),
  .mc1_sel_outd(mc1_sel_outd),
  .mc1_enable_clk(mc1_enable_clk),                 // [3:0]
  .mc1_enable_sync(mc1_enable_sync),
  .mc1_dyn_source(mc1_dyn_source),
  .mc1_mfgout2_sel(mc1_mfgout2_sel),                 // [2:0]
  .mc1_mfgout1_sel(mc1_mfgout1_sel),                 // [2:0]
  .mc1_vco_noreset(mc1_vco_noreset),
  .mc1_trimop_bypass_n(mc1_trimop_bypass_n),
  .mc1_trimos_bypass_n(mc1_trimos_bypass_n),
  .mc1_clkop_trim(mc1_clkop_trim),                 // [3:0]
  .mc1_clkos_trim(mc1_clkos_trim),                 // [3:0]
  .mc1_stdby_analogon(mc1_stdby_analogon),
  .mc1_reserved(mc1_reserved)                 // [15:0]
  );


endmodule


//
//
//


//
// Project :  Sapphire GPLL IP
// Revision History:
//   1. Initial check in.
//   2. 11/20/2012: Correct mc1_sel_fbk controls.  
//   3. 08/05/2013: Add in the internla feedback selections due to the simRel only passing 
//                  the external GPLL feedback info to GPLL model. 

`timescale 1 ns / 10fs

module pll_pll(refclk1, refclk2, fbkclk, done_cfg, stdby, pllreset, refin_sel,
               pll_wakeup_sync, enclkop, enclkos, enclkos2, enclkos3, cib_load_reg,
               cib_dyn_sel, cib_rotate, cib_direction, cib_input, 
               clkop, clkos, clkos2, clkos3, refmuxclk, lock, int_lock,clkintfb, 
               pll_mfgout2, pll_mfgout1, pfd_up, pfd_dn, extcon, iref_10upwr, vccpll, vsspll,
               vccdpll, vssdpll,
	       mc1_pllpdn, mc1_refin_reset, mc1_pllrst_ena, mc1_stdby, mc1_intfb,
	       mc1_sel_ref1, mc1_sel_ref2, mc1_sel_fbk, mc1_clkmux_fb,
	       mc1_int_lock_sticky, mc1_lock_sel, mc1_lock,
               mc1_rprog, mc1_dprog, mc1_iprog, mc1_kprog, mc1_gprog, mc1_gmcsel,
               mc1_gmc_preset, mc1_gmc_reset, mc1_lf_preset, mc1_lf_reset, mc1_lf_resgrnd,
               mc1_float_icp, mc1_force_vfilter, mc1_en_up, mc1_test_icp, mc1_gmcref_sel,
               mc1_en_filteropamp, mc1_divref, mc1_divfbk,  
               mc1_phia, mc1_phib, mc1_phic, mc1_phid, mc1_dela, mc1_delb, mc1_delc, mc1_deld,
               mc1_diva, mc1_divb, mc1_divc, mc1_divd, mc1_sel_outa, mc1_sel_outb,
               mc1_sel_outc, mc1_sel_outd, mc1_enable_clk, mc1_enable_sync, mc1_dyn_source, 
               mc1_mfgout2_sel, mc1_mfgout1_sel, mc1_vco_noreset, 
	       mc1_trimop_bypass_n, mc1_trimos_bypass_n, mc1_clkop_trim, mc1_clkos_trim,
               mc1_stdby_analogon, mc1_no_pllreset, mc1_reserved);
   
parameter pll_lock_delay = 1; 
parameter FEEDBK_PATH = "CLKOP";

// primary inputs
input [7:0]  refclk1, refclk2;
wire  [7:0]  refclk1, refclk2;
input [10:0] fbkclk;
wire  [10:0] fbkclk; 
input        done_cfg, stdby, pllreset, refin_sel, pll_wakeup_sync; 
input        enclkop, enclkos, enclkos2, enclkos3;
input        cib_load_reg;
input [1:0]  cib_dyn_sel;
wire  [1:0]  cib_dyn_sel;
input        cib_rotate, cib_direction; 
input [1:0]  cib_input;
wire  [1:0]  cib_input;
input [1:0]  iref_10upwr; 
wire  [1:0]  iref_10upwr; 

inout        vccpll, vsspll;
inout        vccdpll, vssdpll;

// primary outputs
output       clkop, clkos, clkos2, clkos3;
output       refmuxclk, lock, int_lock,clkintfb;
output       pll_mfgout2, pll_mfgout1; 
output       pfd_up, pfd_dn;
output       extcon;

// configuration bits inputs
input        mc1_pllpdn, mc1_refin_reset, mc1_pllrst_ena, mc1_stdby, mc1_intfb;
input [2:0]  mc1_sel_ref1, mc1_sel_ref2;
wire  [2:0]  mc1_sel_ref1, mc1_sel_ref2;
input [3:0]  mc1_sel_fbk;
wire  [3:0]  mc1_sel_fbk; 
input [1:0]  mc1_clkmux_fb;
wire  [1:0]  mc1_clkmux_fb;
input [6:0]  mc1_divref;
wire  [6:0]  mc1_divref;
input [6:0]  mc1_divfbk;
wire  [6:0]  mc1_divfbk;
input    	 mc1_int_lock_sticky;
input [2:0]  mc1_lock_sel;
wire  [2:0]  mc1_lock_sel;
input [1:0]  mc1_lock;
wire  [1:0]  mc1_lock;
input [6:0]  mc1_rprog;
wire  [6:0]  mc1_rprog;
input [1:0]  mc1_dprog;
wire  [1:0]  mc1_dprog;
input [4:0]  mc1_iprog;
wire  [4:0]  mc1_iprog;
input [2:0]  mc1_kprog, mc1_gprog;
wire  [2:0]  mc1_kprog, mc1_gprog;
input [3:0]  mc1_gmcsel;
wire  [3:0]  mc1_gmcsel;
input        mc1_gmc_preset, mc1_gmc_reset, mc1_lf_preset, mc1_lf_reset, mc1_lf_resgrnd,
             mc1_float_icp, mc1_force_vfilter, mc1_en_up, mc1_test_icp;
input [1:0]  mc1_gmcref_sel;
wire  [1:0]  mc1_gmcref_sel;
input        mc1_en_filteropamp;

input [2:0]  mc1_phia, mc1_phib, mc1_phic, mc1_phid;
wire  [2:0]  mc1_phia, mc1_phib, mc1_phic, mc1_phid;

input [6:0]  mc1_dela, mc1_delb, mc1_delc, mc1_deld,
             mc1_diva, mc1_divb, mc1_divc, mc1_divd;
wire  [6:0]  mc1_dela, mc1_delb, mc1_delc, mc1_deld,
             mc1_diva, mc1_divb, mc1_divc, mc1_divd;			 

input        mc1_sel_outa, mc1_sel_outb, mc1_sel_outc, mc1_sel_outd;
input [3:0]  mc1_enable_clk;
wire  [3:0]  mc1_enable_clk;
input        mc1_enable_sync, mc1_dyn_source;
input [2:0]  mc1_mfgout2_sel, mc1_mfgout1_sel;
wire  [2:0]  mc1_mfgout2_sel, mc1_mfgout1_sel;
input        mc1_vco_noreset, mc1_trimop_bypass_n, mc1_trimos_bypass_n;
input [3:0]  mc1_clkop_trim, mc1_clkos_trim;
wire  [3:0]  mc1_clkop_trim, mc1_clkos_trim;
input        mc1_stdby_analogon;
input        mc1_no_pllreset;  
input [15:0] mc1_reserved;  
wire  [15:0] mc1_reserved;  

// model internal variables
wire refclkmux_div, fbkclkmux_div; 
reg refclkmux, refclkmux_ctrl, fbkclkmux_ctrl;  
reg pfdref_reg, pfdfbk_reg; 

reg pfd_holding_dn, pfd_holding_up, pfd_dn_reg, pfd_up_reg; 

reg refclkmux1, refclkmux2, pll_mfgout2_reg, pll_mfgout1_reg; 
reg false_clk;
reg clkop_first_time;
reg false_clk_first_time, fb_first_time;

reg clock_valid, clock_invalid, out_clk_valid;

reg vir_sclk, vir_kclk, vir_k2clk, vir_lock, vir_pclk, vir_intfb;
reg vir_kclk_p,  vir_kclk_s, final_sclk;

reg intfb_out, lock_all;
realtime t_diva_clk, t_divb_clk, t_divc_clk, t_divd_clk;
realtime ha_clk_a_trim, ha_clk_b_trim, ha_clk_c_trim, ha_clk_d_trim;
realtime ha_vco_a, ha_vco_b;

realtime next_clock_edge, last_clock_edge;
realtime next_clock_edge1, last_clock_edge1;
realtime t_in_clk, t_in_clk1, t_in_clk2, t_in_clk3;
realtime t_vco, ha_vco1, ha_vco;
realtime t_fb_clk;
realtime first_int_edge, first_fb_edge;
realtime total_fb_delay, virtual_delay1;
realtime real_delay1, lock_delay_reg;
reg clkos3reg, clkos2reg, clkosreg, clkopreg, clkopreg1, lockreg, intlockreg;
reg clkos3reg1, clkos2reg1, clkosreg1;
reg [1:0] phase_sel;
reg d_lock, d1_lock, d2_lock, d3_lock, d4_lock, lockreg1, lockreg2, lockreg3;
reg load_reg_en, phase_dir, phase_step, last_phase_step;

real ext_divider, net_divide, net_divide1, frac_value;
integer    wait_pfdref, wait_pfdfbk; 
integer    step_s, step_s2, step_s3;
integer    step_p, step_op, step_op1, step_op2;
integer    step_os, step_os_1, step_os_2; 
integer    step_os2, step_os2_1, step_os2_2, step_os3, step_os3_1, step_os3_2;
integer fb_count, ratio1;
reg delay_lockreg1; 
reg index_refclkmux_reg; 
integer index_refclkmux, index_fbkclkmux;  
integer index_diva, index_divb, index_divc, index_divd;
reg  load_reg_en_op2, load_reg_en_op1, load_reg_en_op;
reg  load_reg_en_os_2, load_reg_en_os_1, load_reg_en_os;
reg  load_reg_en_os2_2, load_reg_en_os2_1, load_reg_en_os2;
reg  load_reg_en_os3_2, load_reg_en_os3_1, load_reg_en_os3;
reg  last_load_reg_en_op, last_load_reg_en_os, last_load_reg_en_os2, last_load_reg_en_os3;

//following variables are added to compensate vco rounding error
integer ha_vco_xprec;
realtime ha_vco_sim, round_err;
realtime ha_clk_a, ha_clk_b;
realtime vco_ph_del_a, vco_ph_del_b, vco_ph_del_c, vco_ph_del_d;
realtime diva_ph_del, divb_ph_del, divc_ph_del, divd_ph_del;
realtime op_ph_del, os_ph_del, os2_ph_del, os3_ph_del;
real index=0.0;
wire [1:0] phaseselb;
wire loadregb, rstb_new;

integer clkos_fphase_dyn, clkos2_fphase_dyn, clkos3_fphase_dyn, clkop_fphase_dyn;
integer clkos_cphase_dyn, clkos2_cphase_dyn, clkos3_cphase_dyn, clkop_cphase_dyn;
// reg clkos_fphase_dyn, clkos2_fphase_dyn, clkos3_fphase_dyn, clkop_fphase_dyn;
// reg clkos_cphase_dyn, clkos2_cphase_dyn, clkos3_cphase_dyn, clkop_cphase_dyn;

reg a0_out, b0_out, c0_out, d0_out;
reg pha, phb, phc, phd;
reg a1_out, b1_out, c1_out, d1_out;
reg refclkmux_out, fbkclkmux_out; 
reg diva_out_del, divb_out_del, divc_out_del, divd_out_del;
reg diva_out_del2, divb_out_del2, divc_out_del2, divd_out_del2;
reg diva_out_del1, divb_out_del1, divc_out_del1, divd_out_del1;
reg diva_out_del1_last, divb_out_del1_last, divc_out_del1_last, divd_out_del1_last;
reg diva_out, divb_out, divc_out, divd_out;
reg a2_out, b2_out, c2_out, d2_out;
reg clkop_out,clkop_sync, clkos_out, clkos2_out, clkos3_out;
reg first_time_refclkmux, first_time_fbkclkmux;  
reg first_time_a, first_time_b, first_time_c, first_time_d, first_time7;
integer clkfb_div_reg, clki_div_reg, clkop_div_reg, clkos_div_reg;
integer clkos2_div_reg, clkos3_div_reg;

//integer load_count_op, load_count_os, load_count_os2, load_count_os3;
reg vco_clk, vco_clk_a, vco_clk_b, dphsrcb;
wire clkintfb_b;


// ##############################
// for sapphire, create an internal register which has the feedback information.
// ##############################
reg  [1:0] pll_fb_info;  // 2'b00-> op; 2'b01->os; 2'b10-> os2, 2'b11->os3
reg stdby_state; 

integer load_cnt_op, load_cnt_os, load_cnt_os2, load_cnt_os3;

 
wire clki, clkfb, pfdref, pfdfbk;
reg  fbkclkmux; 
reg  fb_nature;  // 1'b0 -> external ; 1'b1 -> internal   

buf u101 (refclk, clki);
buf u1 (clkos, clkosreg1);
buf u2 (clkop, clkopreg1);
buf u3 (clkos2, clkos2reg1);
buf u50 (clkos3, clkos3reg1);
buf u4 (lock, lockreg3);
buf u6 (clkib, clki);
buf u7 (fbb, clkfb);
buf u81 (rstb, pllreset);

//inv uinv (done_cfg_n, done_cfg); 
wire  done_cfg_n = ~done_cfg;


buf u34 (phaseselb[1], cib_dyn_sel[1]);
buf u35 (phaseselb[0], cib_dyn_sel[0]);
buf u36 (phasedirb, cib_direction);
buf u37 (phasestepb, cib_rotate);
buf u38 (loadregb, cib_load_reg);
buf u39 (clkintfb, clkintfb_b);
buf u40 (phasesrcstat, dphsrcb);   // ????
buf u41 (int_lock, intlockreg);

initial
begin

   pll_fb_info = 2'b00;  
   if (FEEDBK_PATH == "CLKOP" || FEEDBK_PATH == "USERCLOCK" || FEEDBK_PATH == "INT_OP")
      pll_fb_info = 2'b00;  
   else if (FEEDBK_PATH == "CLKOS" || FEEDBK_PATH == "INT_OS")
      pll_fb_info = 2'b01;  
   else if (FEEDBK_PATH == "CLKOS2" || FEEDBK_PATH == "INT_OS2")
      pll_fb_info = 2'b10;
   else if (FEEDBK_PATH == "CLKOS3" || FEEDBK_PATH == "INT_OS3")
      pll_fb_info = 2'b11;

   stdby_state = 1'b0; 
   fb_nature =  1'b0; 

   pfd_holding_dn = 1'b0; 
   pfd_holding_up = 1'b0;
   pfd_dn_reg = 1'b0;
   pfd_up_reg = 1'b0;
   pfdref_reg = 1'b0;
   pfdfbk_reg = 1'b0;

   load_cnt_op = 1;
   load_cnt_os = 1;
   load_cnt_os2 = 1;
   load_cnt_os3 = 1;
   clkop_first_time = 1'b1;
   load_reg_en = 0;
   load_reg_en_op2 = 0;
   load_reg_en_op1 = 0;
   load_reg_en_op = 0;
   last_load_reg_en_op = 0;
   load_reg_en_os_2 = 0;
   load_reg_en_os_1 = 0;
   load_reg_en_os = 0;
   last_load_reg_en_os = 0;
   load_reg_en_os2_2 = 0;
   load_reg_en_os2_1 = 0;
   load_reg_en_os2 = 0;
   last_load_reg_en_os2 = 0;
   load_reg_en_os3_2 = 0;
   load_reg_en_os3_1 = 0;
   load_reg_en_os3 = 0;
   last_load_reg_en_os3 = 0;
   phase_dir = 0;
   phase_step = 0;
   last_phase_step = 0;
   phase_sel = 0;
   wait_pfdref = 0; 
   wait_pfdfbk = 0;
   step_p = 0;
   step_s = 0;
   step_s2 = 0;
   step_s3 = 0;
   step_op = 0;
   step_op1 = 0;
   step_op2 = 0;
   step_os = 0;
   step_os_1 = 0;
   step_os_2 = 0;
   step_os2 = 0;
   step_os2_1 = 0;
   step_os2_2 = 0;
   step_os3 = 0;
   step_os3_1 = 0;
   step_os3_2 = 0;
   if (mc1_dyn_source == 1'b0)
      dphsrcb = 1'b0;
   else
      dphsrcb = 1'b1;
end


// handle the input reference mux

assign refmuxclk = refclkmux; 
assign clki = refclkmux; 
//  
assign pfd_up = pfd_up_reg;
assign pfd_dn = pfd_dn_reg;  
assign pll_mfgout2 = pll_mfgout2_reg;
assign pll_mfgout1 = pll_mfgout1_reg;
//assign int_lock  =  lock; 

wire stdby_internal; 

assign stdby_internal = (mc1_stdby & stdby); 

wire [3:0] mc1_sel_out_abcd; 

assign mc1_sel_out_abcd = {mc1_sel_outd, mc1_sel_outc, mc1_sel_outb, mc1_sel_outa};   

// pll_fb_info_reg[3:0] = [os3,os2,os,op]
reg [3:0] pll_fb_info_reg; 

always @(pll_fb_info)
begin
    case (pll_fb_info)  
          2'b00: pll_fb_info_reg = 4'b0001;   
          2'b01: pll_fb_info_reg = 4'b0010;  
          2'b10: pll_fb_info_reg = 4'b0100;  
          2'b11: pll_fb_info_reg = 4'b1000;  
          default: $display("illegal pll_fb_info value");
    endcase 
end 

always @(mc1_mfgout2_sel, refclkmux, pfdfbk_reg, pfdref_reg, int_lock, clkop, pfd_dn, pfd_up)
begin
    case (mc1_mfgout2_sel)
          3'b000:   pll_mfgout2_reg = 1'b0;
          3'b001:   pll_mfgout2_reg = refclkmux;
          3'b010:   pll_mfgout2_reg = int_lock;
          3'b011:   pll_mfgout2_reg = clkop;
          3'b100:   pll_mfgout2_reg = pfd_dn;
          3'b101:   pll_mfgout2_reg = pfd_up;
          3'b110:   pll_mfgout2_reg = pfdfbk_reg;
          3'b111:   pll_mfgout2_reg = pfdref_reg;
          default: $display("illegal mc1_mfgout2_sel");
    endcase
end

always @(mc1_mfgout1_sel, pfdfbk_reg, pfdref_reg, clkos2, clkos, clkop, pfd_dn, pfd_up)
begin
    case (mc1_mfgout1_sel)
          3'b000:   pll_mfgout1_reg = 1'b0;
          3'b001:   pll_mfgout1_reg = clkos2;
          3'b010:   pll_mfgout1_reg = clkos;
          3'b011:   pll_mfgout1_reg = clkop;
          3'b100:   pll_mfgout1_reg = pfd_dn;
          3'b101:   pll_mfgout1_reg = pfd_up;
          3'b110:   pll_mfgout1_reg = pfdfbk_reg;
          3'b111:   pll_mfgout1_reg = pfdref_reg;
          default: $display("illegal mc1_mfgout1_sel");
    endcase
end

// input mux1
always @(mc1_sel_ref1, refclk1)
begin
    case (mc1_sel_ref1)
          3'b000:   refclkmux1 = refclk1[0];
          3'b001:   refclkmux1 = refclk1[1];
          3'b010:   refclkmux1 = refclk1[2];
	  3'b011:   refclkmux1 = refclk1[3];
          3'b100:   refclkmux1 = refclk1[4];
	  3'b101:   refclkmux1 = refclk1[5];
	  3'b110:   refclkmux1 = refclk1[6];
	  3'b111:   refclkmux1 = refclk1[7];	  
          default: $display("illegal mc1_sel_ref1 codes");
    endcase  
end 

//input mux2
always @(mc1_sel_ref2, refclk2)
begin
    case (mc1_sel_ref2)
          3'b000:   refclkmux2 = refclk2[0];
	  3'b001:   refclkmux2 = refclk2[1];
	  3'b010:   refclkmux2 = refclk2[2];
	  3'b011:   refclkmux2 = refclk2[3];
          3'b100:   refclkmux2 = refclk2[4];
	  3'b101:   refclkmux2 = refclk2[5];
	  3'b110:   refclkmux2 = refclk2[6];
	  3'b111:   refclkmux2 = refclk2[7];	  
          default: $display("illegal mc1_sel_ref2 codes");
    endcase  
end

// dynamic mux1/2 selections
always @(refclkmux1, refclkmux2, refin_sel)
begin
    case (refin_sel)
          1'b0:    refclkmux = refclkmux1;        
          1'b1:    refclkmux = refclkmux2;
	   default: $display("illegal refin_sel code"); 
    endcase 
end 

// end of handing the input reference muxes (mux1 and mux2)

// hanlde the feedback inputs

assign clkfb = fbkclkmux;

always @(pll_fb_info, mc1_sel_fbk, fbkclk, divd_out_del, divc_out_del, divb_out_del, diva_out_del, intfb_out)
begin
    case (mc1_sel_fbk)
          4'b0000:   begin fbkclkmux = fbkclk[0]; fb_nature = 1'b0;    end 
	  4'b0001:   begin fbkclkmux = fbkclk[1]; fb_nature = 1'b0;    end 
	  4'b0010:   begin fbkclkmux = fbkclk[2]; fb_nature = 1'b0;    end
	  4'b0011:   begin fbkclkmux = fbkclk[3]; fb_nature = 1'b0;    end 
          4'b0100:   begin fbkclkmux = fbkclk[4]; fb_nature = 1'b0;    end 
	  4'b0101:   begin fbkclkmux = fbkclk[5]; fb_nature = 1'b0;    end 
	  4'b0110:   begin fbkclkmux = fbkclk[6]; fb_nature = 1'b0;    end 
	  4'b0111:   begin fbkclkmux = fbkclk[7]; fb_nature = 1'b0;    end 	  
	  4'b1000:   begin fbkclkmux = fbkclk[8]; fb_nature = 1'b0;    end 
	  4'b1001:   begin fbkclkmux = fbkclk[9]; fb_nature = 1'b0;    end 
	  4'b1010:   begin fbkclkmux = fbkclk[10]; fb_nature = 1'b0;   end 
          4'b1011:   begin fbkclkmux = divd_out_del; fb_nature = 1'b1;   end 
          4'b1100:   begin fbkclkmux = divc_out_del; fb_nature = 1'b1;   end 
          4'b1101:   begin fbkclkmux = divb_out_del; fb_nature = 1'b1;   end 
          4'b1110:   begin fbkclkmux = diva_out_del; fb_nature = 1'b1;   end 
          4'b1111:   fbkclkmux = intfb_out;    // NEED to CHECK;
          default:   $display("illegal mc1_sel_fbk codes");
    endcase  
end

// end of handling the feedbakc input mux


always @ (phase_step)
begin
   last_phase_step <= phase_step;
end

always @ (load_reg_en_op, load_reg_en_os, load_reg_en_os2, load_reg_en_os3)
begin
   last_load_reg_en_op <= load_reg_en_op;  // @ falling edge of the divx_out_del1
   last_load_reg_en_os <= load_reg_en_os;
   last_load_reg_en_os2 <= load_reg_en_os2;
   last_load_reg_en_os3 <= load_reg_en_os3;
end

always @ (diva_out_del1, divb_out_del1, divc_out_del1, divd_out_del1)
begin
   diva_out_del1_last <= diva_out_del1;
   divb_out_del1_last <= divb_out_del1;
   divc_out_del1_last <= divc_out_del1;
   divd_out_del1_last <= divd_out_del1;
end

// generate false clocks
initial begin
   false_clk = 1'b0;
   forever #5 false_clk = ~false_clk;
end

assign clkintfb_b = false_clk;                                                                                    
// measure input clock period
                                                                                    
initial
begin
   lock_delay_reg = 1.0;
   last_clock_edge = 0.0;
   next_clock_edge = 0.0;
   t_in_clk = 0.0;
   t_in_clk1 = 0.0;
   t_in_clk2 = 0.0;
   t_in_clk3 = 0.0;
   net_divide = 1.0;
   net_divide1 = 1.0;
end

initial
begin
pha = 1'b0;
phb = 1'b0;
phc = 1'b0;
phd = 1'b0;
a0_out = 1'b0;
b0_out = 1'b0;
c0_out = 1'b0;
d0_out = 1'b0;
a1_out = 1'b0;
b1_out = 1'b0;
c1_out = 1'b0;
d1_out = 1'b0;
a2_out = 1'b0;
b2_out = 1'b0;
c2_out = 1'b0;
d2_out = 1'b0;
refclkmux_out=1'b0;  
fbkclkmux_out=1'b0;
diva_out = 1'b0;
divb_out = 1'b0;
divc_out = 1'b0;
divd_out = 1'b0;
diva_out_del = 1'b0;
divb_out_del = 1'b0;
divc_out_del = 1'b0;
divd_out_del = 1'b0;
diva_out_del1 = 1'b0;
diva_out_del2 = 1'b0;
divb_out_del1 = 1'b0;
divb_out_del2 = 1'b0;
divc_out_del1 = 1'b0;
divc_out_del2 = 1'b0;
divd_out_del1 = 1'b0;
divd_out_del2 = 1'b0;
clkop_out = 1'b0; 
// 
clkos_out = 1'b0;
clkos2_out = 1'b0;
clkos3_out = 1'b0;
//
clkop_sync = 1'b0; 
d4_lock = 1'b1;
d3_lock = 1'b1;
d2_lock = 1'b1;
d1_lock = 1'b1;
d_lock = 1'b1;
fb_count = 0;
delay_lockreg1 = 1'b0; 
first_time_refclkmux = 1; 
first_time_fbkclkmux = 1;
first_time_a = 1;
first_time_b = 1;
first_time_c = 1;
first_time_d = 1;
first_time7 = 1;
ratio1 = 0;
out_clk_valid = 0;
lock_all = 0;
vir_kclk = 0;
vir_kclk_p = 0;
vir_kclk_s = 0;
vir_k2clk = 0;
vir_lock = 0;
clock_valid = 0;
clock_invalid = 1;
final_sclk = 0;
vir_sclk = 0;
vir_intfb = 0;
vir_pclk = 0;
intfb_out = 0;
false_clk = 0;
clkosreg = 0;
clkosreg1 = 0;
clkopreg = 0;
clkopreg1 = 0;
clkos2reg = 0;
clkos2reg1 = 0;
clkos3reg = 0;
clkos3reg1 = 0;
lockreg = 0;
intlockreg = 0;
lockreg1 = 0;
lockreg2 = 0;
lockreg3 = 0;
end

initial
begin
     #1;
     clkop_fphase_dyn  = mc1_phia + 0 ;
     clkop_cphase_dyn  = mc1_dela + 0 ;
     clkos_fphase_dyn  = mc1_phib + 0 ;
     clkos_cphase_dyn  = mc1_delb + 0 ;
     clkos2_fphase_dyn = mc1_phic + 0 ;
     clkos2_cphase_dyn = mc1_delc + 0 ;
     clkos3_fphase_dyn = mc1_phid + 0 ;
     clkos3_cphase_dyn = mc1_deld + 0 ;
                                                                                                                  
     #1; 
     clkfb_div_reg  = mc1_divfbk + 1;
     clki_div_reg   = mc1_divref + 1;
     clkop_div_reg  = mc1_diva + 1;
     clkos_div_reg  = mc1_divb + 1;
     clkos2_div_reg = mc1_divc + 1;
     clkos3_div_reg = mc1_divd + 1;

end



// For pfd_dn and pfd_up MFG signals 
always @(pfd_holding_dn or pfd_holding_up)
  begin 
           if (pfd_holding_up == 1'b1 && pfd_holding_dn == 1'b1)
              begin
                #2;
                pfd_dn_reg = 1'b0;
                pfd_up_reg = 1'b0;
                pfd_holding_dn = 1'b0;
                pfd_holding_up = 1'b0;
              end 
  end 

always @(posedge pfdref_reg)
  begin 
       if (pfdref_reg == 1'b1)
              begin
                pfd_holding_dn = 1'b1;
                pfd_dn_reg = 1'b1;
              end
  end 

always @(posedge pfdfbk_reg)
  begin
       if (pfdfbk_reg == 1'b1)
              begin
                pfd_holding_up = 1'b1;
                pfd_up_reg = 1'b1;
              end
  end


// begin muxa2/b2/c2/d2

  always @(*)
  begin
     if (mc1_sel_outa == 1'b0)
        a2_out <= diva_out_del;
     else if (mc1_sel_outa == 1'b1)
        a2_out <= clkib;
  end

  always @(*)
  begin
     if (mc1_sel_outb == 1'b0)
        b2_out <= divb_out_del;
     else if (mc1_sel_outb == 1'b1)
        b2_out <= clkib;
  end

  always @(*)
  begin
     if (mc1_sel_outc == 1'b0)
        c2_out <= divc_out_del;
     else if (mc1_sel_outc == 1'b1)
        c2_out <= clkib;
  end

  always @(*)
  begin
     if (mc1_sel_outd == 1'b0)
        d2_out <= divd_out_del;
     else if (mc1_sel_outd == 1'b1)
        d2_out <= clkib;
  end

// end muxa2


// begin output clock enable
// &&&&&&&&&&&&&&&
  always @(a2_out) 
  begin
     if (mc1_enable_sync == 1'b1)
        begin  
        if (mc1_enable_clk[0] == 1'b0 && enclkop == 1'b0)
            begin 
               clkop_out <= 1'b0; 
               clkop_sync <=1'b0;  
            end  
        else 
            begin  
               clkop_out <= a2_out;  // from a2 mux
               clkop_sync <=1'b1; 
            end 
        end 
     else   // Original case 
        begin
        if (mc1_enable_clk[0] == 1'b0 && enclkop == 1'b0)
            clkop_out <= 1'b0;
        else
            clkop_out <= a2_out;  // from a2 mux 
        end 
  end

  //always @(*)
  always @(b2_out) 
  begin
     if (mc1_enable_sync == 1'b1)
        begin
        if (clkop_sync == 1'b1)
            clkos_out <= b2_out;
        else
            clkos_out <= 1'b0; 
        end 
     else 
        begin 
        if (mc1_enable_clk[1] == 1'b0 && enclkos == 1'b0)
            clkos_out <= 1'b0;
        else
            clkos_out <= b2_out;  // from b2 mux
        end
  end

  //always @(*)
  always @(c2_out) 
  begin
     if (mc1_enable_sync == 1'b1)
        begin
        if (clkop_sync == 1'b1)
            clkos2_out <= c2_out;
        else
            clkos2_out <= 1'b0; 
        end 
     else
        begin
        if (mc1_enable_clk[2] == 1'b0 && enclkos2 == 1'b0)
            clkos2_out <= 1'b0;
        else
            clkos2_out <= c2_out;  // from c2 mux
        end
  end

  //always @(*)
  always @(d2_out) 
  begin
     if (mc1_enable_sync == 1'b1)
        begin
        if (clkop_sync == 1'b1)
            clkos3_out <= d2_out;
        else
            clkos3_out <= 1'b0; 
        end 
     else
        begin
        if (mc1_enable_clk[3] == 1'b0 && enclkos3 == 1'b0)
            clkos3_out <= 1'b0;
        else
            clkos3_out <= d2_out;  // from d2 mux
        end
  end

// end clock enable

  always @(*)
  begin
    if (rstb_new == 1'b1)
    begin
       assign index_diva = 0;
       assign index_divb = 0;
       assign index_divc = 0;
       assign index_divd = 0;
       assign index_refclkmux = 0; 
       assign index_fbkclkmux = 0;
       assign index = 0.0;
       assign first_time_refclkmux = 1'b1; 
       assign first_time_fbkclkmux = 1'b1;
       assign first_time_a = 1'b1;
       assign first_time_b = 1'b1;
       assign first_time_c = 1'b1;
       assign first_time_d = 1'b1;
       assign first_time7 = 1'b1;
    end
    else
    begin
       deassign index_diva;
       deassign index_divb;
       deassign index_divc;
       deassign index_divd;
       deassign index_refclkmux;
       deassign index_fbkclkmux;  
       deassign index;
       deassign first_time_refclkmux; 
       deassign first_time_fbkclkmux; 
       deassign first_time_a;
       deassign first_time_b;
       deassign first_time_c;
       deassign first_time_d;
       deassign first_time7;
    end
  end

always @ (refclkmux_div)  
   begin 
       if (first_time_refclkmux == 1'b1)
         begin
            index_refclkmux = 0;
            pfdref_reg = 1'b1; 
            first_time_refclkmux = 1'b0;
         end
      else
         begin 
             index_refclkmux = index_refclkmux + 1;
             if (index_refclkmux >= (mc1_divref + 1))
                begin
                    pfdref_reg = ~pfdref_reg;
                    index_refclkmux = 0;
                end
         end 
   end 

always @ (fbkclkmux_div)
   begin
       if (first_time_fbkclkmux == 1'b1)
         begin
            index_fbkclkmux = 0;
            pfdfbk_reg = 1'b1;
            first_time_fbkclkmux = 1'b0;
         end
      else
         begin
             index_fbkclkmux = index_fbkclkmux + 1;
             if (index_fbkclkmux >= (mc1_divfbk + 1))
                begin
                    pfdfbk_reg = ~pfdfbk_reg;
                    index_fbkclkmux = 0;
                end
         end
   end

assign refclkmux_div = refclkmux & refclkmux_ctrl;    

  // Add in rstb_new (Active HIGH)  
  // pfdref  
  always @(posedge rstb_new or refclkmux or first_time_refclkmux)
  begin
    if (rstb_new == 1'b1) 
       begin 
        first_time_refclkmux = 1'b1; 
        index_refclkmux = 1'b0;
        pfdref_reg = 1'b0; 
        wait_pfdref = 0; 
        refclkmux_ctrl = 1'b0;
       end 
    else  // Not in reset state        
      begin  
        if (rstb_new == 1'b0 && wait_pfdref <= 6 )
           begin
               index_refclkmux = 0;
               first_time_refclkmux = 1'b1;
               wait_pfdref = wait_pfdref + 1 ;
               //pfdref_reg = 1'b0;
               refclkmux_ctrl = 1'b0; 
           end
        else   
           begin 
               refclkmux_ctrl = 1'b1;        
           end  
      end  // else  // Not in reset state   
  end  // always @(rstb_new or refclkmux or first_time_refclkmux) 


//  always @ (posedge rstb_new)
//  begin
//      first_time_fbkclkmux = 1'b1;
//      index_fbkclkmux = 1'b0;
//      pfdfbk_reg = 1'b0;
//      wait_pfdfbk = 0;
//      fbkclkmux_ctrl = 1'b0;
//  end 

reg first_time_fbk;

//assign fbkclkmux_div = fbkclkmux & fbkclkmux_ctrl;

  // Add in rstb_new (Active HIGH)
  // pfdfbk
  always @(posedge rstb_new or fbkclkmux or first_time_fbkclkmux)
  begin
    if (rstb_new == 1'b1)
       begin
        first_time_fbkclkmux = 1'b1;
        index_fbkclkmux = 1'b0;
        pfdfbk_reg = 1'b0;
        wait_pfdfbk = 0;
        fbkclkmux_ctrl = 1'b0;
        first_time_fbk = 1'b0;
       end
    else  // Not in reset state
      begin
        if (rstb_new == 1'b0 && wait_pfdfbk <= 6 )
           begin
             //  if (fbkclkmux == 1'b0 || first_time_fbk == 1'b1) 
             //     begin  
                      index_fbkclkmux = 0;
                      first_time_fbkclkmux = 1'b1;
                      wait_pfdfbk = wait_pfdfbk + 1 ;
                      //pfdfbk_reg = 1'b0;
                      fbkclkmux_ctrl = 1'b0;
           end 
           //    else  
           //       first_time_fbk = 1'b1; 
           //end
        else
           begin
               fbkclkmux_ctrl = 1'b1;
           end
      end  // else  // Not in reset state
  end  // always @(rstb_new or fbkclkmux or first_time_refclkmux)

assign fbkclkmux_div = fbkclkmux & fbkclkmux_ctrl;



//  always @(fbkclkmux or first_time_fbkclkmux)
//  begin
//      if (first_time_fbkclkmux == 1'b1)
//      begin
//        // if (fbkclkmux === 1'b1)
//         begin
//            index_fbkclkmux = 0;
//            first_time_fbkclkmux = 1'b0;
//            pfdfbk_reg = 1'b0;
//         end
//      end
//      //else if (index_fbkclkmux == 0 && fbkclkmux == 1'b1) 
//      //         pfdfbk_reg = 1'b1;
//      else 
//      begin
//        //if (fbkclkmux == 1'b1)
//        //   pfdfbk_reg = 1;
//        index_fbkclkmux = index_fbkclkmux + 1;
//        if (index_fbkclkmux >= (mc1_divfbk + 1))
//        begin
//           pfdfbk_reg = ~pfdfbk_reg;
//           index_fbkclkmux = 0;
//        end
//      end
//  end
  
  // dividers da/db/dc/dd ; input pha; output diva_out
  always @(pha)
  begin
      if (first_time_a == 1'b1)
      begin
         if (pha === 1'b1)
         begin
            index_diva = 0;
            first_time_a = 1'b0;
            diva_out = 1'b1;
         end
      end
     else
     begin
        index_diva = index_diva + 1;
        if (index_diva >= (mc1_diva + 1))
        begin
           diva_out = ~diva_out;
           index_diva = 0;
        end
     end
  end

  always @(phb)
  begin
      if (first_time_b == 1'b1)
      begin
         if (phb === 1'b1)
         begin
            index_divb = 0;
            first_time_b = 1'b0;
            divb_out = 1'b1;
         end
      end
     else
     begin
        index_divb = index_divb + 1;
        if (index_divb >= (mc1_divb + 1))
        begin
           divb_out = ~divb_out;
           index_divb = 0;
        end
     end
  end

  always @(phc)
  begin
      if (first_time_c == 1'b1)
      begin
         if (phc === 1'b1)
         begin
            index_divc = 0;
            first_time_c = 1'b0;
            divc_out = 1'b1;
         end
      end
     else
     begin
        index_divc = index_divc + 1;
        if (index_divc >= (mc1_divc + 1))
        begin
           divc_out = ~divc_out;
           index_divc = 0;
        end
     end
  end

  always @(phd)
  begin
      if (first_time_d == 1'b1)
      begin
         if (phd === 1'b1)
         begin
            index_divd = 0;
            first_time_d = 1'b0;
            divd_out = 1'b1;
         end
      end
     else
     begin
        index_divd = index_divd + 1;
        if (index_divd >= (mc1_divd + 1))
        begin
           divd_out = ~divd_out;
           index_divd = 0;
        end
     end
  end

  //  end of dividers da/db/dc/dd
  
  
  // determin the feedabck divider value
  always @(*)
  begin
     // Add in due to the way of simulation fuse setup not at the beginning  
     clkop_fphase_dyn  = mc1_phia + 0 ;
     clkop_cphase_dyn  = mc1_dela + 0 ;
     clkos_fphase_dyn  = mc1_phib + 0 ;
     clkos_cphase_dyn  = mc1_delb + 0 ;
     clkos2_fphase_dyn = mc1_phic + 0 ;
     clkos2_cphase_dyn = mc1_delc + 0 ;
     clkos3_fphase_dyn = mc1_phid + 0 ;
     clkos3_cphase_dyn = mc1_deld + 0 ;

     clkfb_div_reg = mc1_divfbk + 1;   // feedback divider
     clki_div_reg = mc1_divref + 1;    // reference divider
     clkop_div_reg = mc1_diva + 1;     // divider-a
     clkos_div_reg = mc1_divb + 1;     // divider-b
     clkos2_div_reg = mc1_divc + 1;    // divider-c
     clkos3_div_reg = mc1_divd + 1;    // divider-d

//     if ((pll_fb_info == 2'b00) || (mc1_sel_fbk == 4'b1110))
//     begin
//        net_divide1 = clkop_div_reg;
//     end
//     else if ((pll_fb_info == 2'b01) || (mc1_sel_fbk == 4'b1101))
//     begin
//        net_divide1 = clkos_div_reg;
//     end
//     else if ((pll_fb_info == 2'b10) || (mc1_sel_fbk == 4'b1100))
//     begin
//        net_divide1 = clkos2_div_reg;
//     end
//     else if ((pll_fb_info == 2'b11) || (mc1_sel_fbk == 4'b1011))
//     begin
//        net_divide1 = clkos3_div_reg;
//     end

       if (mc1_sel_fbk == 4'b1110)
            net_divide1 = clkop_div_reg; 
       else if (mc1_sel_fbk == 4'b1101)
            net_divide1 = clkos_div_reg;
       else if (mc1_sel_fbk == 4'b1100)
            net_divide1 = clkos2_div_reg;
       else if (mc1_sel_fbk == 4'b1011)
           net_divide1 = clkos3_div_reg;

       if ((fb_nature == 1'b0) && (pll_fb_info == 2'b00))
            net_divide1 = clkop_div_reg;
       else if ((fb_nature == 1'b0) && (pll_fb_info == 2'b01))
            net_divide1 = clkos_div_reg;
       else if ((fb_nature == 1'b0) && (pll_fb_info == 2'b10))   
            net_divide1 = clkos2_div_reg;
       else if ((fb_nature == 1'b0) && (pll_fb_info == 2'b11))
            net_divide1 = clkos3_div_reg;
            
  end

  // determine the effective feedback value : n*v
  always @(*)
  begin
     net_divide <= (clkfb_div_reg * net_divide1);
  end

  // end of the feedback divider value
  
  // measure the feedback delay value
  // generate an rising edge on false_clk_first_time                                                                                    
  initial
   begin
      first_int_edge = 0.0;
      first_fb_edge = 0.0;
      virtual_delay1 = 0.0;
       false_clk_first_time = 1'b0;
       fb_first_time = 1'b0;
       #1;
       false_clk_first_time = 1'b1;
       fb_first_time = 1'b1;
   end
  
  // capture the real time of the false_clk's rising edge   
  always @(posedge false_clk)
  begin
     if (false_clk_first_time == 1)
     first_int_edge=$realtime;
     false_clk_first_time = 1'b0;
  end
           
  // capture the real time of the fbb's rising edge		   
  always @(posedge fbb)
  begin
     if ((fb_first_time == 1) && (fbb == 1))  //adding fbb==1  9/20/13
     begin
        first_fb_edge=$realtime;
        fb_first_time = 1'b0;
     end
  end
  
  // get the output -> feedback input delay timing.
  always @(fbb or clkib)
  begin
     total_fb_delay = first_fb_edge - first_int_edge;   // get a sense of the output to feedacbk delay
     if ( (total_fb_delay > 0) && (t_in_clk > 0) )    
     begin
        ratio1 = total_fb_delay / t_in_clk;   
        virtual_delay1 = total_fb_delay - (t_in_clk * ratio1);
        real_delay1 = t_in_clk - virtual_delay1;
     end
  end

  always @(posedge fbb)
  begin
     fb_count = fb_count + 1;
     // if (fb_count == 6)
     if (fb_count == 4)
        clkop_first_time = 1'b0;   // initial value = 1'b1; after 6 feedback clock, de-assert the clkop_first_time variable
  end

  always @(posedge clkib)
   begin
   last_clock_edge=next_clock_edge;
   next_clock_edge=$realtime;

        // get the input period
        if (last_clock_edge > 0)
        begin
        t_in_clk <= next_clock_edge - last_clock_edge;  
        t_in_clk1 <= t_in_clk;
        t_in_clk2 <= t_in_clk1;
        t_in_clk3 <= t_in_clk2;
        end
        
		// precision/valid checking 
        if (t_in_clk > 0)
        begin
         if ( ((t_in_clk - t_in_clk1) < 0.0001) && ((t_in_clk - t_in_clk1) > -0.0001) && ((t_in_clk1 - t_in_clk2) < 0.0001) && ((t_in_clk1 - t_in_clk2) > -0.0001) && ((t_in_clk2 - t_in_clk3) < 0.0001) && ((t_in_clk2 - t_in_clk3) > -0.0001))
           clock_valid <= 1;
         else
           clock_valid <= 0;
        end
        
        // invalid checking		
        if (t_in_clk > 0)
        begin
         if ( ((t_in_clk - t_in_clk1) < 0.0001) && ((t_in_clk - t_in_clk1) > -0.0001))
           clock_invalid <= 0;
         else
           clock_invalid <= 1;
        end

		// translate the input period with input divider and effective feedback divider value to vco period
        if (t_in_clk > 0)
        begin
           t_vco = ((t_in_clk * clki_div_reg) / net_divide);
           ha_vco1 = (t_vco / 2);
           ha_clk_a = (ha_vco1 * (mc1_diva + 1));
           ha_clk_b = (ha_vco1 * (mc1_divb + 1));
           t_diva_clk = 2 * ha_clk_a;
           t_divb_clk = 2 * ha_clk_b;
           t_divc_clk = (t_vco * (mc1_divc + 1));
           t_divd_clk = (t_vco * (mc1_divd + 1));
           ha_vco_xprec = ha_vco1 * 100000; //convert to time precision (multiply by 1ns/10fs), take integer value
           ha_vco_sim = ha_vco_xprec / 100000.0; //time as it appears in simulation (with precision error)
           round_err = ((t_in_clk - ((ha_vco_sim * 2 * net_divide) / clki_div_reg)) / 2);
        end
   end
                                                                                                
// dynamic cib phase shift
  always @ (*)
  begin
     if (mc1_dyn_source == 1'b1)
     begin
        load_reg_en <= loadregb;   // <- CIB_LOAD_REG 
        phase_dir <= phasedirb;    // <- CIB_DIRECTION 
        phase_step <= phasestepb;  // <- CIB_ROTATE 
        phase_sel <= phaseselb;    // <- CIB_DYN_SEL
     end
     else 
     begin
        load_reg_en <= 1'b0;
        phase_dir <= 1'b0;
        phase_step <= 1'b0;
        phase_sel <= 1'b0;
     end
  end

  // the load_reg_en_op2 is pipped from diva_out clock with 
  always @ (posedge load_reg_en_op2)
  begin
     if (phase_sel == 2'b11)
        load_cnt_op  <= load_cnt_op + 1;
  end

  always @ (posedge load_reg_en_os_2)
  begin
     if (phase_sel == 2'b00)
        load_cnt_os <= load_cnt_os + 1;
  end

  always @ (posedge load_reg_en_os2_2)
  begin
     if (phase_sel == 2'b01)
        load_cnt_os2 <= load_cnt_os2 + 1;
  end

  always @ (posedge load_reg_en_os3_2)
  begin
     if (phase_sel == 2'b10)
        load_cnt_os3 <= load_cnt_os3 + 1;
  end

// ***  Need to Check the logic in this section 
  always @(*)
  begin
     if (rstb_new == 1'b1)
     begin 
        step_p <= 0;
        step_s <= 0;
        step_s2<= 0;
        step_s3 <= 0;
//        step_n <= 0;
     end
     else
     begin 
        if (phase_sel == 2'b11)
        begin
           if (phase_step === 1'b0 && last_phase_step === 1'b1)
           begin
	      if (FEEDBK_PATH == "CLKOP" || FEEDBK_PATH == "INT_OP")
	      begin
	         $display ("Warning! FEEDBK_PATH is CLKOP or INT_OP, there should be no dynamic phase shift on CLKOP");
              end
              if (phase_dir == 1'b0)    // 1'b0 rotate forward; otherwise, backward.
              begin
                 step_p <= step_p + 1;
//                 step_s <= 1'b0;  
//                 step_s2 <= 1'b0; 
//                 step_s3 <= 1'b0; 
              end
              else
              begin
                 step_p <= step_p - 1;
//                 step_s <= 1'b0;
//                 step_s2 <= 1'b0;
//                 step_s3 <= 1'b0;
              end
           end
        end
        else if (phase_sel == 2'b00)
        begin
           if (phase_step === 1'b0 && last_phase_step === 1'b1)
           begin
	      if (FEEDBK_PATH == "CLKOS" || FEEDBK_PATH == "INT_OS")
	      begin
	         $display ("Warning! FEEDBK_PATH is CLKOS or INT_OS, there should be no dynamic phase shift on CLKOS");
              end
              if (phase_dir == 1'b0)
              begin
                 step_s <= step_s + 1;
//                 step_p <= 1'b0;
//                 step_s2 <= 1'b0;
//                 step_s3 <= 1'b0;
              end
              else
              begin
                 step_s <= step_s - 1;
//                 step_p <= 1'b0;
//                 step_s2 <= 1'b0;
//                 step_s3 <= 1'b0;
              end
           end
        end
        else if (phase_sel == 2'b01)
        begin
           if (phase_step === 1'b0 && last_phase_step === 1'b1)
           begin
	      if (FEEDBK_PATH == "CLKOS2" || FEEDBK_PATH == "INT_OS2")
	      begin
	         $display ("Warning! FEEDBK_PATH is CLKOS2 or INT_OS2, there should be no dynamic phase shift on CLKOS2");
              end
              if (phase_dir == 1'b0)
              begin
                 step_s2 <= step_s2 + 1;
//                 step_p <= 1'b0;
//                 step_s <= 1'b0;
//                 step_s3 <= 1'b0;
              end
              else
              begin
                 step_s2 <= step_s2 - 1;
//                 step_p <= 1'b0;
//                 step_s <= 1'b0;
//                 step_s3 <= 1'b0;   
              end
           end
        end
        else if (phase_sel == 2'b10)
        begin
           if (phase_step === 1'b0 && last_phase_step === 1'b1)
           begin
	      if (FEEDBK_PATH == "CLKOS3" || FEEDBK_PATH == "INT_OS3")
	      begin
	         $display ("Warning! FEEDBK_PATH is CLKOS3 or INT_OS3, there should be no dynamic phase shift on CLKOS3");
              end
              if (phase_dir == 1'b0)
              begin
                 step_s3 <= step_s3 + 1;
//                 step_p <= 1'b0;
//                 step_s <= 1'b0;
//                 step_s2 <= 1'b0;
              end
              else
              begin
                 step_s3 <= step_s3 - 1;
//                 step_p <= 1'b0;
//                 step_s <= 1'b0;
//                 step_s2 <= 1'b0;
              end
           end
        end
     end
  end

  always @(posedge diva_out)
  begin
      step_op <= step_p;
      step_op1 <= step_op;
      load_reg_en_op2 <= load_reg_en;   // From the cib_load_reg 
      load_reg_en_op1 <= load_reg_en_op2;
  end

  always @(negedge diva_out_del1)
  begin
      step_op2 <= step_op1;
      load_reg_en_op <= load_reg_en_op1;
  end

  always @(posedge divb_out)
  begin
      step_os <= step_s;
      step_os_1 <= step_os;
      load_reg_en_os_2 <= load_reg_en;
      load_reg_en_os_1 <= load_reg_en_os_2;
  end

  always @(negedge divb_out_del1)
  begin
      step_os_2 <= step_os_1;
      load_reg_en_os <= load_reg_en_os_1;
  end

  always @(posedge divc_out)
  begin
      step_os2 <= step_s2;
      step_os2_1 <= step_os2;
      load_reg_en_os2_2 <= load_reg_en;
      load_reg_en_os2_1 <= load_reg_en_os2_2;
  end

  always @(negedge divc_out_del1)
  begin
      step_os2_2 <= step_os2_1;
      load_reg_en_os2 <= load_reg_en_os2_1;
  end

  always @(posedge divd_out)
  begin
      step_os3 <= step_s3;
      step_os3_1 <= step_os3;
      load_reg_en_os3_2 <= load_reg_en;
      load_reg_en_os3_1 <= load_reg_en_os3_2;
  end

  always @(negedge divd_out_del1)
  begin
      step_os3_2 <= step_os3_1;
      load_reg_en_os3 <= load_reg_en_os3_1;
  end
/*
  always @ (load_reg_en or posedge diva_out)
  begin
     if (load_reg_en == 1'b1 || load_count_op > 4)
        load_count_op = 0;
     else 
        load_count_op = load_count_op + 1; 
  end

  always @ (load_reg_en or posedge divb_out)
  begin
     if (load_reg_en == 1'b1 || load_count_os > 4)
        load_count_os = 0;
     else
        load_count_os = load_count_os + 1;
  end

  always @ (load_reg_en or posedge divc_out)
  begin
     if (load_reg_en == 1'b1 || load_count_os2 > 4)
        load_count_os2 = 0;
     else
        load_count_os2 = load_count_os2 + 1;
  end

  always @ (load_reg_en or posedge divd_out)
  begin
     if (load_reg_en == 1'b1 || load_count_os3 > 4)
        load_count_os3 = 0;
     else
        load_count_os3 = load_count_os3 + 1;
  end
*/
  always @ (*) 
  begin
//     if (phase_sel == 2'b11)
//     begin
        if (t_diva_clk > 0)
        begin
           if (step_op2 >= 0)
           begin
              vco_ph_del_a <= ((clkop_fphase_dyn + step_op2) * t_diva_clk) / (8 * clkop_div_reg);   
           end
           else if (step_op2 < 0) 
           begin
              vco_ph_del_a <= t_diva_clk - (((clkop_fphase_dyn - step_op2) * t_diva_clk) / (8 * clkop_div_reg));   
           end
        end
//     end
//     else if (phase_sel == 2'b00)
//     begin
        if (t_divb_clk > 0)
        begin
           if (step_os_2 >= 0)
           begin
              vco_ph_del_b <= ((clkos_fphase_dyn + step_os_2) * t_divb_clk) / (8 * clkos_div_reg);
           end
           else if (step_os_2 < 0)
           begin
              vco_ph_del_b <= t_divb_clk - (((clkos_fphase_dyn - step_os_2) * t_divb_clk) / (8 * clkos_div_reg));
           end
        end
//     end
//     else if (phase_sel == 2'b01)
//     begin
        if (t_divc_clk > 0)
        begin
           if (step_os2_2 >= 0)
           begin
              vco_ph_del_c <= ((clkos2_fphase_dyn + step_os2_2) * t_divc_clk) / (8 * clkos2_div_reg);
           end
           else if (step_os2_2 < 0)
           begin
              vco_ph_del_c <= t_divc_clk - (((clkos2_fphase_dyn - step_os2_2) * t_divc_clk) / (8 * clkos2_div_reg));
           end
        end
//     end
//     else if (phase_sel == 2'b10)
//     begin
        if (t_divd_clk > 0)
        begin
           if (step_os3_2 >= 0)
           begin
              vco_ph_del_d <= ((clkos3_fphase_dyn + step_os3_2) * t_divd_clk) / (8 * clkos3_div_reg);
           end
           else if (step_os3_2 < 0)
           begin
              vco_ph_del_d <= t_divd_clk - (((clkos3_fphase_dyn - step_os3_2) * t_divd_clk) / (8 * clkos3_div_reg));
           end
        end
//     end
  end

  always @ (*)
  begin
   if ((load_reg_en_op === 1'b0 && last_load_reg_en_op === 1'b1) || (load_cnt_op == 1))
   begin
     if (t_diva_clk > 0)
     begin
        if ((clkop_div_reg - 1) > clkop_cphase_dyn)
        begin
           diva_ph_del <= t_diva_clk - ((((clkop_div_reg -1) - clkop_cphase_dyn) * t_diva_clk) / clkop_div_reg);
        end
        else if (clkop_cphase_dyn > (clkop_div_reg - 1))
        begin
           diva_ph_del <= (((clkop_cphase_dyn - (clkop_div_reg -1)) * t_diva_clk) / clkop_div_reg);
        end
        else
        begin
           diva_ph_del <= 0.0;
        end
     end
   end
  end

  always @ (*)
  begin
   if ((load_reg_en_os === 1'b0 && last_load_reg_en_os === 1'b1) || (load_cnt_os == 1))
   begin
     if (t_divb_clk > 0)
     begin
        if ((clkos_div_reg - 1)> clkos_cphase_dyn)
        begin
           divb_ph_del <= t_divb_clk - ((((clkos_div_reg - 1) - clkos_cphase_dyn) * t_divb_clk) / clkos_div_reg);
        end
        else if (clkos_cphase_dyn > (clkos_div_reg -1))
        begin
           divb_ph_del <= (((clkos_cphase_dyn - (clkos_div_reg - 1)) * t_divb_clk)/ clkos_div_reg);
        end
        else
        begin
           divb_ph_del <= 0.0;
        end
     end
   end
  end

  always @ (*)
  begin
   if ((load_reg_en_os2 === 1'b0 && last_load_reg_en_os2 === 1'b1) || (load_cnt_os2 == 1))
   begin
     if (t_divc_clk > 0)
     begin
        if ((clkos2_div_reg -1)> clkos2_cphase_dyn)
        begin
           divc_ph_del <= t_divc_clk - ((((clkos2_div_reg -1) - clkos2_cphase_dyn) * t_divc_clk) / clkos2_div_reg);
        end
        else if (clkos2_cphase_dyn > (clkos2_div_reg -1))
        begin
           divc_ph_del <= (((clkos2_cphase_dyn - (clkos2_div_reg -1)) * t_divc_clk) / clkos2_div_reg);
        end
        else
        begin
           divc_ph_del <= 0.0;
        end
     end
   end
  end

  always @ (*)
  begin
   if ((load_reg_en_os3 === 1'b0 && last_load_reg_en_os3 === 1'b1) || (load_cnt_os3 == 1))
   begin
     if (t_divd_clk > 0)
     begin
        if ((clkos3_div_reg -1) > clkos3_cphase_dyn)
        begin
           divd_ph_del <= t_divd_clk - ((((clkos3_div_reg -1) - clkos3_cphase_dyn) * t_divd_clk) / clkos3_div_reg);
        end
        else if (clkos3_cphase_dyn > (clkos3_div_reg -1))
        begin
           divd_ph_del <= (((clkos3_cphase_dyn - (clkos3_div_reg -1)) * t_divd_clk) / clkos3_div_reg);
        end
        else
        begin
           divd_ph_del <= 0.0;
        end
     end
   end
  end

//assign rstb_new = (mc1_pllrst_ena & rstb);
  assign rstb_old = (mc1_pllrst_ena & rstb); 
  assign rstb_new = (rstb_old | done_cfg_n);

// lock gen

always @(posedge rstb_new)
begin
   d_lock <= 1'b0;
end

always @(posedge clkib)
begin
   if (d_lock == 1'b0 && rstb_new == 1'b0)
   begin
       d_lock <= 1'b1;
   end
end
                                                                                                
always @(posedge clkib)
begin
       d1_lock <= d_lock;
end
                                                                                                
always @(posedge clkib)
begin
       d3_lock <= d1_lock;
end
                                                                                                
always @(d1_lock or d_lock)
begin
       d2_lock <= d_lock & d1_lock;
end
                                                                                                
always @(d1_lock or d_lock or d3_lock)
begin
       d4_lock <= d_lock & d1_lock & d3_lock;
end

  always @(intfb_out)
  begin
     if (out_clk_valid == 1'b0)
        vir_lock <= 1'b0;
     else if (out_clk_valid == 1'b1)
        vir_lock <= 1'b1;
  end

  always @(rstb_new or vir_lock or clock_invalid or out_clk_valid)
   begin
    if (rstb == 1)
     lock_all <= 0;
    else
    begin
     if (clock_invalid == 1)
      lock_all <= 0;
     else
      if (out_clk_valid == 1)
      lock_all <= #(pll_lock_delay * lock_delay_reg) vir_lock;
    end
   end

//
// out_clk_valid logic: is determined by the clock_valid which monitors the diference  
//                      between consecutive input clock edges. 
  always @(posedge clkib or posedge rstb_new or negedge d_lock)
  begin
     if (rstb_new == 1'b1 || d_lock == 1'b0)
        out_clk_valid <= 1'b0;
     else
        out_clk_valid <= clock_valid;
  end

  always @(out_clk_valid or intfb_out)
  begin
     if (out_clk_valid == 1'b0)
     begin
        intfb_out <= 1'b0;
        first_time7 <= 1'b1;
        index = 0.0;
     end
     else
     begin
        if (first_time7 == 1'b1)
        begin
           intfb_out <= 1'b1;
           first_time7 <= 1'b0;
           index = 0.0;
        end
        else
        begin
           index = index + 1.0;
           if (index >= net_divide)
           begin
              intfb_out <= #(ha_vco1 + round_err) ~intfb_out;
              index = 0.0;
           end
           else
              intfb_out <= #ha_vco1 ~intfb_out;
        end
     end
  end

// p11 internal feedback clockout

  always @(*)
  begin
     if (mc1_clkop_trim[2:0] != 3'b000)
     begin
        ha_clk_a_trim <= (0.07*mc1_clkop_trim[2:0]);
     end
  end

  always @(*)
  begin
     if (mc1_clkos_trim[2:0] != 3'b000)
     begin
        ha_clk_b_trim <= (0.07*mc1_clkos_trim[2:0]);
     end
  end

// no trim on clkos2
/*  
  always @(*)
  begin
     if (mem[90:88] != 3'b000)
     begin
        ha_clk_c_trim <= (0.07*mem[90:88]);
     end
  end
*/ 

// no trim on clkos3
/*
  always @(*)
  begin
     if (mem[94:92] != 3'b000)
     begin
        ha_clk_d_trim <= (0.07*mem[94:92]);
     end
  end
*/

  always @(intfb_out)
  begin
      if (mc1_sel_fbk == 4'b1110 || mc1_sel_fbk == 4'b1101 || mc1_sel_fbk == 4'b1100 || mc1_sel_fbk == 4'b1011)
         vco_clk <= intfb_out;
      else 
         vco_clk <= #real_delay1 intfb_out;
  end

  always @(vco_clk)
  begin
     vco_clk_a <= vco_clk;
  end

  always @(vco_clk)
  begin
     vco_clk_b <= vco_clk;
  end

  always @(vco_clk or vco_clk_a or vco_clk_b)
  begin
//      pha <= #vco_ph_del_a vco_clk_a;
      pha <= vco_clk_a;
      phb <= vco_clk_b;
      phc <= vco_clk;
      phd <= vco_clk;
  end

  always @(diva_out)
  begin
      diva_out_del2 <= #(vco_ph_del_a) diva_out;
  end

  always @ (*)
  begin
     if (load_reg_en_op === 1'b0 && last_load_reg_en_op === 1'b1)
     begin
        op_ph_del <= load_cnt_op * diva_ph_del;
     end
  end

  always @(diva_out_del2)
  begin
     if (load_cnt_op == 1)
     begin
        diva_out_del1 <= #(diva_ph_del) diva_out_del2;
     end
     else 
     begin
        diva_out_del1 <= #(op_ph_del) diva_out_del2;
     end
  end

  always @(divb_out)
  begin
      divb_out_del2 <= #(vco_ph_del_b) divb_out;
  end

  always @ (*)
  begin
     if (load_reg_en_os === 1'b0 && last_load_reg_en_os === 1'b1)
     begin
        os_ph_del <= load_cnt_os * divb_ph_del;
     end
  end

  always @(divb_out_del2)
  begin
     if (load_cnt_os == 1)
     begin
        divb_out_del1 <= #(divb_ph_del) divb_out_del2;
     end
     else 
     begin
        divb_out_del1 <= #(os_ph_del) divb_out_del2;
     end
  end

  always @(divc_out)
  begin
      divc_out_del2 <= #(vco_ph_del_c) divc_out;
  end

  always @ (*)
  begin
     if (load_reg_en_os2 === 1'b0 && last_load_reg_en_os2 === 1'b1)
     begin
        os2_ph_del <= load_cnt_os2 * divc_ph_del;
     end
  end

  always @(divc_out_del2)
  begin
     if (load_cnt_os2 == 1)
     begin
        divc_out_del1 <= #(divc_ph_del) divc_out_del2;
     end
     else 
     begin
        divc_out_del1 <= #(os2_ph_del) divc_out_del2;
     end
  end

  always @(divd_out)
  begin
      divd_out_del2 <= #(vco_ph_del_d) divd_out;
  end

  always @ (*)
  begin
     if (load_reg_en_os3 === 1'b0 && last_load_reg_en_os3 === 1'b1)
     begin
        os3_ph_del <= load_cnt_os3 * divd_ph_del;
     end
  end

  always @(divd_out_del2)
  begin
     if (load_cnt_os3 == 1)
     begin
        divd_out_del1 <= #(divd_ph_del) divd_out_del2;
     end
     else 
     begin
        divd_out_del1 <= #(os3_ph_del) divd_out_del2;
     end
  end

  always @(diva_out_del1)
  begin
     if (mc1_clkop_trim[3] == 1'b1)
     begin
        if (diva_out_del1 == 1'b1 && diva_out_del1_last == 1'b0)
        begin
           diva_out_del <= #(ha_clk_a_trim) diva_out_del1;
        end
        else if (diva_out_del1 == 1'b0 && diva_out_del1_last == 1'b1)
        begin
           diva_out_del <= diva_out_del1;
        end
     end
     else if (mc1_clkop_trim[3] == 1'b0)
     begin
        if (diva_out_del1 == 1'b0 && diva_out_del1_last == 1'b1)
        begin
           diva_out_del <= #(ha_clk_a_trim) diva_out_del1;
        end
        else if (diva_out_del1 == 1'b1 && diva_out_del1_last == 1'b0)
        begin
           diva_out_del <= diva_out_del1;
        end
     end
  end

  always @(divb_out_del1)
  begin
     if (mc1_clkos_trim[3] == 1'b1)
     begin
        if (divb_out_del1 == 1'b1 && divb_out_del1_last == 1'b0)
        begin
           divb_out_del <= #(ha_clk_b_trim) divb_out_del1;
        end
        else if (divb_out_del1 == 1'b0 && divb_out_del1_last == 1'b1)
        begin
           divb_out_del <= divb_out_del1;
        end
     end
     else if (mc1_clkos_trim[3] == 1'b0)
     begin
        if (divb_out_del1 == 1'b0 && divb_out_del1_last == 1'b1)
        begin
           divb_out_del <= #(ha_clk_b_trim) divb_out_del1;
        end
        else if (divb_out_del1 == 1'b1 && divb_out_del1_last == 1'b0)
        begin
           divb_out_del <= divb_out_del1;
        end
     end
  end

// no trim on clkos2
  always @(divc_out_del1)
  begin
    // if (mem[91] == 1'b1)
    // begin
    //    if (divc_out_del1 == 1'b1 && divc_out_del1_last == 1'b0)
    //    begin
    //       divc_out_del <= #(ha_clk_c_trim) divc_out_del1;
    //    end
    //    else if (divc_out_del1 == 1'b0 && divc_out_del1_last == 1'b1)
    //    begin
    //       divc_out_del <= divc_out_del1;
    //    end
    // end
    // else if (mem[91] == 1'b0)
     begin
           divc_out_del <= divc_out_del1;
     end
  end

// not trim on clkos3 
  always @(divd_out_del1)
  begin
           divd_out_del <= divd_out_del1;
  end


  //always @ (rstb_new or clkop_out or false_clk or clkos_out or clkos2_out or clkos3_out or lock_all)
  always @ (rstb_new or false_clk or out_clk_valid or clkop_out or clkos_out or clkos2_out or clkos3_out or lock_all or mc1_sel_outa or mc1_sel_outb or mc1_sel_outc or mc1_sel_outd) 
  begin
     if (clkop_first_time == 1'b1 && mc1_sel_outa == 1'b0)
     begin
        clkopreg <= false_clk;
     end
     else if (rstb_new == 1'b1)
     begin
        clkopreg <= 1'b0;
     end
     // else if (out_clk_valid == 1'b1)
     else  
     begin
        clkopreg <= clkop_out;
     end

     // CLKOS 
     if (clkop_first_time == 1'b1 && mc1_sel_outb == 1'b0)
     begin
        clkosreg <= false_clk;
     end
     else if (rstb_new == 1'b1)
     begin
        clkosreg <= 1'b0;
     end
     // else if (out_clk_valid == 1'b1)
     else 
     begin
        clkosreg <= clkos_out;
     end

     // CLKOS2
     if (clkop_first_time == 1'b1 && mc1_sel_outc == 1'b0)
     begin
        clkos2reg <= false_clk;
     end
     else if (rstb_new == 1'b1)
     begin
        clkos2reg <= 1'b0;
     end
     // else if (out_clk_valid == 1'b1)
     else 
     begin
        clkos2reg <= clkos2_out;
     end

     // CLKOK3 
     if (clkop_first_time == 1'b1 && mc1_sel_outd == 1'b0)
     begin
        clkos3reg <= false_clk;
     end
     else if (rstb_new == 1'b1)
     begin
        clkos3reg <= 1'b0;
     end
     // else if (out_clk_valid == 1'b1)
     else 
     begin
        clkos3reg <= clkos3_out;
     end

     // LOCK loop 
     if (clkop_first_time == 1'b1)
     begin
        lockreg <= 1'b0;
     end
     else if (rstb_new == 1'b1)
     begin
        lockreg <= 1'b0;
     end
     else if (out_clk_valid == 1'b1)
     begin
        lockreg <= lock_all;
     end
  end

  always@(posedge fbb) 
  begin 
     if (lockreg == 1'b1)  
        begin 
           if (delay_lockreg1 != 1'b1)  
              delay_lockreg1 = delay_lockreg1 + 1;
        end 
     else
        delay_lockreg1 = 1'b0; 
  end 

  //always@(lockreg or d4_lock)
  //begin
  //   lockreg1 <= lockreg & d4_lock;
  //end
  always@(delay_lockreg1 or d4_lock)
  begin
     lockreg1 <= delay_lockreg1 & d4_lock;
  end

  always@(*)
  begin
     if (mc1_lock_sel == 3'b010)
     begin
        if (rstb_new == 1'b1)
        begin
           lockreg2 <= lockreg1;
        end
        else
        begin 
           lockreg2 <= lockreg1 | lockreg2;
        end
     end
     else 
     begin
        lockreg2 <= lockreg1;
     end
  end

// Holding cell for STDBY and wakeup_syn states
  always @ (stdby_internal)
  begin 
       if(stdby_state == 1'b0 && mc1_intfb ==1'b1) 
          stdby_state = 1'b1;
  end     

// Handle STDBY mode; the stdby_internal = (mc1_stdby & stdby)  
  //always@(stdby_internal or pll_wakeup_sync or mc1_intfb)
  always @ (*)  
  begin
     if (stdby_internal == 1'b1 && stdby_state == 1'b0)
        begin 
          intlockreg <= 1'b0;
          lockreg3 <= 1'b0;
        end
     else if (stdby_state == 1'b1) 
        begin
             if (pll_wakeup_sync == 1'b1)
                 begin 
                    stdby_state <= 1'b0;
                    intlockreg <= 1'b0;         
                    lockreg3 <= 1'b0;  
                 end 
        end  
     else if (pll_fb_info == 2'b00 && mc1_sel_outa == 1'b1)     
        begin  
           intlockreg <= 1'b0;
           lockreg3 <= 1'b0;
        end  
     else if (pll_fb_info == 2'b01 && mc1_sel_outb == 1'b1)
        begin
           intlockreg <= 1'b0;
           lockreg3 <= 1'b0;
        end
     else if (pll_fb_info == 2'b10 && mc1_sel_outc == 1'b1)
        begin
           intlockreg <= 1'b0;
           lockreg3 <= 1'b0;
        end
     else if (pll_fb_info == 2'b11 && mc1_sel_outd == 1'b1)
        begin
           intlockreg <= 1'b0;
           lockreg3 <= 1'b0;
        end
     else 
        begin
           intlockreg <= lockreg2;
           lockreg3 <= lockreg2;
        end
  end

  //  clkopreg1 drives clkop 
  always @(clkopreg)
  begin
     if (clkop_first_time == 1'b1)
        clkopreg1 <= clkopreg;
     else if ((stdby_internal == 1'b1) && lockreg3 == 1'b0)
        clkopreg1 <= 1'b0;
     else
        clkopreg1 <= clkopreg;
  end

  always @(clkosreg)
  begin
     if (clkop_first_time == 1'b1)
        clkosreg1 <= clkosreg;
     else if ((stdby_internal == 1'b1) && lockreg3 == 1'b0)
        clkosreg1 <= 1'b0;
     else
        clkosreg1 <= clkosreg;
  end

  always @(clkos2reg)
  begin
     if (clkop_first_time == 1'b1)
        clkos2reg1 <= clkos2reg;
     else if ((stdby_internal == 1'b1) && lockreg3 == 1'b0)
        clkos2reg1 <= 1'b0;
     else
        clkos2reg1 <= clkos2reg;
  end

  always @(clkos3reg)
  begin
     if (clkop_first_time == 1'b1)
        clkos3reg1 <= clkos3reg;
     else if ((stdby_internal == 1'b1) && lockreg3 == 1'b0)
        clkos3reg1 <= 1'b0;
     else
        clkos3reg1 <= clkos3reg;
  end


endmodule
`endcelldefine
