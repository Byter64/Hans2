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
// Simulation Library File for OSCG in ECP5U/M
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OSCG (OSC);
  output OSC;
  parameter  DIV = 128;

  reg OSCb;
  realtime half_clk;

  initial
  begin
     OSCb = 1'b0;
     half_clk = 1.613;

     forever begin
        #(half_clk * DIV) OSCb = ~OSCb;
     end
  end

  buf (OSC, OSCb);

endmodule 

`endcelldefine
