// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2002-2011 by Lattice Semiconductor Corporation
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
// Simulation Library File for DTR in ECP5U/M
//
// $Header: $
//
`timescale 1 ns / 1 ps

module DTR (input STARTPULSE, output DTROUT7,DTROUT6,DTROUT5,DTROUT4,DTROUT3,DTROUT2,DTROUT1,DTROUT0);

  parameter DTR_TEMP = 25; // decimal value of temp
  wire [5:0] dtr_out = DTR_TEMP; // 25C, dtr_valid=1
  wire dtr_out_6 = 1'b0;
  reg dtr_out_7, last_STARTPULSE;

  initial 
  begin
     dtr_out_7 = 0;
     last_STARTPULSE = 0;
  end

always @ (STARTPULSE)
begin
   last_STARTPULSE <= STARTPULSE;
end

always @ (STARTPULSE)    
begin
   if (STARTPULSE === 1'b0 && last_STARTPULSE === 1'b1)
   begin
      #70000
      dtr_out_7 <= 1'b1;
   end
end


  buf (DTROUT7, dtr_out_7);
  buf (DTROUT6, dtr_out_6);
  buf (DTROUT5, dtr_out[5]);
  buf (DTROUT4, dtr_out[4]);
  buf (DTROUT3, dtr_out[3]);
  buf (DTROUT2, dtr_out[2]);
  buf (DTROUT1, dtr_out[1]);
  buf (DTROUT0, dtr_out[0]);

endmodule

