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
// Simulation Library File for ODDR71B in ECP5U/M, LIFMD
//
// $Header:
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ODDR71B(D0, D1, D2, D3, D4, D5, D6, RST, ECLK, SCLK, Q);
   input D0, D1, D2, D3, D4, D5, D6, RST, ECLK, SCLK;
   output Q;

  parameter GSR = "ENABLED";

   reg Q_b;
   reg T0, T1, T2, T3, T4, T5, T6;
   reg S0, S1, S2, S3, S4, S5, S6, S7;
   reg R0, R1, R2, R3, F0, F1, F2, F3, F4, R0_reg, F0_reg;
   reg last_SCLKB, last_ECLKB;
   wire QN_sig, DATA0, DATA1, DATA2, DATA3;
   wire RSTB1, RSTB2, SCLKB, ECLKB;
   wire UPDATE0_set, UPDATE1_set, SEL, CNT_RSTN, SEL_INVEN;
   reg CNT0, CNT1, SEL_REG, ECLKB1, ECLKB2, ECLKB3;
   reg M0, M1, M2, M3, M4, M5, M6, M7, lo;
   reg SRN, RSTB, UPDATE0, UPDATE1;

tri1 GSR_sig, PUR_sig;
`ifndef mixed_hdl
   assign GSR_sig = GSR_INST.GSRNET;
   assign PUR_sig = PUR_INST.PURNET;
`else
   gsr_pur_assign gsr_pur_assign_inst (GSR_sig, PUR_sig);
`endif

   assign QN_sig = Q_b; 

   buf (Q, QN_sig);
   buf (DATA0, D0);
   buf (DATA1, D1);
   buf (DATA2, D2);
   buf (DATA3, D3);
   buf (DATA4, D4);
   buf (DATA5, D5);
   buf (DATA6, D6);
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
T1 = 0;
T2 = 0;
T3 = 0;
T4 = 0;
T5 = 0;
T6 = 0;
S0 = 0;
S1 = 0;
S2 = 0;
S3 = 0;
S4 = 0;
S5 = 0;
S6 = 0;
S7 = 0;
M0 = 0;
M1 = 0;
M2 = 0;
M3 = 0;
M4 = 0;
M5 = 0;
M6 = 0;
M7 = 0;
R0 = 0;
R0_reg = 0;
R1 = 0;
R2 = 0;
R3 = 0;
F0 = 0;
F0_reg = 0;
F1 = 0;
F2 = 0;
F3 = 0;
F4 = 0;
CNT0 = 0;
CNT1 = 0;
SEL_REG = 0;
ECLKB1 = 0;
ECLKB2 = 0;
ECLKB3 = 0;
lo = 0;
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

always @ (ECLKB, ECLKB1, ECLKB2)
begin
   ECLKB1 <= ECLKB;
   ECLKB2 <= ECLKB1;
   ECLKB3 <= ECLKB2;
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
      CNT0 <= (~CNT0 & CNT_RSTN);
      CNT1 <= ((CNT0 ^ CNT1) & CNT_RSTN);
   end
end

always @ (ECLKB or RSTB)
begin
   if (RSTB == 1'b1)
   begin
      SEL_REG <= 1'b0;
   end
   else if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
   begin
      if (SEL_INVEN == 1'b1)
      begin
         SEL_REG <= ~SEL_REG;
      end
      else if (SEL_INVEN == 1'b0)
      begin
         SEL_REG <= SEL_REG;
      end
   end
end

assign SEL = SEL_REG;
assign CNT_RSTN = ~(CNT1 & ~CNT0 & SEL_REG);
assign SEL_INVEN = ((CNT1 & CNT0 & ~SEL_REG) | (CNT1 & ~CNT0 & SEL_REG));

assign UPDATE0_set = (~CNT1 & ~CNT0 & SEL_REG) | (~CNT1 & CNT0 & ~SEL_REG);
assign UPDATE1_set = ((~CNT1 & CNT0 & SEL_REG) | (CNT1 & ~CNT0 & ~SEL_REG));

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
         if (UPDATE0_set == 1'b1)
         begin
            UPDATE0 <= 1'b1;
         end
         else if (UPDATE0_set == 1'b0)
         begin
            UPDATE0 <= 1'b0;
         end
      end
   end
end

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
         if (UPDATE1_set == 1'b1)
         begin
            UPDATE1 <= 1'b1;
         end
         else if (UPDATE1_set == 1'b0)
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
      T1 <= 1'b0;
      T2 <= 1'b0;
      T3 <= 1'b0;
      T4 <= 1'b0;
      T5 <= 1'b0;
      T6 <= 1'b0;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLKB === 1'b0)
      begin
         T0 <= DATA0;
         T1 <= DATA1;
         T2 <= DATA2;
         T3 <= DATA3;
         T4 <= DATA4;
         T5 <= DATA5;
         T6 <= DATA6;
      end
   end
end

always @ (T6 or T5 or SEL)
begin
   case (SEL)
        1'b0 :  M6 = T6;
        1'b1 :  M6 = T5;
        default M6 = DataSame(T5, T6);
   endcase
end

always @ (T4 or T3 or SEL)
begin
   case (SEL)
        1'b0 :  M4 = T4;
        1'b1 :  M4 = T3;
        default M4 = DataSame(T3, T4);
   endcase
end

always @ (T2 or T1 or SEL)
begin
   case (SEL)
        1'b0 :  M2 = T2;
        1'b1 :  M2 = T1;
        default M2 = DataSame(T1, T2);
   endcase
end

always @ (T0 or S6 or SEL)
begin
   case (SEL)
        1'b0 :  M0 = T0;
        1'b1 :  M0 = S6;
        default M0 = DataSame(S6, T0);
   endcase
end

always @ (T1 or T0 or SEL)
begin
   case (SEL)
        1'b0 :  M1 = T1;
        1'b1 :  M1 = T0;
        default M1 = DataSame(T1, T0);
   endcase
end

always @ (T3 or T2 or SEL)
begin
   case (SEL)
        1'b0 :  M3 = T3;
        1'b1 :  M3 = T2;
        default M3 = DataSame(T2, T3);
   endcase
end

always @ (T5 or T4 or SEL)
begin
   case (SEL)
        1'b0 :  M5 = T5;
        1'b1 :  M5 = T4;
        default M5 = DataSame(T4, T5);
   endcase
end

always @ (T6 or SEL)
begin
   case (SEL)
        1'b0 :  M7 = 1'b0;
        1'b1 :  M7 = T6;
        default M7 = DataSame(T6, lo);
   endcase
end

always @ (ECLKB or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      S0 <= 1'b0;
      S1 <= 1'b0;
      S2 <= 1'b0;
      S3 <= 1'b0;
      S4 <= 1'b0;
      S5 <= 1'b0;
      S6 <= 1'b0;
      S7 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (UPDATE0 == 1'b1)
         begin
            S0 <= M0;
            S1 <= M1;
            S2 <= M2;
            S3 <= M3;
            S4 <= M4;
            S5 <= M5;
            S6 <= M6;
            S7 <= M7;
         end
         else if (UPDATE0 == 1'b0)
         begin
            S0 <= S0;
            S1 <= S1;
            S2 <= S2;
            S3 <= S3;
            S4 <= S4;
            S5 <= S5;
            S6 <= S6;
            S7 <= S7;
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
      F0 <= 1'b0;
      F1 <= 1'b0;
      F2 <= 1'b0;
      F3 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (UPDATE1 == 1'b1)
         begin
            R0 <= S0;
            R1 <= S2;
            R2 <= S4;
            R3 <= S6;
            F0 <= S1;
            F1 <= S3;
            F2 <= S5;
            F3 <= S7;
         end
         else if (UPDATE1 == 1'b0)
         begin
            R0 <= R1;
            R1 <= R2;
            R2 <= R3;
            R3 <= 1'b0;
            F0 <= F1;
            F1 <= F2;
            F2 <= F3;
            F3 <= 1'b0;
         end
      end
   end
end


always @ (ECLKB or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      R0_reg <= 1'b0;
      F0_reg <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b0 && last_ECLKB === 1'b1)   // neg
      begin
         R0_reg <= R0;
      end

      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)   // pos
      begin
         F0_reg <= F0;
      end
   end
end

/*
always @ (ECLKB or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      F4 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b0 && last_ECLKB === 1'b1)
      begin
         F4 <= F0;
      end
   end
end
*/

always @ (R0_reg or F0_reg or ECLKB1)
begin
   case (ECLKB1)
        1'b0 :  Q_b = F0_reg;
        1'b1 :  Q_b = R0_reg;
        default Q_b = DataSame(R0_reg, F0_reg);
   endcase
end

endmodule

`endcelldefine
