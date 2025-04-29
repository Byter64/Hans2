// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2002-2010 by Lattice Semiconductor Corporation
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
// fpga\verilog\pkg\versclibs\data\machxo2\INRDB.v 1.4 08-NOV-2011 14:15:49 IALMOHAN
//
`timescale 1 ns / 1 ps

module INRDB (input D, E, output Q);

  pulldown(E);
  pulldown(Q);
  bufif0 (Q, D, E);

endmodule

