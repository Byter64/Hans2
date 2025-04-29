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
// Simulation Library File for PRADD18A in ECP5U/M
//
// $Header:
//

`celldefine
`timescale  1 ns / 1 ps

module PRADD18A (PA17,PA16,PA15,PA14,PA13,PA12,PA11,PA10,PA9,PA8,PA7,PA6,PA5,PA4,PA3,PA2,PA1,PA0,
PB17,PB16,PB15,PB14,PB13,PB12,PB11,PB10,PB9,PB8,PB7,PB6,PB5,PB4,PB3,PB2,PB1,PB0,
SROA17,SROA16,SROA15,SROA14,SROA13,SROA12,SROA11,SROA10,SROA9,
SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0,
SROB17,SROB16,SROB15,SROB14,SROB13,SROB12,SROB11,SROB10,SROB9,
SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0,
PO17,PO16,PO15,PO14,PO13,PO12,PO11,PO10,PO9,PO8,PO7,PO6,PO5,PO4,PO3,PO2,PO1,PO0,
C17,C16,C15,C14,C13,C12,C11,C10,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0,
SRIA17,SRIA16,SRIA15,SRIA14,SRIA13,SRIA12,SRIA11,SRIA10,SRIA9,
SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0,
SRIB17,SRIB16,SRIB15,SRIB14,SRIB13,SRIB12,SRIB11,SRIB10,SRIB9,
SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0,
CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SOURCEA,OPPRE);

input PA17,PA16,PA15,PA14,PA13,PA12,PA11,PA10,PA9,PA8,PA7,PA6,PA5,PA4,PA3,PA2,PA1,PA0;
input PB17,PB16,PB15,PB14,PB13,PB12,PB11,PB10,PB9,PB8,PB7,PB6,PB5,PB4,PB3,PB2,PB1,PB0;
input C17,C16,C15,C14,C13,C12,C11,C10,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0;
input SOURCEA,OPPRE;
input CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3;
input SRIA17,SRIA16,SRIA15,SRIA14,SRIA13,SRIA12,SRIA11,SRIA10,SRIA9;
input SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0;
input SRIB17,SRIB16,SRIB15,SRIB14,SRIB13,SRIB12,SRIB11,SRIB10,SRIB9;
input SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0;
output SROA17,SROA16,SROA15,SROA14,SROA13,SROA12,SROA11,SROA10,SROA9;
output SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0;
output SROB17,SROB16,SROB15,SROB14,SROB13,SROB12,SROB11,SROB10,SROB9;
output SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0;
output PO17,PO16,PO15,PO14,PO13,PO12,PO11,PO10,PO9;
output PO8,PO7,PO6,PO5,PO4,PO3,PO2,PO1,PO0;

parameter REG_INPUTA_CLK = "NONE";
parameter REG_INPUTA_CE = "CE0";
parameter REG_INPUTA_RST = "RST0";
parameter REG_INPUTB_CLK = "NONE";
parameter REG_INPUTB_CE = "CE0";
parameter REG_INPUTB_RST = "RST0";
parameter REG_INPUTC_CLK = "NONE";
parameter REG_INPUTC_CE = "CE0";
parameter REG_INPUTC_RST = "RST0";
parameter REG_OPPRE_CLK = "NONE";
parameter REG_OPPRE_CE = "CE0";
parameter REG_OPPRE_RST = "RST0";
parameter GSR = "ENABLED";
parameter CAS_MATCH_REG = "FALSE";
parameter SOURCEA_MODE = "A_SHIFT";     // "A_SHIFT", C_SHIFT, A_C_DYNAMIC, HIGHSPEED
parameter RESETMODE = "SYNC";
parameter SOURCEB_MODE = "SHIFT";    // "SHIFT", PARALLEL, INTERNAL
parameter FB_MUX = "SHIFT";    // "SHIFT", SHIFT_BYPASS, DISABLED
parameter SYMMETRY_MODE = "DIRECT";    // "DIRECT", INTERNAL
parameter HIGHSPEED_CLK = "NONE";      // "NONE", "CLK0"....."CLK3"
parameter CLK0_DIV = "ENABLED";
parameter CLK1_DIV = "ENABLED";
parameter CLK2_DIV = "ENABLED";
parameter CLK3_DIV = "ENABLED";


supply0 GND; 
supply1 VCC; 

    wire CE0b,CE1b,CE2b,CE3b,CLK0buf,CLK1buf,CLK2buf,CLK3buf,RST0b,RST1b,RST2b,RST3b;
    reg CLK0b, CLK1b, CLK2b, CLK3b;
    reg CLK0_div2, CLK1_div2, CLK2_div2, CLK3_div2;

    wire [17:0] a_sig, b_sig, c_sig;
    reg  [17:0] a_sig_reg, b_sig_reg, a_sig_reg_async, a_sig_gen1_async, a_sig_reg_sync, a_sig_gen1_sync;
    reg  [17:0] a_sig_gen, b_sig_gen, b_sig_reg_async, b_sig_reg_sync, a_sig_gen1;
    reg  [17:0] c_sig_gen, c_sig_reg_async, c_sig_reg_sync, c_sig_reg;
    wire [17:0] a_sig_s, b_sig_s;
    reg [17:0]  a_sig_s_1, b_sig_s_1, a_sig_gen2, a_sig_gen3, a_sig_add;
    wire [17:0] po_sig;
    reg  oppre_reg, oppre_sig_async, oppre_sig_sync, oppre_gen;

    wire [17:0] sroa_reg;
    reg  [17:0] srob_reg;
    wire input_a_rst_ogsr;
    wire input_b_rst_ogsr;
    wire input_c_rst_ogsr;
    wire oppre_rst_ogsr;

    wire sourcea_sig;
    reg [17:0] c_sig_sync, c_sig_async;

    reg input_a_clk_sig,input_a_ce_sig,input_a_rst_sig;
    reg input_b_clk_sig,input_b_ce_sig,input_b_rst_sig;
    reg input_c_clk_sig,input_c_ce_sig,input_c_rst_sig;
    reg oppre_clk_sig,oppre_ce_sig,oppre_rst_sig;

    reg div2_clk2;
    reg SRN;

//    tri1 GSR_sig = GSR_INST.GSRNET;
//    tri1 PUR_sig = PUR_INST.PURNET;

tri1 GSR_sig, PUR_sig;

`ifndef mixed_hdl
   assign GSR_sig = GSR_INST.GSRNET;
   assign PUR_sig = PUR_INST.PURNET;
`else
   gsr_pur_assign gsr_pur_assign_inst (GSR_sig, PUR_sig);
`endif
 
    initial
    begin
       div2_clk2 = 0;
       input_c_clk_sig = 0;
       input_a_clk_sig = 0;
    end

    not (SR1, SRN);

    always @ (GSR_sig or PUR_sig ) 
    begin
      if (GSR == "ENABLED") 
        begin
         SRN = GSR_sig & PUR_sig ;
        end
      else if (GSR == "DISABLED")
        SRN = PUR_sig;
    end

    or INST1 (input_a_rst_ogsr, input_a_rst_sig, SR1);
    or INST2 (input_b_rst_ogsr, input_b_rst_sig, SR1);
    or INST3 (oppre_rst_ogsr, oppre_rst_sig, SR1);
    or INST5 (input_c_rst_ogsr, input_c_rst_sig, SR1);

    buf (sourcea_sig, SOURCEA);

    buf (CE0b, CE0);
    buf (CE1b, CE1);
    buf (CE2b, CE2);
    buf (CE3b, CE3);
    buf (CLK0buf, CLK0);
    buf (CLK1buf, CLK1);
    buf (CLK2buf, CLK2);
    buf (CLK3buf, CLK3);
    buf (RST0b, RST0);
    buf (RST1b, RST1);
    buf (RST2b, RST2);
    buf (RST3b, RST3);

    buf inst_A0 (a_sig[0], PA0);
    buf inst_A1 (a_sig[1], PA1);
    buf inst_A2 (a_sig[2], PA2);
    buf inst_A3 (a_sig[3], PA3);
    buf inst_A4 (a_sig[4], PA4);
    buf inst_A5 (a_sig[5], PA5);
    buf inst_A6 (a_sig[6], PA6);
    buf inst_A7 (a_sig[7], PA7);
    buf inst_A8 (a_sig[8], PA8);
    buf inst_A9 (a_sig[9], PA9);
    buf inst_A10 (a_sig[10], PA10);
    buf inst_A11 (a_sig[11], PA11);
    buf inst_A12 (a_sig[12], PA12);
    buf inst_A13 (a_sig[13], PA13);
    buf inst_A14 (a_sig[14], PA14);
    buf inst_A15 (a_sig[15], PA15);
    buf inst_A16 (a_sig[16], PA16);
    buf inst_A17 (a_sig[17], PA17);

    buf inst_B0 (b_sig[0], PB0);
    buf inst_B1 (b_sig[1], PB1);
    buf inst_B2 (b_sig[2], PB2);
    buf inst_B3 (b_sig[3], PB3);
    buf inst_B4 (b_sig[4], PB4);
    buf inst_B5 (b_sig[5], PB5);
    buf inst_B6 (b_sig[6], PB6);
    buf inst_B7 (b_sig[7], PB7);
    buf inst_B8 (b_sig[8], PB8);
    buf inst_B9 (b_sig[9], PB9);
    buf inst_B10 (b_sig[10], PB10);
    buf inst_B11 (b_sig[11], PB11);
    buf inst_B12 (b_sig[12], PB12);
    buf inst_B13 (b_sig[13], PB13);
    buf inst_B14 (b_sig[14], PB14);
    buf inst_B15 (b_sig[15], PB15);
    buf inst_B16 (b_sig[16], PB16);
    buf inst_B17 (b_sig[17], PB17);

    buf inst_C0 (c_sig[0], C0);
    buf inst_C1 (c_sig[1], C1);
    buf inst_C2 (c_sig[2], C2);
    buf inst_C3 (c_sig[3], C3);
    buf inst_C4 (c_sig[4], C4);
    buf inst_C5 (c_sig[5], C5);
    buf inst_C6 (c_sig[6], C6);
    buf inst_C7 (c_sig[7], C7);
    buf inst_C8 (c_sig[8], C8);
    buf inst_C9 (c_sig[9], C9);
    buf inst_C10 (c_sig[10], C10);
    buf inst_C11 (c_sig[11], C11);
    buf inst_C12 (c_sig[12], C12);
    buf inst_C13 (c_sig[13], C13);
    buf inst_C14 (c_sig[14], C14);
    buf inst_C15 (c_sig[15], C15);
    buf inst_C16 (c_sig[16], C16);
    buf inst_C17 (c_sig[17], C17);

    buf inst_s_A0 (a_sig_s[0], SRIA0);
    buf inst_s_A1 (a_sig_s[1], SRIA1);
    buf inst_s_A2 (a_sig_s[2], SRIA2);
    buf inst_s_A3 (a_sig_s[3], SRIA3);
    buf inst_s_A4 (a_sig_s[4], SRIA4);
    buf inst_s_A5 (a_sig_s[5], SRIA5);
    buf inst_s_A6 (a_sig_s[6], SRIA6);
    buf inst_s_A7 (a_sig_s[7], SRIA7);
    buf inst_s_A8 (a_sig_s[8], SRIA8);
    buf inst_s_A9 (a_sig_s[9], SRIA9);
    buf inst_s_A10 (a_sig_s[10], SRIA10);
    buf inst_s_A11 (a_sig_s[11], SRIA11);
    buf inst_s_A12 (a_sig_s[12], SRIA12);
    buf inst_s_A13 (a_sig_s[13], SRIA13);
    buf inst_s_A14 (a_sig_s[14], SRIA14);
    buf inst_s_A15 (a_sig_s[15], SRIA15);
    buf inst_s_A16 (a_sig_s[16], SRIA16);
    buf inst_s_A17 (a_sig_s[17], SRIA17);

    buf inst_s_B0 (b_sig_s[0], SRIB0);
    buf inst_s_B1 (b_sig_s[1], SRIB1);
    buf inst_s_B2 (b_sig_s[2], SRIB2);
    buf inst_s_B3 (b_sig_s[3], SRIB3);
    buf inst_s_B4 (b_sig_s[4], SRIB4);
    buf inst_s_B5 (b_sig_s[5], SRIB5);
    buf inst_s_B6 (b_sig_s[6], SRIB6);
    buf inst_s_B7 (b_sig_s[7], SRIB7);
    buf inst_s_B8 (b_sig_s[8], SRIB8);
    buf inst_s_B9 (b_sig_s[9], SRIB9);
    buf inst_s_B10 (b_sig_s[10], SRIB10);
    buf inst_s_B11 (b_sig_s[11], SRIB11);
    buf inst_s_B12 (b_sig_s[12], SRIB12);
    buf inst_s_B13 (b_sig_s[13], SRIB13);
    buf inst_s_B14 (b_sig_s[14], SRIB14);
    buf inst_s_B15 (b_sig_s[15], SRIB15);
    buf inst_s_B16 (b_sig_s[16], SRIB16);
    buf inst_s_B17 (b_sig_s[17], SRIB17);

    buf inst_PO0 (PO0, po_sig[0]);
    buf inst_PO1 (PO1, po_sig[1]);
    buf inst_PO2 (PO2, po_sig[2]);
    buf inst_PO3 (PO3, po_sig[3]);
    buf inst_PO4 (PO4, po_sig[4]);
    buf inst_PO5 (PO5, po_sig[5]);
    buf inst_PO6 (PO6, po_sig[6]);
    buf inst_PO7 (PO7, po_sig[7]);
    buf inst_PO8 (PO8, po_sig[8]);
    buf inst_PO9 (PO9, po_sig[9]);
    buf inst_PO10 (PO10, po_sig[10]);
    buf inst_PO11 (PO11, po_sig[11]);
    buf inst_PO12 (PO12, po_sig[12]);
    buf inst_PO13 (PO13, po_sig[13]);
    buf inst_PO14 (PO14, po_sig[14]);
    buf inst_PO15 (PO15, po_sig[15]);
    buf inst_PO16 (PO16, po_sig[16]);
    buf inst_PO17 (PO17, po_sig[17]);

    buf inst_SROA0 (SROA0, sroa_reg[0]);
    buf inst_SROA1 (SROA1, sroa_reg[1]);
    buf inst_SROA2 (SROA2, sroa_reg[2]);
    buf inst_SROA3 (SROA3, sroa_reg[3]);
    buf inst_SROA4 (SROA4, sroa_reg[4]);
    buf inst_SROA5 (SROA5, sroa_reg[5]);
    buf inst_SROA6 (SROA6, sroa_reg[6]);
    buf inst_SROA7 (SROA7, sroa_reg[7]);
    buf inst_SROA8 (SROA8, sroa_reg[8]);
    buf inst_SROA9 (SROA9, sroa_reg[9]);
    buf inst_SROA10 (SROA10, sroa_reg[10]);
    buf inst_SROA11 (SROA11, sroa_reg[11]);
    buf inst_SROA12 (SROA12, sroa_reg[12]);
    buf inst_SROA13 (SROA13, sroa_reg[13]);
    buf inst_SROA14 (SROA14, sroa_reg[14]);
    buf inst_SROA15 (SROA15, sroa_reg[15]);
    buf inst_SROA16 (SROA16, sroa_reg[16]);
    buf inst_SROA17 (SROA17, sroa_reg[17]);

    buf inst_SROB0 (SROB0, srob_reg[0]);
    buf inst_SROB1 (SROB1, srob_reg[1]);
    buf inst_SROB2 (SROB2, srob_reg[2]);
    buf inst_SROB3 (SROB3, srob_reg[3]);
    buf inst_SROB4 (SROB4, srob_reg[4]);
    buf inst_SROB5 (SROB5, srob_reg[5]);
    buf inst_SROB6 (SROB6, srob_reg[6]);
    buf inst_SROB7 (SROB7, srob_reg[7]);
    buf inst_SROB8 (SROB8, srob_reg[8]);
    buf inst_SROB9 (SROB9, srob_reg[9]);
    buf inst_SROB10 (SROB10, srob_reg[10]);
    buf inst_SROB11 (SROB11, srob_reg[11]);
    buf inst_SROB12 (SROB12, srob_reg[12]);
    buf inst_SROB13 (SROB13, srob_reg[13]);
    buf inst_SROB14 (SROB14, srob_reg[14]);
    buf inst_SROB15 (SROB15, srob_reg[15]);
    buf inst_SROB16 (SROB16, srob_reg[16]);
    buf inst_SROB17 (SROB17, srob_reg[17]);

    buf inst_OPPRE (oppre_sig, OPPRE);

    initial
    begin
       CLK0b = 0;
       CLK1b = 0;
       CLK2b = 0;
       CLK3b = 0;
       CLK0_div2 = 0;
       CLK1_div2 = 0;
       CLK2_div2 = 0;
       CLK3_div2 = 0;
    end

    always @(posedge CLK0buf)
    begin
      if (CLK0_DIV == "ENABLED")
          CLK0_div2 = ~CLK0_div2;
    end
                                                                                                       
    always @(posedge CLK1buf)
    begin
      if (CLK1_DIV == "ENABLED")
          CLK1_div2 = ~CLK1_div2;
    end
                                                                                                       
    always @(posedge CLK2buf)
    begin
      if (CLK2_DIV == "ENABLED")
          CLK2_div2 = ~CLK2_div2;
    end
                                                                                                       
    always @(posedge CLK3buf)
    begin
      if (CLK3_DIV == "ENABLED")
          CLK3_div2 = ~CLK3_div2;
    end
                                                                                                       
    always @(CLK0buf or CLK0_div2)
    begin
      if (CLK0_DIV == "ENABLED")
          CLK0b = CLK0_div2;
      else if (CLK0_DIV == "DISABLED")
          CLK0b = CLK0buf;
    end
                                                                                                       
    always @(CLK1buf or CLK1_div2)
    begin
      if (CLK1_DIV == "ENABLED")
          CLK1b = CLK1_div2;
      else if (CLK1_DIV == "DISABLED")
          CLK1b = CLK1buf;
    end
                                                                                                       
    always @(CLK2buf or CLK2_div2)
    begin
      if (CLK2_DIV == "ENABLED")
          CLK2b = CLK2_div2;
      else if (CLK2_DIV == "DISABLED")
          CLK2b = CLK2buf;
    end
                                                                                                       
    always @(CLK3buf or CLK3_div2)
    begin
      if (CLK3_DIV == "ENABLED")
          CLK3b = CLK3_div2;
      else if (CLK3_DIV == "DISABLED")
          CLK3b = CLK3buf;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTA_CLK == "CLK0")
          input_a_clk_sig = CLK0b;
      else if (REG_INPUTA_CLK == "CLK1")
          input_a_clk_sig = CLK1b;
      else if (REG_INPUTA_CLK == "CLK2")
          input_a_clk_sig = CLK2b;
      else if (REG_INPUTA_CLK == "CLK3")
          input_a_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTB_CLK == "CLK0")
          input_b_clk_sig = CLK0b;
      else if (REG_INPUTB_CLK == "CLK1")
          input_b_clk_sig = CLK1b;
      else if (REG_INPUTB_CLK == "CLK2")
          input_b_clk_sig = CLK2b;
      else if (REG_INPUTB_CLK == "CLK3")
          input_b_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTC_CLK == "CLK0")
          input_c_clk_sig = CLK0b;
      else if (REG_INPUTC_CLK == "CLK1")
          input_c_clk_sig = CLK1b;
      else if (REG_INPUTC_CLK == "CLK2")
          input_c_clk_sig = CLK2b;
      else if (REG_INPUTC_CLK == "CLK3")
          input_c_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPPRE_CLK == "CLK0")
          oppre_clk_sig = CLK0b;
      else if (REG_OPPRE_CLK == "CLK1")
          oppre_clk_sig = CLK1b;
      else if (REG_OPPRE_CLK == "CLK2")
          oppre_clk_sig = CLK2b;
      else if (REG_OPPRE_CLK == "CLK3")
          oppre_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTA_CE == "CE0")
          input_a_ce_sig = CE0b;
      else if (REG_INPUTA_CE == "CE1")
          input_a_ce_sig = CE1b;
      else if (REG_INPUTA_CE == "CE2")
          input_a_ce_sig = CE2b;
      else if (REG_INPUTA_CE == "CE3")
          input_a_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTB_CE == "CE0")
          input_b_ce_sig = CE0b;
      else if (REG_INPUTB_CE == "CE1")
          input_b_ce_sig = CE1b;
      else if (REG_INPUTB_CE == "CE2")
          input_b_ce_sig = CE2b;
      else if (REG_INPUTB_CE == "CE3")
          input_b_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTC_CE == "CE0")
          input_c_ce_sig = CE0b;
      else if (REG_INPUTC_CE == "CE1")
          input_c_ce_sig = CE1b;
      else if (REG_INPUTC_CE == "CE2")
          input_c_ce_sig = CE2b;
      else if (REG_INPUTC_CE == "CE3")
          input_c_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OPPRE_CE == "CE0")
          oppre_ce_sig = CE0b;
      else if (REG_OPPRE_CE == "CE1")
          oppre_ce_sig = CE1b;
      else if (REG_OPPRE_CE == "CE2")
          oppre_ce_sig = CE2b;
      else if (REG_OPPRE_CE == "CE3")
          oppre_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTA_RST == "RST0")
          input_a_rst_sig = RST0b;
      else if (REG_INPUTA_RST == "RST1")
          input_a_rst_sig = RST1b;
      else if (REG_INPUTA_RST == "RST2")
          input_a_rst_sig = RST2b;
      else if (REG_INPUTA_RST == "RST3")
          input_a_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTB_RST == "RST0")
          input_b_rst_sig = RST0b;
      else if (REG_INPUTB_RST == "RST1")
          input_b_rst_sig = RST1b;
      else if (REG_INPUTB_RST == "RST2")
          input_b_rst_sig = RST2b;
      else if (REG_INPUTB_RST == "RST3")
          input_b_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTC_RST == "RST0")
          input_c_rst_sig = RST0b;
      else if (REG_INPUTC_RST == "RST1")
          input_c_rst_sig = RST1b;
      else if (REG_INPUTC_RST == "RST2")
          input_c_rst_sig = RST2b;
      else if (REG_INPUTC_RST == "RST3")
          input_c_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OPPRE_RST == "RST0")
          oppre_rst_sig = RST0b;
      else if (REG_OPPRE_RST == "RST1")
          oppre_rst_sig = RST1b;
      else if (REG_OPPRE_RST == "RST2")
          oppre_rst_sig = RST2b;
      else if (REG_OPPRE_RST == "RST3")
          oppre_rst_sig = RST3b;
    end

// clock divider

    always @(CLK0buf, CLK1buf, CLK2buf, CLK3buf)
    begin
       if (HIGHSPEED_CLK == "CLK0")
       begin
          div2_clk2 <= CLK0buf;
       end
       else if (HIGHSPEED_CLK == "CLK1")
       begin
          div2_clk2 <= CLK1buf;
       end
       else if (HIGHSPEED_CLK == "CLK2")
       begin
          div2_clk2 <= CLK2buf;
       end
       else if (HIGHSPEED_CLK == "CLK3")
       begin
          div2_clk2 <= CLK3buf;
       end
       else if (HIGHSPEED_CLK == "NONE")
       begin
          div2_clk2 <= 1'b0;
       end
    end

    always @(a_sig_s or a_sig or sourcea_sig or c_sig_gen or div2_clk2)   // to reg 12/15
    begin
      if (SOURCEA_MODE == "A_SHIFT")
      begin
         if (sourcea_sig == 1'b1)
         begin
             a_sig_s_1 <= a_sig_s;
         end
         else if (sourcea_sig == 1'b0)
         begin
             a_sig_s_1 <= a_sig;
         end
      end
      else if (SOURCEA_MODE == "C_SHIFT")
      begin
         if (sourcea_sig == 1'b1)
         begin
             a_sig_s_1 <= a_sig_s;
         end
         else if (sourcea_sig == 1'b0)
         begin
             a_sig_s_1 <= c_sig_gen;
         end
      end
      else if (SOURCEA_MODE == "A_C_DYNAMIC")
      begin
         if (sourcea_sig == 1'b0)
         begin
             a_sig_s_1 <= a_sig;
         end
         else if (sourcea_sig == 1'b1)
         begin
             a_sig_s_1 <= c_sig_gen;
         end
      end
      else if (SOURCEA_MODE == "HIGHSPEED")
      begin
         if (div2_clk2 == 1'b0)
         begin
             a_sig_s_1 <= a_sig;
         end
         else if (div2_clk2 == 1'b1)
         begin
             a_sig_s_1 <= c_sig_gen;
         end
      end
   end

    always @(b_sig or a_sig_gen or b_sig_s)         // to reg 13/16
    begin
      if (SOURCEB_MODE == "SHIFT")
      begin
         b_sig_s_1 = b_sig_s;
      end
      else if (SOURCEB_MODE == "PARALLEL")
      begin
         b_sig_s_1 = b_sig;
      end
      else if (SOURCEB_MODE == "INTERNAL")
      begin
         b_sig_s_1 = a_sig_gen;
      end
    end


    always @(input_a_clk_sig or posedge input_a_rst_ogsr)
    begin
      if (input_a_rst_ogsr == 1'b1)
        begin
          a_sig_reg_async <= 0;
          a_sig_gen1_async <= 0;
        end
      else if (input_a_ce_sig == 1'b1)
        begin
          a_sig_reg_async <= a_sig_s_1;
          a_sig_gen1_async <= a_sig_gen;
        end
    end

    always @(input_a_clk_sig)
    begin
      if (input_a_rst_ogsr == 1'b1)
        begin
          a_sig_reg_sync <= 0;
          a_sig_gen1_sync <= 0;
        end
      else if (input_a_ce_sig == 1'b1)
        begin
          a_sig_reg_sync <= a_sig_s_1;
          a_sig_gen1_sync <= a_sig_gen;
        end
    end

    always @(input_b_clk_sig or posedge input_b_rst_ogsr)
    begin
      if (input_b_rst_ogsr == 1'b1)
        begin
          b_sig_reg_async <= 0;
        end
      else if (input_b_ce_sig == 1'b1)
        begin
          b_sig_reg_async <= b_sig_s_1;
        end
    end

    always @(input_b_clk_sig)
    begin
      if (input_b_rst_ogsr == 1'b1)
        begin
          b_sig_reg_sync <= 0;
        end
      else if (input_b_ce_sig == 1'b1)
        begin
          b_sig_reg_sync <= b_sig_s_1;
        end
    end

    always @(posedge input_c_clk_sig or posedge input_c_rst_ogsr)
    begin
      if (input_c_rst_ogsr == 1'b1)
        begin
          c_sig_async <= 0;
        end
      else if (input_c_ce_sig == 1'b1)
        begin
          c_sig_async <= c_sig;
        end
    end
                                                                                                                   
    always @(posedge input_c_clk_sig)
    begin
      if (input_c_rst_ogsr == 1'b1)
        begin
          c_sig_sync <= 0;
        end
      else if (input_c_ce_sig == 1'b1)
        begin
          c_sig_sync <= c_sig;
        end
    end

    always @ (SR1)
    begin
       if (SR1 == 1)
       begin
          assign a_sig_reg = 0;
          assign a_sig_gen1 = 0;
          assign b_sig_reg = 0;
          assign c_sig_reg = 0;
          assign oppre_reg = 0;
       end
       else
       begin
          deassign a_sig_reg;
          deassign a_sig_gen1;
          deassign b_sig_reg;
          deassign c_sig_reg;
          deassign oppre_reg;
       end
    end

    always @(a_sig_reg_sync or a_sig_reg_async or b_sig_reg_sync or b_sig_reg_async or a_sig_gen1_async or a_sig_gen1_sync or c_sig_sync or c_sig_async or oppre_sig_sync or oppre_sig_async)
    begin
      if (RESETMODE == "ASYNC")
      begin
         a_sig_reg <= a_sig_reg_async;
         a_sig_gen1 <= a_sig_gen1_async;
         b_sig_reg <= b_sig_reg_async;
         c_sig_reg <= c_sig_async;
         oppre_reg <= oppre_sig_async;
      end 
      else if (RESETMODE == "SYNC")
      begin
         a_sig_reg <= a_sig_reg_sync;
         a_sig_gen1 <= a_sig_gen1_sync;
         b_sig_reg <= b_sig_reg_sync;
         c_sig_reg <= c_sig_sync;
         oppre_reg <= oppre_sig_sync;
      end
    end

    always @(a_sig_reg or a_sig_s_1)
    begin
      if (REG_INPUTA_CLK == "NONE")
      begin
          a_sig_gen <= a_sig_s_1;
      end
      else
      begin
          a_sig_gen <= a_sig_reg;
      end
    end

    always @(a_sig_gen or a_sig_gen1)
    begin
      if (REG_INPUTA_CLK == "NONE")
      begin
          a_sig_gen2 = a_sig_gen;
      end
      else
      begin
          a_sig_gen2 = a_sig_gen1;
      end
    end

    always @(a_sig_gen or a_sig_gen2)
    begin
      if (CAS_MATCH_REG == "FALSE")
          a_sig_gen3 = a_sig_gen;
      else if (CAS_MATCH_REG == "TRUE")
          a_sig_gen3 = a_sig_gen2;
    end

    assign  sroa_reg = a_sig_gen3;

    always @(b_sig_reg or b_sig_s_1)
    begin
      if (REG_INPUTB_CLK == "NONE")
      begin
          b_sig_gen = b_sig_s_1;
      end
      else
      begin
          b_sig_gen = b_sig_reg;
      end
    end

    always @(a_sig_gen or b_sig_gen or b_sig_s)
    begin
      if (FB_MUX == "SHIFT")
          srob_reg = b_sig_gen;
      else if (FB_MUX == "SHIFT_BYPASS")
          srob_reg = a_sig_gen;
      else if (FB_MUX == "DISABLED")
          srob_reg = b_sig_s;
    end

    always @(c_sig_reg or c_sig)
    begin
      if (REG_INPUTC_CLK == "NONE")
      begin
          c_sig_gen = c_sig;
      end
      else
      begin
          c_sig_gen = c_sig_reg;
      end
    end
                                                                                                                   
    always @(oppre_clk_sig or posedge oppre_rst_ogsr)
    begin
      if (oppre_rst_ogsr == 1'b1)
        begin
          oppre_sig_async <= 0;
        end
      else if (oppre_ce_sig == 1'b1)
        begin
          oppre_sig_async <= oppre_sig;
        end
    end

    always @(oppre_clk_sig)
    begin
      if (oppre_rst_ogsr == 1'b1)
        begin
          oppre_sig_sync <= 0;
        end
      else if (oppre_ce_sig == 1'b1)
        begin
          oppre_sig_sync <= oppre_sig;
        end
    end

    always @(oppre_reg or oppre_sig)
    begin
      if (REG_OPPRE_CLK == "NONE")
      begin
          oppre_gen = oppre_sig;
      end
      else
      begin
          oppre_gen = oppre_reg;
      end
    end

    always @(a_sig or a_sig_gen)
    begin
      if (SYMMETRY_MODE == "DIRECT")
      begin
          a_sig_add = a_sig;
      end
      else if (SYMMETRY_MODE == "INTERNAL")
      begin
          a_sig_add = a_sig_gen;
      end
    end

    assign po_sig = oppre_gen ? (a_sig_add - b_sig_gen) : (a_sig_add + b_sig_gen);

endmodule

`endcelldefine
