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
// Simulation Library File for IDDR71B in ECP5U/M, LIFMD
//
// $Header: 
//

`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDR71B(D, ECLK, SCLK, RST, ALIGNWD, Q0, Q1, Q2, Q3, Q4, Q5, Q6);

input  D, ECLK, SCLK, RST, ALIGNWD;
output Q0, Q1, Q2, Q3, Q4, Q5, Q6;

  parameter GSR = "ENABLED";

wire Db, SCLKB, ECLKB, RSTB2, ALIGNWDB;
reg RSTB;
reg QP, QN;
reg M4, M6, M8, M9, M7, M5, M3, S3, S4, S5, S6, S7, S8, S9;

reg last_SCLKB, last_ECLKB;
reg DATA3, DATA4, DATA5, DATA6, DATA7, DATA8, DATA9;
reg R2, R4, R6, R8, R9, R7, R5, R3;
wire SEL, UPDATE_set, slip_rst, cnt_en, CNT_RSTN, SEL_INVEN;
reg slip_reg0, slip_regn1, CNT0, CNT1, SEL_REG;
reg SRN;
reg UPDATE;

tri1 GSR_sig, PUR_sig;
`ifndef mixed_hdl
   assign GSR_sig = GSR_INST.GSRNET;
   assign PUR_sig = PUR_INST.PURNET;
`else
   gsr_pur_assign gsr_pur_assign_inst (GSR_sig, PUR_sig);
`endif
 
buf (Db, D);
buf (SCLKB, SCLK);
buf (ECLKB, ECLK);
buf (RSTB1, RST);
buf (ALIGNWDB, ALIGNWD);

buf (Q0, DATA3);
buf (Q1, DATA4);
buf (Q2, DATA5);
buf (Q3, DATA6);
buf (Q4, DATA7);
buf (Q5, DATA8);
buf (Q6, DATA9);

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
QP = 0;
QN = 0;
S4 = 0;
S6 = 0;
S8 = 0;
S9 = 0;
S7 = 0;
S5 = 0;
S3 = 0;
M3 = 0;
M4 = 0;
M5 = 0;
M6 = 0;
M7 = 0;
M8 = 0;
M9 = 0;
R2 = 0;
R4 = 0;
R6 = 0;
R8 = 0;
R9 = 0;
R7 = 0;
R5 = 0;
R3 = 0;
DATA9 = 0;
DATA4 = 0;
DATA6 = 0;
DATA8 = 0;
DATA7 = 0;
DATA5 = 0;
DATA3 = 0;
CNT0 = 0;
CNT1 = 0;
SEL_REG = 0;
slip_reg0 = 0;
slip_regn1 = 1'b1;
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


always @ (SCLKB or ECLKB)
begin
   last_SCLKB <= SCLKB;
   last_ECLKB <= ECLKB;
end

// UPDATE and SEL signal generation
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
                                                                                   
always @ (ECLKB or RSTB)     // pos edge
begin
   if (RSTB == 1'b1)
   begin
      slip_reg0 <= 1'b0;
      slip_regn1 <= 1'b1;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         slip_reg0 <= ALIGNWDB;
         slip_regn1 <= ~slip_reg0;
      end
   end
end

and INST2 (slip_rst, slip_reg0, slip_regn1);
assign cnt_en = ~slip_rst;
assign CNT_RSTN = ~(CNT1 & ~CNT0 & SEL_REG);
assign SEL_INVEN = ((CNT1 & CNT0 & ~SEL_REG) | ((CNT1 & ~CNT0 & SEL_REG) & ~slip_rst));
assign UPDATE_set = ((~CNT1 & ~CNT0 & SEL_REG) | (~CNT1 & CNT0 & ~SEL_REG));
assign SEL = SEL_REG;

always @ (ECLKB or RSTB)     // pos edge
begin
   if (RSTB == 1'b1)
   begin
      UPDATE <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (UPDATE_set == 1'b1)
         begin
            UPDATE <= 1'b1;
         end
         else if (UPDATE_set == 1'b0)
         begin
            UPDATE <= 1'b0;
         end
      end
   end
end

always @ (ECLKB or RSTB)
begin
   if (RSTB == 1'b1)
   begin
      CNT0 <= 1'b0;
      CNT1 <= 1'b0;
      SEL_REG <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (cnt_en == 1'b0)
         begin
            CNT0 <= CNT0;
         end
         else if (cnt_en == 1'b1)
         begin
            CNT0 <= (CNT_RSTN & ~CNT0);
         end
                                                                                   
         if (cnt_en == 1'b0)
         begin
            CNT1 <= CNT1;
         end
         else if (cnt_en == 1'b1)
         begin
            CNT1 <= ((CNT0 ^ CNT1) & CNT_RSTN);
         end
                                                                                   
         if (SEL_INVEN == 1'b0)
         begin
            SEL_REG <= SEL_REG;
         end
         else if (SEL_INVEN == 1'b1)
         begin
            SEL_REG <= ~SEL_REG;
         end
      end
   end
end

always @ (ECLKB or RSTB2)     //  edge
begin
   if (RSTB2 == 1'b1)
   begin
      QP <= 1'b0;
      QN <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         QP <= Db;
      end
      if (ECLKB === 1'b0 && last_ECLKB === 1'b1)
      begin
         QN <= Db;
      end
   end
end

always @ (ECLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      R2 <= 1'b0;
      R4 <= 1'b0;
      R6 <= 1'b0;
      R8 <= 1'b0;
      R9 <= 1'b0;
      R7 <= 1'b0;
      R5 <= 1'b0;
      R3 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         R2 <= R4;
         R4 <= R6;
         R6 <= R8;
         R8 <= QP;
         R9 <= QN;
         R7 <= R9;
         R5 <= R7;
         R3 <= R5;
      end
   end
end

always @ (R4 or R5 or SEL)
begin
   case (SEL)
        1'b0 :  M4 = R4;
        1'b1 :  M4 = R5;
        default M4 = DataSame(R5, R4);
   endcase
end

always @ (R6 or R7 or SEL)
begin
   case (SEL)
        1'b0 :  M6 = R6;
        1'b1 :  M6 = R7;
        default M6 = DataSame(R7, R6);
   endcase
end

always @ (R8 or R9 or SEL)
begin
   case (SEL)
        1'b0 :  M8 = R8;
        1'b1 :  M8 = R9;
        default M8 = DataSame(R9, R8);
   endcase
end

always @ (R9 or QP or SEL)
begin
   case (SEL)
        1'b0 :  M9 = R9;
        1'b1 :  M9 = QP;
        default M9 = DataSame(QP, R9);
   endcase
end

always @ (R7 or R8 or SEL)
begin
   case (SEL)
        1'b0 :  M7 = R7;
        1'b1 :  M7 = R8;
        default M7 = DataSame(R8, R7);
   endcase
end
                                                                                                      
always @ (R5 or R6 or SEL)
begin
   case (SEL)
        1'b0 :  M5 = R5;
        1'b1 :  M5 = R6;
        default M5 = DataSame(R6, R5);
   endcase
end
                                                                                                      
always @ (R3 or R4 or SEL)
begin
   case (SEL)
        1'b0 :  M3 = R3;
        1'b1 :  M3 = R4;
        default M3 = DataSame(R4, R3);
   endcase
end

always @ (ECLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      S4 <= 1'b0;
      S6 <= 1'b0;
      S8 <= 1'b0;
      S9 <= 1'b0;
      S7 <= 1'b0;
      S5 <= 1'b0;
      S3 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (UPDATE == 1'b1)
         begin
            S4 <= M4;
            S6 <= M6;
            S8 <= M8;
            S9 <= M9;
            S7 <= M7;
            S5 <= M5;
            S3 <= M3;
         end
      end
   end
end

always @ (SCLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      DATA4 <= 1'b0;
      DATA6 <= 1'b0;
      DATA8 <= 1'b0;
      DATA9 <= 1'b0;
      DATA7 <= 1'b0;
      DATA5 <= 1'b0;
      DATA3 <= 1'b0;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLKB === 1'b0)
      begin
         DATA4 <= S4;
         DATA6 <= S6;
         DATA8 <= S8;
         DATA9 <= S9;
         DATA7 <= S7;
         DATA5 <= S5;
         DATA3 <= S3;
      end
   end
end

endmodule

`endcelldefine
