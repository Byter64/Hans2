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
// Simulation Library File for DELAYG in ECP5U/M, LIFMD
//
// $Header: $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine
module DELAYG (A, Z);
  input A;
  output Z;
 
  parameter DEL_MODE = "USER_DEFINED";
  parameter DEL_VALUE = 0;

realtime delta, cntl_delay;
reg ZB;

initial
begin
   ZB = 0;
   cntl_delay = 0.0;
   delta = 0.025;
   cntl_delay = (DEL_VALUE) * delta;
end

  always @(*)
  begin
     if (DEL_MODE == "USER_DEFINED" )
     begin
        ZB <= #cntl_delay A;
     end
     else
     begin
        ZB <= A;
     end
  end
 
  buf (Z, ZB);

endmodule
`endcelldefine
