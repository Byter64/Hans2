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
// Simulation Library File for PCSCLKDIV in ECP5U/M
//
// $Header: 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module PCSCLKDIV (CLKI, RST, SEL2, SEL1, SEL0, CDIV1, CDIVX);
   input CLKI, RST, SEL2, SEL1, SEL0;
   output CDIV1, CDIVX;

   parameter GSR = "DISABLED";

  reg pcs_cdivx, SRN;
  wire SR1, CLKIB, RSTB;
  reg last_CLKIB;
 wire cdiv_1;
 reg  cdiv_2 ;
 reg  cdiv_4 ;
 reg  cdiv_5 ;
 reg  cdiv_8 ;
 reg  cdiv_10;
                                                                                                       
reg cdiv_1_dis;
reg cdiv_1_dis_d;
reg [2:0] cnt_5;
  wire [2:0] SELB;

  buf  (CDIVX, pcs_cdivx);
  buf  (CDIV1, cdiv_1);
  buf  (CLKIB, CLKI);
  buf  (RSTB, RST);
  buf  (SELB[2], SEL2);
  buf  (SELB[1], SEL1);
  buf  (SELB[0], SEL0);

//reg GSR_sig, PUR_sig;
//initial
//begin
//GSR_sig = 0;
//PUR_sig = 1;
//#12
//GSR_sig = 1;
//end

tri1 GSR_sig, PUR_sig;
`ifndef mixed_hdl
   assign GSR_sig = GSR_INST.GSRNET;
   assign PUR_sig = PUR_INST.PURNET;
`else
   gsr_pur_assign gsr_pur_assign_inst (GSR_sig, PUR_sig);
`endif

  initial 
  begin
     pcs_cdivx = 0;
     cnt_5 = 0;
     cdiv_1_dis = 0;
     cdiv_1_dis_d = 0;
     cdiv_2 = 0;
     cdiv_4 = 0;
     cdiv_5 = 0;
     cdiv_8 = 0;
     cdiv_10 = 0;
  end

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end

  not (SR1, SRN);
  or INST1 (RSTB2, RSTB, SR1);

initial
begin
last_CLKIB = 1'b0;
end

always @ (CLKIB)
begin
   last_CLKIB <= CLKIB;
end

  always @ (CLKIB or RSTB2)
  begin
     if (RSTB2 == 1'b1)
     begin
        cdiv_1_dis <= 1'b1;
        cdiv_1_dis_d <= 1'b1;
        cnt_5   <= 0;
        cdiv_2  <= 0;
        cdiv_4  <= 0;
        cdiv_5  <= 0;
        cdiv_8  <= 0;
        cdiv_10 <= 0;
     end
     else
     begin
        if (CLKIB === 1'b1 && last_CLKIB === 1'b0)
        begin
           cdiv_1_dis <= 1'b0;
           cdiv_1_dis_d <= cdiv_1_dis;

           if (cdiv_1_dis == 1'b1)
           begin
              cnt_5  <= 1'b0;
           end
           else
           begin
              if (cnt_5 == 4)
              begin
                 cnt_5 <= 0;
              end
              else
              begin
                 cnt_5 <= cnt_5 + 1;
              end
           end

           if (~cdiv_1_dis)
           begin
              cdiv_2  <= ~cdiv_2;
           end

           if (~cdiv_1_dis & ~cdiv_2)
           begin
              cdiv_4  <= ~cdiv_4;
           end

           if (~cdiv_1_dis & ~cdiv_2 & ~cdiv_4)
           begin
              cdiv_8  <= ~cdiv_8;
           end

           if (cdiv_1_dis || (cnt_5 == 3))
           begin
              cdiv_5  <= 1'b0;
           end
           else if (cnt_5 == 0)
           begin
              cdiv_5  <= 1'b1;
           end

           if (cdiv_1_dis)
           begin
              cdiv_10  <= 1'b0;
           end
           else if (cnt_5 == 0)
           begin
              cdiv_10  <= ~cdiv_10;
           end
        end
     end
  end

  assign cdiv_1 = CLKIB & ~cdiv_1_dis_d;

  always @(*)
     begin
     case (SELB)
              3'b000: pcs_cdivx = 1'b0;
              3'b001: pcs_cdivx = cdiv_1;
              3'b010: pcs_cdivx = cdiv_2;
              3'b011: pcs_cdivx = cdiv_4;
              3'b100: pcs_cdivx = cdiv_5;
              3'b101: pcs_cdivx = cdiv_8;
              3'b110: pcs_cdivx = cdiv_10;
              3'b111: pcs_cdivx = 1'b0;
        endcase
       end

endmodule

`endcelldefine

