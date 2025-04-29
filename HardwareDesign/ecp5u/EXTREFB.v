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
// Simulation Library File for EXTREFB in ECP5UM
//
// $Header
//
`timescale 1 ns / 1 ps


module EXTREFB (
   // EXTREF Pins
   input  REFCLKP, REFCLKN,
   output REFCLKO
   // No of ports = 2 inputs + 1 outputs = 3

   // Total no of ports = 3
  ); //synthesis syn_black_box

   // EXTREF Attr
   parameter REFCK_PWDNB = "DONTCARE"; //"DONTCARE" "0b0" "0b1"
   parameter REFCK_RTERM = "DONTCARE"; //"DONTCARE" "0b0" "0b1"
   parameter REFCK_DCBIAS_EN = "DONTCARE"; //"DONTCARE" "0b0" "0b1"
   // No of parameters = 3

   // Total no of parameters = 3

   buf (REFCLKO, REFCLKP);

endmodule

