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

module PLLREFCS (CLK0, CLK1, SEL, PLLCSOUT);
  input  CLK0, CLK1, SEL;
  output PLLCSOUT;
  reg    PLLCSOUTb;
  wire CLK0b, CLK1b, SELb;

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

      always @(CLK0b or CLK1b or SELb)
      begin
      case (SELb)
        1'b0 :  PLLCSOUTb = CLK0b;
        1'b1 :  PLLCSOUTb = CLK1b;
        default PLLCSOUTb = DataSame(CLK0b, CLK1b);
      endcase
      end

   buf  (CLK0b, CLK0);
   buf  (CLK1b, CLK1);
   buf  (SELb, SEL);
   buf  (PLLCSOUT, PLLCSOUTb);


endmodule

`endcelldefine
