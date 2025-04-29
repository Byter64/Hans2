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
// Simulation Library File for XO2
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DCCA (CLKI, CE, CLKO);
  input  CLKI, CE;
  output CLKO;
  reg    CLKOb;
  wire CLKIb, CEb;

      always @(CLKIb)
      begin
         if (CEb == 1'b1)
            CLKOb <= CLKIb;
         else
            CLKOb <= 1'b0;
      end

   buf  (CLKIb, CLKI);
   buf  (CEb, CE);
   buf  (CLKO, CLKOb);


endmodule

`endcelldefine
