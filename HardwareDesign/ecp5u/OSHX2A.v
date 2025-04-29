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
// Simulation Library File for OSHX2A in ECP5U/M
//
// $Header
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OSHX2A(D0, D1, RST, ECLK, SCLK, Q);
   input D0, D1, RST, ECLK, SCLK;
   output Q;

  parameter GSR = "ENABLED";

   reg T0, T2, T4, T6;
   reg S0, S2, S4, S6;
   reg R0, R1, R2, R3;
   reg last_SCLKB, last_ECLKB;
   wire QN_sig, DATA0, DATA2;
   wire RSTB1, RSTB2, SCLKB, ECLKB;
   reg UPDATE0, UPDATE1, CNT0, CNT1, hclkcnt0, hclkcnt1, hclkrst_rel;
   wire update0_set, update1_set, mupdate1_set ;
   reg SRN, RSTB;

tri1 GSR_sig, PUR_sig;
`ifndef mixed_hdl
   assign GSR_sig = GSR_INST.GSRNET;
   assign PUR_sig = PUR_INST.PURNET;
`else
   gsr_pur_assign gsr_pur_assign_inst (GSR_sig, PUR_sig);
`endif

   assign QN_sig = R0; 

   buf (Q, QN_sig);
   buf (DATA0, D0);
   buf (DATA2, D1);
   buf (RSTB1, RST);
   buf (SCLKB, SCLK);
   buf (ECLKB, ECLK);

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

initial
begin
T0 = 0;
T2 = 0;
T4 = 0;
T6 = 0;
S0 = 0;
S2 = 0;
S4 = 0;
S6 = 0;
R0 = 0;
R1 = 0;
R2 = 0;
R3 = 0;
UPDATE0 = 0;
UPDATE1 = 0;
hclkrst_rel = 0;
CNT0 = 0;
CNT1 = 0;
hclkcnt0 = 0;
hclkcnt1 = 0;
end

initial
begin
last_SCLKB = 1'b0;
last_ECLKB = 1'b0;
end

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED")
      SRN = GSR_sig & PUR_sig ;
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end
                                                                                               
  not (SR, SRN);
  or INST1 (RSTB2, RSTB1, SR);

always @ (ECLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      RSTB <= 1'b1;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         RSTB <= 1'b0;
      end
   end
end

always @ (SCLKB, ECLKB)
begin
   last_SCLKB <= SCLKB;
   last_ECLKB <= ECLKB;
end

always @ (ECLKB or RSTB)
begin
   if (RSTB == 1'b1)
   begin
      CNT0 <= 1'b0;
      CNT1 <= 1'b0;
   end
   else if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
   begin
      CNT0 <= ~CNT0;
      CNT1 <= (CNT0 ^ CNT1);
   end
end
                                                                                                       
//assign update0_set = (WRITE_LEVELING == "2T") ? (~CNT1 & CNT0) : ~CNT0;
assign update0_set = CNT0;

always @ (ECLKB or RSTB)     // pos edge
begin
   if (RSTB == 1'b1)
   begin
      UPDATE0 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (update0_set == 1'b1)
         begin
            UPDATE0 <= 1'b1;
         end
         else
         begin
            UPDATE0 <= 1'b0;
         end
      end
   end
end
                                                                                                       
always @ (ECLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      hclkrst_rel <= 1'b1;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         hclkrst_rel <= 1'b0;
      end
   end
end
                                                                                                       
always @ (ECLKB or hclkrst_rel)     // pos edge
begin
   if (hclkrst_rel == 1'b1)
   begin
      hclkcnt0 <= 1'b0;
      hclkcnt1 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         hclkcnt0 <= ~hclkcnt0;
         hclkcnt1 <= (hclkcnt0 ^ hclkcnt1);
      end
   end
end
                                                                                                       
assign mupdate1_set = hclkcnt0;
assign update1_set = mupdate1_set;
                                                                                                       
always @ (ECLKB or RSTB)     // pos edge
begin
   if (RSTB == 1'b1)
   begin
      UPDATE1 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (update1_set == 1'b1)
         begin
            UPDATE1 <= 1'b1;
         end
         else
         begin
            UPDATE1 <= 1'b0;
         end
      end
   end
end

always @ (SCLKB or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      T0 <= 1'b0;
      T2 <= 1'b0;
      T4 <= 1'b0;
      T6 <= 1'b0;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLKB === 1'b0)
      begin
            T0 <= DATA0;
            T2 <= DATA2;
      end
   end
end

always @ (ECLKB or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      S0 <= 1'b0;
      S2 <= 1'b0;
      S4 <= 1'b0;
      S6 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
            if (UPDATE0 == 1'b1)
            begin
               S0 <= T0;
               S2 <= T2;
            end
            else if (UPDATE0 == 1'b0)
            begin
               S0 <= S0;
               S2 <= S2;
            end
      end
   end
end

always @ (ECLKB or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      R0 <= 1'b0;
      R1 <= 1'b0;
      R2 <= 1'b0;
      R3 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
            if (UPDATE1 == 1'b1)
            begin
               R0 <= S0;
               R1 <= S2;
            end
            else if (UPDATE1 == 1'b0)
            begin
               R0 <= R1;
               R1 <= 1'b0;
            end
      end
   end
end

endmodule

`endcelldefine
