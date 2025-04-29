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
// Simulation Library File for IDDRX2DQA in ECP5U/M
//
// $Header: 
//

`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRX2DQA(D, DQSR90, ECLK, SCLK, RST, RDPNTR2, RDPNTR1, RDPNTR0, WRPNTR2, WRPNTR1, 
       WRPNTR0, Q0, Q1, Q2, Q3, QWL);

input  D, DQSR90, ECLK, SCLK, RST;
input  RDPNTR2, RDPNTR1, RDPNTR0, WRPNTR2, WRPNTR1, WRPNTR0;
output Q0, Q1, Q2, Q3, QWL;

   parameter  GSR = "ENABLED";            // "DISABLED", "ENABLED"

wire Db, SCLKB, RSTB1, RSTB2;
reg  ALIGNWDB;
reg RSTB;
reg M6, M8, M7, M9, S6, S7, S8, S9;
reg last_SCLKB, last_ECLKB, last_DQSR90B;
reg DATA0, DATA6, DATA9, DATA8, DATA7;
reg R6, R8, R9, R7;
reg SEL, UPDATE, slip_reg0, slip_regn1, slip_state;
reg SRN, slip_async;
wire ECLKB;
wire [2:0] RDPNTR, WRPNTR;
reg [7:0] wr_pntr_dec;
reg QP0, FP0, FP1, FP2, FP3, FP4, FP5, FP6, FP7;
reg FN0, FN1, FN2, FN3, FN4, FN5, FN6, FN7, RD_POS, RD_NEG;

//tri1 GSR_sig = GSR_INST.GSRNET;
//tri1 PUR_sig = PUR_INST.PURNET;

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
buf (DQSR90B, DQSR90);
buf (RSTB1, RST);
buf (RDPNTR[2], RDPNTR2);
buf (RDPNTR[1], RDPNTR1);
buf (RDPNTR[0], RDPNTR0);
buf (WRPNTR[2], WRPNTR2);
buf (WRPNTR[1], WRPNTR1);
buf (WRPNTR[0], WRPNTR0);

buf (Q0, DATA6);
buf (Q1, DATA7);
buf (Q2, DATA8);
buf (Q3, DATA9);
buf (QWL, DATA0);

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
ALIGNWDB = 0;
QP0 = 0;
FP0 = 0;
FP1 = 0;
FP2 = 0;
FP3 = 0;
FP4 = 0;
FP5 = 0;
FP6 = 0;
FP7 = 0;
FN0 = 0;
FN1 = 0;
FN2 = 0;
FN3 = 0;
FN4 = 0;
FN5 = 0;
FN6 = 0;
FN7 = 0;
RD_POS = 0;
RD_NEG = 0;
M6 = 0;
M8 = 0;
M7 = 0;
M9 = 0;
R6 = 0;
R8 = 0;
R9 = 0;
R7 = 0;
S6 = 0;
S8 = 0;
S9 = 0;
S7 = 0;
DATA0 = 0;
DATA6 = 0;
DATA8 = 0;
DATA9 = 0;
DATA7 = 0;
UPDATE = 0;
SEL = 0;
slip_reg0 = 0;
slip_regn1 = 1'b1;
slip_state = 0;
slip_async = 0;
wr_pntr_dec = 0;
end

initial
begin
last_SCLKB = 1'b0;
last_ECLKB = 1'b0;
last_DQSR90B = 1'b0;
end

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED")
      SRN = GSR_sig & PUR_sig ;
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end
                                                                                               
  not (SR, SRN);
  or INST1 (RSTB2, RSTB1, SR);


always @ (SCLKB or ECLKB or DQSR90B)
begin
   last_SCLKB <= SCLKB;
   last_ECLKB <= ECLKB;
   last_DQSR90B <= DQSR90B;
end

always @ (SCLKB or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      DATA0 <= 1'b0;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLKB === 1'b0)
      begin
         DATA0 <= Db;
      end
   end
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
      slip_async <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         slip_async <= ALIGNWDB;
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
         slip_reg0 <= slip_async;
         slip_regn1 <= ~slip_reg0;
      end
   end
end

and INST2 (slip_rst, slip_reg0, slip_regn1);
assign slip_trig = slip_rst;
nand INST3 (cnt_en, slip_rst, slip_state);

always @ (ECLKB or RSTB)
begin
   if (RSTB == 1'b1)
   begin
      UPDATE <= 1'b1;
      slip_state <= 1'b0;
      SEL <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (slip_rst == 1'b0)
         begin
            slip_state <= slip_state;
         end
         else if (slip_rst == 1'b1)
         begin
            slip_state <= ~slip_state;
         end

         if (cnt_en == 1'b0)
         begin
            UPDATE <= UPDATE;
         end
         else if (cnt_en == 1'b1)
         begin
            UPDATE <= ~UPDATE;
         end

         if (slip_trig == 1'b0)
         begin
            SEL <= SEL;
         end
         else if (slip_trig == 1'b1)
         begin
            SEL <= ~SEL;
         end
      end
   end
end

// fifo
always @ (WRPNTR)
begin
   if (WRPNTR == 3'b000)
      wr_pntr_dec <= 8'b00000001;
   else if (WRPNTR == 3'b001)
      wr_pntr_dec <= 8'b00000010;
   else if (WRPNTR == 3'b011)
      wr_pntr_dec <= 8'b00000100;
   else if (WRPNTR == 3'b010)
      wr_pntr_dec <= 8'b00001000;
   else if (WRPNTR == 3'b110)
      wr_pntr_dec <= 8'b00010000;
   else if (WRPNTR == 3'b111)
      wr_pntr_dec <= 8'b00100000;
   else if (WRPNTR == 3'b101)
      wr_pntr_dec <= 8'b01000000;
   else if (WRPNTR == 3'b100)
      wr_pntr_dec <= 8'b10000000;
   else
      wr_pntr_dec <= 8'b00000000;
                                                                                                      
  end

always @ (DQSR90B or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      QP0 <= 1'b0;
   end
   else
   begin
      if (DQSR90B === 1'b1 && last_DQSR90B === 1'b0)
      begin
         QP0 <= Db;
      end
   end
end

always @ (DQSR90B or RSTB2)  // negedge
begin
   if (RSTB2 == 1'b1)
   begin
      FP0 <= 1'b0;
      FP1 <= 1'b0;
      FP2 <= 1'b0;
      FP3 <= 1'b0;
      FP4 <= 1'b0;
      FP5 <= 1'b0;
      FP6 <= 1'b0;
      FP7 <= 1'b0;
   end
   else
   begin
      if (DQSR90B === 1'b0 && last_DQSR90B === 1'b1)
      begin
         if (wr_pntr_dec[0] == 1'b1)
         begin
            FP0 <= QP0;
         end
         if (wr_pntr_dec[1] == 1'b1)
         begin
            FP1 <= QP0;
         end
         if (wr_pntr_dec[2] == 1'b1)
         begin
            FP2 <= QP0;
         end
         if (wr_pntr_dec[3] == 1'b1)
         begin
            FP3 <= QP0;
         end
         if (wr_pntr_dec[4] == 1'b1)
         begin
            FP4 <= QP0;
         end
         if (wr_pntr_dec[5] == 1'b1)
         begin
            FP5 <= QP0;
         end
         if (wr_pntr_dec[6] == 1'b1)
         begin
            FP6 <= QP0;
         end
         if (wr_pntr_dec[7] == 1'b1)
         begin
            FP7 <= QP0;
         end
      end
   end
end
                                                                                                      
always @ (DQSR90B or RSTB2)  // negedge
begin
   if (RSTB2 == 1'b1)
   begin
      FN0 <= 1'b0;
      FN1 <= 1'b0;
      FN2 <= 1'b0;
      FN3 <= 1'b0;
      FN4 <= 1'b0;
      FN5 <= 1'b0;
      FN6 <= 1'b0;
      FN7 <= 1'b0;
   end
   else
   begin
      if (DQSR90B === 1'b0 && last_DQSR90B === 1'b1)
      begin
         if (wr_pntr_dec[0] == 1'b1)
         begin
            FN0 <= Db;
         end
         if (wr_pntr_dec[1] == 1'b1)
         begin
            FN1 <= Db;
         end
         if (wr_pntr_dec[2] == 1'b1)
         begin
            FN2 <= Db;
         end
         if (wr_pntr_dec[3] == 1'b1)
         begin
            FN3 <= Db;
         end
         if (wr_pntr_dec[4] == 1'b1)
         begin
            FN4 <= Db;
         end
         if (wr_pntr_dec[5] == 1'b1)
         begin
            FN5 <= Db;
         end
         if (wr_pntr_dec[6] == 1'b1)
         begin
            FN6 <= Db;
         end
         if (wr_pntr_dec[7] == 1'b1)
         begin
            FN7 <= Db;
         end
      end
   end
end
                                                                                                      
always @ (RDPNTR, FP0, FP1, FP2, FP3, FP4, FP5, FP6, FP7, FN0, FN1, FN2, FN3, FN4, FN5, FN6, FN7)
begin
   if (RDPNTR == 3'b000)
   begin
      RD_POS <= FP0;
      RD_NEG <= FN0;
   end
   else if (RDPNTR == 3'b001)
   begin
      RD_POS <= FP1;
      RD_NEG <= FN1;
   end
   else if (RDPNTR == 3'b011)
   begin
      RD_POS <= FP2;
      RD_NEG <= FN2;
   end
   else if (RDPNTR == 3'b010)
   begin
      RD_POS <= FP3;
      RD_NEG <= FN3;
   end
   else if (RDPNTR == 3'b110)
   begin
      RD_POS <= FP4;
      RD_NEG <= FN4;
   end
   else if (RDPNTR == 3'b111)
   begin
      RD_POS <= FP5;
      RD_NEG <= FN5;
   end
   else if (RDPNTR == 3'b101)
   begin
      RD_POS <= FP6;
      RD_NEG <= FN6;
   end
   else if (RDPNTR == 3'b100)
   begin
      RD_POS <= FP7;
      RD_NEG <= FN7;
   end
   else
   begin
      RD_POS <= FP0;
      RD_NEG <= FN0;
   end                                                                                                       
  end

always @ (ECLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      R6 <= 1'b0;
      R8 <= 1'b0;
      R9 <= 1'b0;
      R7 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         R8 <= RD_POS;
         R6 <= R8;
         R9 <= RD_NEG;
         R7 <= R9;
      end
   end
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

always @ (R8 or R7 or SEL)
begin
   case (SEL)
        1'b0 :  M7 = R7;
        1'b1 :  M7 = R8;
        default M7 = DataSame(R8, R7);
   endcase
end

always @ (RD_POS or R9 or SEL)
begin
   case (SEL)
        1'b0 :  M9 = R9;
        1'b1 :  M9 = RD_POS;
        default M9 = DataSame(RD_POS, R9);
   endcase
end

always @ (ECLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      S6 <= 1'b0;
      S8 <= 1'b0;
      S9 <= 1'b0;
      S7 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (UPDATE == 1'b1)
         begin
            S6 <= M6;
            S8 <= M8;
            S9 <= M9;
            S7 <= M7;
         end
      end
   end
end

always @ (SCLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      DATA6 <= 1'b0;
      DATA8 <= 1'b0;
      DATA9 <= 1'b0;
      DATA7 <= 1'b0;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLKB === 1'b0)
      begin
         DATA6 <= S6;
         DATA8 <= S8;
         DATA9 <= S9;
         DATA7 <= S7;
      end
   end
end

endmodule

`endcelldefine
