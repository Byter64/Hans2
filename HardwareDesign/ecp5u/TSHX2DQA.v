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
// Simulation Library File for TSHX2DQA in ECP5U/M
//
// $Header
//

`resetall
`timescale 1 ns / 1 ps

`celldefine

module TSHX2DQA(T0, T1, SCLK, ECLK, DQSW270, RST, Q);

input  T0, T1, SCLK, ECLK, DQSW270, RST;
output Q;

   parameter  GSR = "ENABLED";            // "DISABLED", "ENABLED"
   parameter  REGSET = "SET";             // "SET", "RESET"

wire T0B, T1B, SCLKB, ECLKB, DQSW90B;

reg R0, IP, T0_reg, T1_reg, S1, S0, R1;
reg last_SCLKB, last_DQSW90B, last_ECLKB;
reg SRN, UPDATE0, UPDATE1;
wire update0_set ;
reg CNT0, CNT1, RSTB, hclkcnt0, hclkcnt1, hclkrst_rel; 
reg reset_val;

buf (T0B, T0);
buf (T1B, T1);
buf (SCLKB, SCLK);
buf (ECLKB, ECLK);
buf (DQSW90B, ~DQSW270);
buf (RSTB1, RST);

buf (Q, IP);

tri1 GSR_sig, PUR_sig;
`ifndef mixed_hdl
   assign GSR_sig = GSR_INST.GSRNET;
   assign PUR_sig = PUR_INST.PURNET;
`else
   gsr_pur_assign gsr_pur_assign_inst (GSR_sig, PUR_sig);
`endif

initial
begin
T0_reg = 0;
T1_reg = 0;
IP = 0;
S1 = 0;
S0 = 0;
R1 = 0;
R0 = 0;
CNT0 = 0;
CNT1 = 0;
RSTB = 0;
hclkrst_rel = 0;
hclkcnt0 = 0;
hclkcnt1 = 0;
  if (REGSET == "SET")
  begin
     reset_val = 1'b1;
  end
  else
  begin
     reset_val = 1'b0;
  end
end

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED")
      SRN = GSR_sig & PUR_sig ;
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end
                                                                                                      
  not (SR, SRN);
  or INST1 (RSTB2, RSTB1, SR);

initial
begin
last_SCLKB = 1'b0;
last_ECLKB = 1'b0;
last_DQSW90B = 1'b0;
end

always @ (SCLKB, DQSW90B, ECLKB)
begin
   last_SCLKB <= SCLKB;
   last_ECLKB <= ECLKB;
   last_DQSW90B <= DQSW90B;
end

// update0 and update1 gen

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

always @ (DQSW90B or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      hclkrst_rel <= 1'b1;
   end
   else
   begin
      if (DQSW90B === 1'b1 && last_DQSW90B === 1'b0)
      begin
         hclkrst_rel <= 1'b0;
      end
   end
end

always @ (DQSW90B or hclkrst_rel)     // pos edge
begin
   if (hclkrst_rel == 1'b1)
   begin
      hclkcnt0 <= 1'b0;
   end
   else
   begin
      if (DQSW90B === 1'b1 && last_DQSW90B === 1'b0)
      begin
         hclkcnt0 <= ~hclkcnt0;
      end
   end
end

always @ (DQSW90B or RSTB)     // pos edge
begin
   if (RSTB == 1'b1)
   begin
      UPDATE1 <= 1'b0;
   end
   else
   begin
      if (DQSW90B === 1'b1 && last_DQSW90B === 1'b0)
      begin
         UPDATE1 <= hclkcnt0;
      end
   end
end

always @ (SCLKB or RSTB2)     // pos_neg edge
begin
   if (RSTB2 == 1'b1)
   begin
      T0_reg <= reset_val;
      T1_reg <= reset_val;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLKB === 1'b0)
      begin
            T0_reg <= T0B;
            T1_reg <= T1B;
      end
   end
end

always @ (ECLKB or RSTB2)     // pos_neg edge
begin
   if (RSTB2 == 1'b1)
   begin
      S0 <= reset_val;
      S1 <= reset_val;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
            if (UPDATE0 == 1'b1)
            begin
               S0 <= T0_reg;
               S1 <= T1_reg;
            end
            else if (UPDATE0 == 1'b0)
            begin
               S0 <= S0;
               S1 <= S1;
            end
      end
   end
end

always @ (DQSW90B or RSTB2)     //  edge
begin
   if (RSTB2 == 1'b1)
   begin
      R1 <= reset_val;
   end
   else
   begin
      if (DQSW90B === 1'b1 && last_DQSW90B === 1'b0)
      begin
         R1 <= S1;
      end
   end
end

always @ (DQSW90B or RSTB2)     //  edge
begin
   if (RSTB2 == 1'b1)
   begin
      R0 <= reset_val;
   end
   else
   begin
      if (DQSW90B === 1'b1 && last_DQSW90B === 1'b0)
      begin
         if (UPDATE1 == 1'b1)
         begin
            R0 <= S0;
         end
         else if (UPDATE1 == 1'b0)
         begin
            R0 <= R1;
         end
      end
   end
end

always @ (DQSW90B or RSTB2)     //  edge
begin
   if (RSTB2 == 1'b1)
   begin
      IP <= reset_val;
   end
   else
   begin
      if (DQSW90B === 1'b1 && last_DQSW90B === 1'b0)     // pos
      begin
         IP <= R0;
      end
   end
end

endmodule

`endcelldefine
