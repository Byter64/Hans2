// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005-2012 by Lattice Semiconductor Corporation
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
// Simulation Library File for SRAMWB in ECP5U/M
//
`timescale 1ns / 1ps

module SRAMWB (A1, B1, C1, D1, A0, B0, C0, D0,
              WDO0, WDO1, WDO2, WDO3, WADO0, WADO1, WADO2, WADO3);

input  A1, B1, C1, D1, A0, B0, C0, D0;
output WDO0, WDO1, WDO2, WDO3, WADO0, WADO1, WADO2, WADO3;

   parameter  WD0MUX = "VLO";            // "SIG", "VLO", "VHI"
   parameter  WD1MUX = "VLO";            // "SIG", "VLO", "VHI"
   parameter  WD2MUX = "VLO";            // "SIG", "VLO", "VHI"
   parameter  WD3MUX = "VLO";            // "SIG", "VLO", "VHI"
   parameter  WAD0MUX = "VLO";           // "SIG", "VLO", "VHI"
   parameter  WAD1MUX = "VLO";           // "SIG", "VLO", "VHI"
   parameter  WAD2MUX = "VLO";           // "SIG", "VLO", "VHI"
   parameter  WAD3MUX = "VLO";           // "SIG", "VLO", "VHI"

   parameter  XON = 1'b0;

   wire A1_dly, B1_dly, C1_dly, D1_dly, A0_dly, B0_dly, C0_dly, D0_dly;
   wire WDO0_sig, WDO1_sig, WDO2_sig, WDO3_sig, WADO0_sig, WADO1_sig, WADO2_sig, WADO3_sig;

   buf (A1_dly, A1);
   buf (B1_dly, B1);
   buf (C1_dly, C1);
   buf (D1_dly, D1);
   buf (A0_dly, A0);
   buf (B0_dly, B0);
   buf (C0_dly, C0);
   buf (D0_dly, D0);

//Support new pin mapping
   assign WDO0_sig = (WD0MUX == "SIG") ? C1_dly : (WD0MUX == "VHI") ? 1'b1 : 1'b0;
   assign WDO1_sig = (WD1MUX == "SIG") ? A1_dly : (WD1MUX == "VHI") ? 1'b1 : 1'b0;
   assign WDO2_sig = (WD2MUX == "SIG") ? D1_dly : (WD2MUX == "VHI") ? 1'b1 : 1'b0;
   assign WDO3_sig = (WD3MUX == "SIG") ? B1_dly : (WD3MUX == "VHI") ? 1'b1 : 1'b0;
   assign WADO0_sig = (WAD0MUX == "SIG") ? D0_dly : (WAD0MUX == "VHI") ? 1'b1 : 1'b0;
   assign WADO1_sig = (WAD1MUX == "SIG") ? B0_dly : (WAD1MUX == "VHI") ? 1'b1 : 1'b0;
   assign WADO2_sig = (WAD2MUX == "SIG") ? C0_dly : (WAD2MUX == "VHI") ? 1'b1 : 1'b0;
   assign WADO3_sig = (WAD3MUX == "SIG") ? A0_dly : (WAD3MUX == "VHI") ? 1'b1 : 1'b0;

   buf (WDO0, WDO0_sig);
   buf (WDO1, WDO1_sig);
   buf (WDO2, WDO2_sig);
   buf (WDO3, WDO3_sig);
   buf (WADO0, WADO0_sig);
   buf (WADO1, WADO1_sig);
   buf (WADO2, WADO2_sig);
   buf (WADO3, WADO3_sig);

//Support new pin mapping
   specify
      (C1 => WDO0) = (0:0:0,0:0:0);
      (A1 => WDO1) = (0:0:0,0:0:0);
      (D1 => WDO2) = (0:0:0,0:0:0);
      (B1 => WDO3) = (0:0:0,0:0:0);
      (D0 => WADO0) = (0:0:0,0:0:0);
      (B0 => WADO1) = (0:0:0,0:0:0);
      (C0 => WADO2) = (0:0:0,0:0:0);
      (A0 => WADO3) = (0:0:0,0:0:0);
   endspecify

endmodule

