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
// Simulation Library File for IMIPI in in ECP5U/M
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IMIPI (A, AN, HSSEL, OHSOLS1, OLS0);
  input  A, AN, HSSEL;
  output OHSOLS1, OLS0;

  buf INST1 (A_buf, A);
  buf INST2 (AN_buf, AN);
  buf INST3 (HSSEL_buf, HSSEL);

  reg OHSOLS1, OLS0;

always @(*) 
begin
   if (HSSEL_buf == 1'b1)
   begin
      OHSOLS1 <= A_buf;
      OLS0 <= 1'b0;
   end
   else 
   begin
      OHSOLS1 <= A_buf;
      OLS0 <= AN_buf;
   end
end

endmodule

`endcelldefine
