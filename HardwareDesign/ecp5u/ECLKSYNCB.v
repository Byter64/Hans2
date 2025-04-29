// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2007 by Lattice Semiconductor Corporation
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
// Simulation Library File for ECLKSYNCB in ECP5U/M, LIFMD
//
// $Header:
//

`celldefine
`timescale  1 ns / 1 ps

module ECLKSYNCB (ECLKI, STOP, ECLKO);

input  ECLKI, STOP;
output ECLKO;

reg STOPb_reg0, STOPb_reg1, STOPb_reg2, STOPb_reg3;
wire ECLKIb, STOPb, ECLKOb;

    buf (ECLKIb, ECLKI);
    buf (STOPb, STOP);
    buf (ECLKO, ECLKOb);

reg last_ECLKIb;

initial
begin
STOPb_reg0 = 1'b0;
STOPb_reg1 = 1'b0;
STOPb_reg2 = 1'b0;
STOPb_reg3 = 1'b0;
last_ECLKIb = 1'b0;
end

always @ (ECLKIb)
begin
   last_ECLKIb <= ECLKIb;
end

    always @(ECLKIb)
    begin
       if (ECLKIb === 1'b0 && last_ECLKIb === 1'b1)
       begin
          STOPb_reg0 <= ~STOPb;
          STOPb_reg1 <= STOPb_reg0;
          STOPb_reg2 <= STOPb_reg1;
          STOPb_reg3 <= STOPb_reg2;
       end
    end

    assign ECLKOb = ECLKIb & STOPb_reg3;

endmodule

`endcelldefine

