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
// Simulation Library File for DQSBUFM in ECP5U/M
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DQSBUFM(DQSI, READ1, READ0, READCLKSEL2, READCLKSEL1, READCLKSEL0, DDRDEL, 
       ECLK, SCLK, DYNDELAY7, DYNDELAY6, DYNDELAY5, DYNDELAY4, DYNDELAY3, 
       DYNDELAY2, DYNDELAY1, DYNDELAY0, 
       RST, RDLOADN, RDMOVE, RDDIRECTION, WRLOADN, WRMOVE, WRDIRECTION, PAUSE,
       DQSR90, DQSW, DQSW270, RDPNTR2, RDPNTR1, RDPNTR0, WRPNTR2, WRPNTR1, WRPNTR0, DATAVALID,
       BURSTDET, RDCFLAG, WRCFLAG);

input  DQSI, READ1, READ0, READCLKSEL2, READCLKSEL1, READCLKSEL0, DDRDEL;
input  ECLK, SCLK, DYNDELAY7, DYNDELAY6, DYNDELAY5, DYNDELAY4, DYNDELAY3;
input  DYNDELAY2, DYNDELAY1, DYNDELAY0;
input  RST, RDLOADN, RDMOVE, RDDIRECTION, WRLOADN, WRMOVE, WRDIRECTION, PAUSE;
output DQSR90, DQSW, DQSW270, RDPNTR2, RDPNTR1, RDPNTR0, WRPNTR2, WRPNTR1, WRPNTR0, DATAVALID;
output BURSTDET, RDCFLAG, WRCFLAG;

   parameter DQS_LI_DEL_ADJ = "FACTORYONLY";
   parameter DQS_LI_DEL_VAL = 0;
   parameter DQS_LO_DEL_ADJ = "FACTORYONLY";
   parameter DQS_LO_DEL_VAL = 0;
   parameter GSR = "ENABLED";
//   parameter GEARING_MODE = "X2";          // "X2", "X4"

   realtime last_sclock_edge, next_sclock_edge, last_clock_edge, next_clock_edge;
   realtime t_in_clk, t_in_clk1;
   integer cntl_ratio;
   wire DQSIB, SCLKB, READCLKSEL1B, READCLKSEL0B, RD_UPDATE_SET;
   reg read_shift_clk, last_SCLKB, last_ECLKB, last_read_shift_clk, read_q, read_post;
   reg read_pre, dqs_ena, last_dqs_clean;
   reg dqs_rise_cnt0, dqs_rise_cnt1, dqs_rise_cnt_ok; 
   reg dqs_fall_cnt0, dqs_fall_cnt1, dqs_fall_cnt_ok;
   reg dqs_1st_fall_cnt0, dqs_1st_fall_cnt1, dqs_1st_fall_cnt2; 
   reg last_DQSR90_int;
   reg clock_valid, move_half, move_stable, half_q, rd_word_q, up_valid;
   reg rd_word_q_d1;
   reg RD_UPDATE_P1;

   reg DATAVALID_int;
   reg mc1_free, CNT0, CNT1, UPDATE0, UPDATE1, RD_CNT0, RD_CNT1, RST_RELN;
   reg hclkcnt0, hclkcnt1, hclkrst_rel, last_wr_clk_buf, last_WRMOVEB, last_RDMOVEB;
   reg R_S_Q0, R_S_Q1, R_S_Q2, R_S_Q3, R_E_Q0, R_E_Q1, R_E_Q2, R_E_Q3;
   reg R_P_Q0, R_P_Q1, R_P_Q2, R_P_Q3;
   reg R_Q, RSTB3, RD_RSTN, RSTB, DQSWB;
   reg [7:0] wr_delay_reg, rd_delay_reg, wr_delay_reg_margin;
   wire [7:0] rd_cntl_reg;
   reg WRCFLAGB, RDCFLAGB, DQSW270B, DQSR90_int;
   wire [2:0] rd_ptr_set, rd_ptr_rstn;
   reg UPDATE_PULSE;

   wire dqs_clean, read_ena, set_dqs_ena, wr_clk_buf;
   reg  wr_clk;
   wire cnt_rstn_pulse, cnt_rstn, dqs_1st_fall_cnt01;
   wire dqs_1st_fall_cnt_ok, BURSTDET_int;
   wire rd_ena, rd_qq_ena;
   reg SRN, sclock_valid, wr_rst, flag_q;
   wire [7:0] DYNDELAYB;
   wire [2:0] WR_D, RDPNTRB, RD_D, RD_DD;
   reg  [2:0] WR_Q, WRPNTRB, mc1_rd_ptr, RD_Q, RD_QQ;
   realtime delta, t_90, t_s_clk, t_s_clk1, t_s_90;
   reg sel_x2, sel_x4, sel_x2_ext;
   reg wdrn, rdrn;
   realtime wr_del, rd_del, wr_del_margin, delay_90;
   wire ECLKB_gated, cnten;
   reg pause_q0, pause_q1, pause_q2, cnt_q0, cnt_q1; 
   reg first_time_rd, DQSW270B_90;
   wire RST_FIFO;
   integer init_delay;
/*
reg GSR_sig, PUR_sig;
initial 
begin
GSR_sig = 1'b1;
PUR_sig = 1'b1;
end
*/

tri1 GSR_sig, PUR_sig;
`ifndef mixed_hdl
   assign GSR_sig = GSR_INST.GSRNET;
   assign PUR_sig = PUR_INST.PURNET;
`else
   gsr_pur_assign gsr_pur_assign_inst (GSR_sig, PUR_sig);
`endif


   buf (RSTB1, RST);
   buf (DQSIB, DQSI);
   buf (SCLKB, SCLK);
   buf (ECLKB, ECLK);
   buf (READ0B, READ0);
   buf (READ1B, READ1);
   buf (READCLKSEL2B, READCLKSEL2);
   buf (READCLKSEL1B, READCLKSEL1);
   buf (READCLKSEL0B, READCLKSEL0);
   buf (DDRDELB, DDRDEL);
   buf (DYNDELAYB[7], DYNDELAY7);
   buf (DYNDELAYB[6], DYNDELAY6);
   buf (DYNDELAYB[5], DYNDELAY5);
   buf (DYNDELAYB[4], DYNDELAY4);
   buf (DYNDELAYB[3], DYNDELAY3);
   buf (DYNDELAYB[2], DYNDELAY2);
   buf (DYNDELAYB[1], DYNDELAY1);
   buf (DYNDELAYB[0], DYNDELAY0);
   buf (WRLOADNB, WRLOADN);
   buf (RDLOADNB, RDLOADN);
   buf (RDMOVEB, RDMOVE);
   buf (RDDIRECTIONB, RDDIRECTION);
   buf (WRMOVEB, WRMOVE);
   buf (WRDIRECTIONB, WRDIRECTION);
   buf (PAUSEB, PAUSE);

   buf (WRPNTR0, WRPNTRB[0]);
   buf (WRPNTR1, WRPNTRB[1]);
   buf (WRPNTR2, WRPNTRB[2]);
   buf (RDPNTR0, RDPNTRB[0]);
   buf (RDPNTR1, RDPNTRB[1]);
   buf (RDPNTR2, RDPNTRB[2]);
//   buf (DQSW, DQSWB);
//   buf (DQSW270, DQSW270B);
   buf (DQSR90, DQSR90_int);
   buf (BURSTDET, BURSTDET_int);
   buf (DATAVALID, DATAVALID_int);
   buf (RDCFLAG, RDCFLAGB);
   buf (WRCFLAG, WRCFLAGB);

   assign #0.01 DQSW = DQSWB;
   assign #0.01 DQSW270 = DQSW270B;
   
initial
begin
   first_time_rd = 1'b1;
   wdrn = 0;
   rdrn = 0;
   rd_del = 0.0;
   wr_del = 0.0;
   wr_del_margin = 0.0;
   delay_90 = 0.0;
   init_delay = 0;

   cntl_ratio = 0;
   wr_delay_reg = 8'b00000000;
   wr_delay_reg_margin = 8'b00000000;
   rd_delay_reg = 8'b00000000; 
   WRCFLAGB = 0;
   RDCFLAGB = 0;
   delta = 0.025;
   clock_valid = 0;
   sclock_valid = 0;
   WR_Q = 0;
   WRPNTRB = 0;
   last_clock_edge = 0.0;
   next_clock_edge = 0.0;
   mc1_rd_ptr = 3'b000;
   read_shift_clk = 1'b0;
   last_SCLKB = 1'b0;
   last_read_shift_clk = 1'b0;
   read_q = 1'b0;
   read_post = 1'b0;
   read_pre = 1'b0;
   dqs_ena = 1'b0;
   last_dqs_clean = 1'b0;
   dqs_rise_cnt0 = 1'b0;
   dqs_rise_cnt1 = 1'b0;
   dqs_rise_cnt_ok = 1'b0;
   dqs_fall_cnt0 = 1'b0;
   dqs_fall_cnt1 = 1'b0;
   dqs_fall_cnt_ok = 1'b0;
   dqs_1st_fall_cnt0 = 1'b0;
   dqs_1st_fall_cnt1 = 1'b0;
   dqs_1st_fall_cnt2 = 1'b0;
   last_DQSR90_int = 1'b0;
   mc1_free = 1'b0;
   sel_x2 = 1'b1;
   sel_x4 = 1'b0;
   sel_x2_ext = 1'b0;
   wr_del = (DYNDELAYB) * delta;
   DQSW270B_90 = 0;

end

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED")
      SRN = GSR_sig & PUR_sig ;
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end
                                                                                               
  not (SR, SRN);
  or INST1 (RSTB2, RSTB1, SR);
  or INST20 (RST_FIFO, RSTB2, PAUSEB);

  reg    same1, same2;
  wire [1:0] dselect;

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

// pause logic

   always @ (ECLKB or RSTB2)     // pos edge
   begin
      if (RSTB2 == 1'b1)
      begin
         pause_q0 <= 1'b0;
         pause_q1 <= 1'b0;
         pause_q2 <= 1'b0;
      end
      else
      begin
         if (ECLKB === 1'b0 && last_ECLKB === 1'b1)
         begin
            pause_q0 <= PAUSEB;
            pause_q1 <= pause_q0;
            pause_q2 <= pause_q1;
         end
      end
   end

   assign cnten = pause_q2 | cnt_q0 | cnt_q1;

always @ (ECLKB or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      cnt_q0 <= 1'b0;
      cnt_q1 <= 1'b0;
   end
   else if (ECLKB === 1'b0 && last_ECLKB === 1'b1)
   begin
      if (cnten == 1'b1)
      begin
         cnt_q0 <= ~cnt_q0;
         cnt_q1 <= (cnt_q0 ^ cnt_q1);
      end
   end
end

   assign ECLKB_gated = ~cnten & ECLKB;


   always @ (SCLKB, ECLKB, read_shift_clk, dqs_clean, DQSR90_int, wr_clk_buf, WRMOVEB, RDMOVEB)
   begin
      last_SCLKB <= SCLKB;
      last_ECLKB <= ECLKB;
      last_read_shift_clk <= read_shift_clk;
      last_dqs_clean <= dqs_clean;
      last_DQSR90_int <= DQSR90_int;
      last_wr_clk_buf <= wr_clk_buf;
      last_WRMOVEB <= WRMOVEB;
      last_RDMOVEB <= RDMOVEB;
   end

   always @(WRLOADNB, WRMOVEB)
   begin
      if (WRLOADNB == 1'b0)
      begin
         wdrn <= 1'b0;
      end
      else
      begin
         if (WRMOVEB === 1'b1 && last_WRMOVEB === 1'b0)
            wdrn <= WRDIRECTIONB;
      end
   end

   always @(RDLOADNB, RDMOVEB)
   begin
      if (RDLOADNB == 1'b0)
      begin
         rdrn <= 1'b0;
      end
      else
      begin
         if (RDMOVEB === 1'b1 && last_RDMOVEB === 1'b0)
            rdrn <= RDDIRECTIONB;
      end
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
      UPDATE0 <= 1'b0;
   end
   else if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
   begin
      CNT0 <= ~CNT0;
      UPDATE0 <= CNT0;
   end
end
                                                                                                       
always @ (wr_clk_buf or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      hclkrst_rel <= 1'b1;
   end
   else
   begin
      if (wr_clk_buf === 1'b1 && last_wr_clk_buf === 1'b0)
      begin
         hclkrst_rel <= 1'b0;
      end
   end
end
                                                                                                       
always @ (wr_clk_buf or hclkrst_rel)     // pos edge
begin
   if (hclkrst_rel == 1'b1)
   begin
      hclkcnt0 <= 1'b0;
      UPDATE1 <= 1'b0;
   end
   else
   begin
      if (wr_clk_buf === 1'b1 && last_wr_clk_buf === 1'b0)
      begin
         hclkcnt0 <= ~hclkcnt0;
         UPDATE1 <= hclkcnt0;
      end
   end
end

wire update_0n, update_1n;
assign update_0n = ~UPDATE0;
assign update_1n = ~UPDATE1;


always @ (SCLKB or RSTB2)    // posedge
begin
   if (RSTB2 == 1'b1)
   begin
      R_S_Q0 <= 1'b0;
      R_S_Q1 <= 1'b0;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLKB === 1'b0)
      begin
         R_S_Q0 <= READ0B;
         R_S_Q1 <= READ1B;
      end
   end
end

always @ (ECLKB or RSTB2)    // posedge
begin
   if (RSTB2 == 1'b1)
   begin
      R_E_Q0 <= 1'b0;
      R_E_Q1 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (update_0n == 1'b1)
         begin
            R_E_Q0 <= R_S_Q0;
            R_E_Q1 <= R_S_Q1;
         end
         else if (update_0n == 1'b0)
         begin
            R_E_Q0 <= R_E_Q0;
            R_E_Q1 <= R_E_Q1;
         end
      end
   end
end

always @ (wr_clk_buf or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      R_P_Q0 <= 1'b0;
   end
   else
   begin
      if (wr_clk_buf === 1'b1 && last_wr_clk_buf === 1'b0)
      begin
         if (UPDATE1 == 1'b1)
         begin
            R_P_Q0 <= R_E_Q0;
         end
         else if (UPDATE1 == 1'b0)
         begin
            R_P_Q0 <= R_P_Q1;
         end
      end
   end
end
         
always @ (wr_clk_buf or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      R_P_Q1 <= 1'b0;
   end
   else
   begin
      if (wr_clk_buf === 1'b1 && last_wr_clk_buf === 1'b0)
      begin
         if (update_1n == 1'b1)
         begin
            R_P_Q1 <= R_E_Q1;
         end
      end
   end
end
                                                                                              
always @ (wr_clk_buf or RSTB2)
begin
   if (RSTB2 == 1'b1)
   begin
      R_Q <= 1'b0;
   end
   else
   begin
      if (wr_clk_buf === 1'b1 && last_wr_clk_buf === 1'b0)
      begin
         R_Q <= R_P_Q0;
      end
   end
end

always @ (R_Q or R_P_Q0 or READCLKSEL2B)
begin
   case (READCLKSEL2B)
        1'b0 :  read_q = R_P_Q0;
        1'b1 :  read_q = R_Q;
        default read_q = DataSame(R_Q, R_P_Q0);
   endcase
end

    always @(DQSW270 or READCLKSEL0B, DQSW)
      begin
        case (READCLKSEL0B)
         1'b0 : wr_clk = DQSW;
         1'b1 : wr_clk = ~DQSW270;
         default begin
                 wr_clk = DataSame(DQSW,~DQSW270);
                 end
       endcase
    end

    always @(wr_clk or READCLKSEL1B)
      begin
        case (READCLKSEL1B)
         1'b0 : read_shift_clk = ~wr_clk;
         1'b1 : read_shift_clk = wr_clk;
         default begin
                 read_shift_clk = DataSame(~wr_clk,wr_clk);
                 end
       endcase
    end

   buf (wr_clk_buf, wr_clk);

   assign #0.02 read_posti_del = read_q;

always @ (read_shift_clk or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      read_post <= 1'b0;
   end
   else
   begin
      if (read_shift_clk === 1'b1 && last_read_shift_clk === 1'b0)
      begin
         read_post <= read_posti_del;
      end
   end
end

always @ (read_shift_clk or RSTB2)     // neg edge
begin
   if (RSTB2 == 1'b1)
   begin
      read_pre <= 1'b0;
   end
   else
   begin
      if (read_shift_clk === 1'b0 && last_read_shift_clk === 1'b1)
      begin
         read_pre <= read_post;
      end
   end
end

and INST2 (read_ena, read_pre, read_post);
and INST3 (set_dqs_ena, read_ena, ~RSTB2);
                                                                                                       
always @ (dqs_clean or RSTB2 or set_dqs_ena)     // neg edge
begin
   if (RSTB2 == 1'b1)
   begin
      dqs_ena <= 1'b0;
   end
   else if (set_dqs_ena == 1'b1)
   begin
      dqs_ena <= 1'b1;
   end
   else
   begin
      if (dqs_clean === 1'b0 && last_dqs_clean === 1'b1)
      begin
         dqs_ena <= read_ena;
      end
   end
end
                                                                                                       
and INST4 (dqs_clean, dqs_ena, DQSIB);

// DQSWB and DQSW270B 

   always @(DYNDELAYB, WRLOADNB, WRMOVEB, init_delay)
   begin
      if (WRLOADNB == 1'b0)
      begin
         wr_delay_reg <= DYNDELAYB;
         wr_delay_reg_margin <= init_delay;
      end
      else
      begin
         if (WRMOVEB === 1'b0 && last_WRMOVEB === 1'b1)
         begin
            if (WRLOADNB == 1'b1)
            begin
               if (wdrn == 1'b0)   // up-delay
               begin
                  if (WRCFLAGB == 1'b0 || (wr_delay_reg_margin <= 8'b00000000))
//                  if (WRCFLAGB == 1'b0 && (wr_delay_reg_margin <= 8'b11111110))
                  begin
                     wr_delay_reg_margin <= wr_delay_reg_margin + 1;
                  end
               end
               else if (wdrn == 1'b1)   // down-delay
               begin
                  if (WRCFLAGB == 1'b0 || (wr_delay_reg_margin == 8'b11111111))
//                  if (WRCFLAGB == 1'b0 && (wr_delay_reg_margin >= 8'b00000001))
                  begin
                     wr_delay_reg_margin <= wr_delay_reg_margin - 1'b1;
                  end
               end
            end
         end
      end
   end

  always @(wr_delay_reg)
  begin
      wr_del = wr_delay_reg * delta;
  end

//  always @(wr_delay_reg_margin)
//  begin
//      wr_del_margin = (wr_delay_reg_margin - init_delay)* delta;
//  end

  always @(ECLKB_gated)
  begin
//     if (DDRDELB == 1'b1)
        DQSWB <= #(wr_del) ECLKB_gated;
//     else
//        DQSWB <= ECLKB_gated;
  end

  always @(wr_delay_reg_margin)
  begin
     if ((wr_delay_reg_margin == 8'b11111111 && wdrn == 1'b0) || (wr_delay_reg_margin == 8'b00000000 && wdrn == 1'b1))
        WRCFLAGB <= 1'b1;
     else
        WRCFLAGB <= 1'b0;
  end

  always @(posedge ECLKB)
   begin
   last_clock_edge=next_clock_edge;
   next_clock_edge=$realtime;
                                                                                                       
      if (last_clock_edge > 0)
      begin
          t_in_clk <= next_clock_edge - last_clock_edge;
          t_in_clk1 <= t_in_clk;
      end
                                                                                                       
      if (t_in_clk > 0)
      begin
         if ( ((t_in_clk - t_in_clk1) < 0.0001) && ((t_in_clk - t_in_clk1) > -0.0001))
              clock_valid = 1;
         else
              clock_valid = 0;
      end

      if ((t_in_clk > 0) && (clock_valid == 1))
      begin
          t_90 = (t_in_clk / 4 );
          init_delay = t_90/delta;
      end
   end

  always @(WRLOADNB, init_delay, wr_delay_reg_margin)
  begin
     if (WRLOADNB == 1'b0)
     begin
        delay_90 <= init_delay * delta;
     end
     else
     begin
        delay_90 <= (wr_delay_reg_margin * delta); 
     end
  end

  always @(DQSWB)
  begin
     if (DDRDELB == 1'b1)
        DQSW270B <= #(delay_90) ~DQSWB;
     else
        DQSW270B <= ~DQSWB;
  end

//  always @(DQSW270B_90)
//  begin
//     if (DDRDELB == 1'b1)
//     begin
//        DQSW270B <= #(wr_del_margin) DQSW270B_90;
//        DQSW270B <= DQSW270B_90;
//     end
//     else
//     begin
//        DQSW270B <= DQSW270B_90;
//     end
//  end

///// burst-det
   assign #0.2 dqs_ena_del = ~dqs_ena;
   nand inst14 (cnt_rstn_pulse, dqs_ena_del, dqs_ena);
   and inst34 (cnt_rstn, cnt_rstn_pulse, ~RSTB);
                                                                                                                    
always @ (dqs_clean or cnt_rstn)     // pos edge
begin
   if (cnt_rstn == 1'b0)
   begin
      dqs_rise_cnt0 <= 1'b0;
      dqs_rise_cnt1 <= 1'b0;
      dqs_rise_cnt_ok <= 1'b0;
   end
   else
   begin
      if (dqs_clean === 1'b1 && last_dqs_clean === 1'b0)
      begin
         if (dqs_ena == 1'b1)
         begin
            dqs_rise_cnt0 <= ~dqs_rise_cnt0;
            dqs_rise_cnt1 <= (dqs_rise_cnt0 ^ dqs_rise_cnt1);
            dqs_rise_cnt_ok <= (dqs_rise_cnt0 & dqs_rise_cnt1);
         end
      end
   end
end
                                                                                                                    
always @ (DQSR90_int or cnt_rstn)     // neg edge
begin
   if (cnt_rstn == 1'b0)
   begin
      dqs_1st_fall_cnt0 <= 1'b0;
      dqs_1st_fall_cnt1 <= 1'b0;
      dqs_1st_fall_cnt2 <= 1'b0;
   end
   else
   begin
      if (DQSR90_int === 1'b0 && last_DQSR90_int === 1'b1)
      begin
         if (read_ena == 1'b1)
         begin
            dqs_1st_fall_cnt0 <= ~dqs_1st_fall_cnt0;
            dqs_1st_fall_cnt1 <= (dqs_1st_fall_cnt0 ^ dqs_1st_fall_cnt1);
            dqs_1st_fall_cnt2 <= (dqs_1st_fall_cnt0 & dqs_1st_fall_cnt1);
         end
      end
   end
end
                                                                                                                    
always @ (dqs_clean or cnt_rstn)     // neg edge
begin
   if (cnt_rstn == 1'b0)
   begin
      dqs_fall_cnt0 <= 1'b0;
      dqs_fall_cnt1 <= 1'b0;
      dqs_fall_cnt_ok <= 1'b0;
   end
   else
   begin
      if (dqs_clean === 1'b0 && last_dqs_clean === 1'b1)
      begin
         dqs_fall_cnt0 <= ~dqs_fall_cnt0;
         dqs_fall_cnt1 <= (dqs_fall_cnt0 ^ dqs_fall_cnt1);
         dqs_fall_cnt_ok <= (dqs_fall_cnt0 & dqs_fall_cnt1);
      end
   end
end
                                                                                                                    
   and inst15 (dqs_1st_fall_cnt01, dqs_1st_fall_cnt0, dqs_1st_fall_cnt1);
   and inst17 (BURSTDET_int, dqs_rise_cnt_ok, ~dqs_ena, dqs_fall_cnt_ok, dqs_1st_fall_cnt01, ~dqs_1st_fall_cnt2);

  always @(posedge SCLKB)
   begin
   last_sclock_edge=next_sclock_edge;
   next_sclock_edge=$realtime;
                                                                                                       
      if (last_sclock_edge > 0)
      begin
          t_s_clk <= next_sclock_edge - last_sclock_edge;
          t_s_clk1 <= t_s_clk;
      end
                                                                                                       
      if (t_s_clk > 0)
      begin
         if ( ((t_s_clk - t_s_clk1) < 0.0001) && ((t_s_clk - t_s_clk1) > -0.0001))
              sclock_valid = 1;
         else
              sclock_valid = 0;
      end
                                                                                                       
      if (t_s_clk > 0)
      begin
//         if (GEARING_MODE == "X2")
            t_s_90 = (t_s_clk / 8 );   // div by 8 because DQSI and ECLK are half of SCLK
      end

      if (t_s_90 > 0)
      begin
         cntl_ratio = (t_s_90 / delta);
      end
   end
                          
  assign rd_cntl_reg = cntl_ratio;

   always @(rd_cntl_reg, RDLOADNB, RDMOVEB, sclock_valid, DDRDELB)
   begin
      if (first_time_rd == 1'b1 && sclock_valid == 1'b1 && DDRDELB == 1'b1)
      begin
         rd_delay_reg <= rd_cntl_reg;
         first_time_rd <= 1'b0;
      end
      else if (RDLOADNB == 1'b0)
      begin
         if (DDRDELB == 1'b1)
            rd_delay_reg <= rd_cntl_reg;
         else
            rd_delay_reg <= 8'b00000000;
      end
      else
      begin
         if (RDMOVEB === 1'b0 && last_RDMOVEB === 1'b1)
         begin
            if (RDLOADNB == 1'b1)
            begin
               if (rdrn == 1'b0)   // up-delay
               begin
                  if (RDCFLAGB == 1'b0 || (rd_delay_reg == 8'b00000000))
                  begin
                     rd_delay_reg <= rd_delay_reg + 1;
                  end
               end
               else if (rdrn == 1'b1)   // down-delay
               begin
                  if (RDCFLAGB == 1'b0 || (rd_delay_reg == 8'b11111111))
                  begin
                     rd_delay_reg <= rd_delay_reg - 1'b1;
                  end
               end
            end
         end
      end
   end

  always @(rd_delay_reg)
  begin
      rd_del = rd_delay_reg * delta;
  end

  always @(dqs_clean)
  begin
     if (DDRDELB == 1'b1)
        DQSR90_int <= #(rd_del) dqs_clean;
     else
        DQSR90_int <= dqs_clean;
  end

/*
  always @(dqs_clean)
  begin
     if (DDRDELB == 1'b1 && RDCFLAGB == 1'b0 )
        DQSR90_int <= #(rd_del) dqs_clean;
     else
        DQSR90_int <= dqs_clean;
  end
*/
                                                                                                       
  always @(rd_delay_reg)
  begin
     if ((rd_delay_reg == 8'b11111111 && rdrn == 1'b0) || (rd_delay_reg == 8'b00000000 && rdrn == 1'b1))
        RDCFLAGB <= 1'b1;
     else
        RDCFLAGB <= 1'b0;
  end
                                                                                          
// data-valid generation


// pointers
// write-pointer

  always @(DQSR90_int, RST_FIFO)
  begin
     if (RST_FIFO == 1'b1)
     begin
        RSTB3 <= 1'b1;
     end
     else
     begin
        if (DQSR90_int == 1'b1 && last_DQSR90_int === 1'b0)
        begin
           RSTB3 <= RST_FIFO;
        end 
     end
  end

  always @(RSTB3, RST_FIFO, mc1_free)
  begin
     if (mc1_free == 1'b1)
        wr_rst <= RSTB3;
     else if (mc1_free == 1'b0)
        wr_rst <= RST_FIFO;
  end

  always @(DQSR90_int, wr_rst)
  begin
     if (wr_rst == 1'b1)
     begin
        WR_Q <= 3'b0;
        WRPNTRB <= 3'b0;
     end
     else
     begin
        if (DQSR90_int == 1'b1 && last_DQSR90_int === 1'b0)
        begin
           WR_Q <= WR_D;
        end

        if (DQSR90_int == 1'b0 && last_DQSR90_int === 1'b1)
        begin
           WRPNTRB <= WR_Q;
        end
     end
  end

  assign WR_D[2] = ((WR_Q[1] & ~WR_Q[0]) | (WR_Q[2] & WR_Q[0]));  
  assign WR_D[0] = ~(WR_Q[2] ^ WR_Q[1]);  
  assign WR_D[1] = ((~WR_Q[2] & WR_Q[0]) | (WR_Q[1] & ~WR_Q[0]));  


// read pointer

always @ (ECLKB or RST_FIFO)     // pos edge
begin
   if (RST_FIFO == 1'b1)
   begin
      RD_RSTN <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         RD_RSTN <= 1'b1;
      end
   end
end

assign rd_ptr_rstn =  {RD_RSTN, RD_RSTN, RD_RSTN} | mc1_rd_ptr; 
assign rd_ptr_set =  ~({RD_RSTN, RD_RSTN, RD_RSTN} | ~mc1_rd_ptr);

  always @(ECLKB, rd_ptr_rstn, rd_ptr_set)
  begin
     if (rd_ptr_rstn[0] == 1'b0)
        RD_Q[0] <= 1'b0;
     else if (rd_ptr_set[0] == 1'b1)
        RD_Q[0] <= 1'b1;
     else
     begin
        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           if (rd_ena == 1'b1)
           begin
              RD_Q[0] <= RD_D[0];
           end
        end
     end

     if (rd_ptr_rstn[1] == 1'b0)
        RD_Q[1] <= 1'b0;
     else if (rd_ptr_set[1] == 1'b1)
        RD_Q[1] <= 1'b1;
     else
     begin
        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           if (rd_ena == 1'b1)
           begin
              RD_Q[1] <= RD_D[1];
           end
        end
     end

     if (rd_ptr_rstn[2] == 1'b0)
        RD_Q[2] <= 1'b0;
     else if (rd_ptr_set[2] == 1'b1)
        RD_Q[2] <= 1'b1;
     else
     begin
        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           if (rd_ena == 1'b1)
           begin
              RD_Q[2] <= RD_D[2];
           end
        end
     end
  end

  assign RD_D[2] = ((RD_Q[1] & ~RD_Q[0]) | (RD_Q[2] & RD_Q[0]));
  assign RD_D[0] = ~(RD_Q[2] ^ RD_Q[1]);
  assign RD_D[1] = ((~RD_Q[2] & RD_Q[0]) | (RD_Q[1] & ~RD_Q[0]));

  always @(ECLKB, rd_ptr_rstn, rd_ptr_set)
  begin
     if (rd_ptr_rstn[0] == 1'b0)
     begin
        RD_QQ[0] <= 1'b0;
     end
     else if (rd_ptr_set[0] == 1'b1)
     begin
        RD_QQ[0] <= 1'b1;
     end
     else
     begin
        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           if (rd_qq_ena == 1'b1)
           begin
              RD_QQ[0] <= RD_DD[0];
           end
        end
     end

     if (rd_ptr_rstn[1] == 1'b0)
     begin
        RD_QQ[1] <= 1'b0;
     end
     else if (rd_ptr_set[1] == 1'b1)
     begin
        RD_QQ[1] <= 1'b1;
     end
     else
     begin
        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           if (rd_qq_ena == 1'b1)
           begin
              RD_QQ[1] <= RD_DD[1];
           end
        end
     end

     if (rd_ptr_rstn[2] == 1'b0)
     begin
        RD_QQ[2] <= 1'b0;
     end
     else if (rd_ptr_set[2] == 1'b1)
     begin
        RD_QQ[2] <= 1'b1;
     end
     else
     begin
        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           if (rd_qq_ena == 1'b1)
           begin
              RD_QQ[2] <= RD_DD[2];
           end
        end
     end
  end

  assign RD_DD[2] = ((RD_QQ[1] & ~RD_QQ[0]) | (RD_QQ[2] & RD_QQ[0]));
  assign RD_DD[0] = ~(RD_QQ[2] ^ RD_QQ[1]);
  assign RD_DD[1] = ((~RD_QQ[2] & RD_QQ[0]) | (RD_QQ[1] & ~RD_QQ[0]));

  assign RDPNTRB = RD_QQ;

  assign rd_ne_wr = (WR_Q[2] ^ RD_Q[2]) | (WR_Q[1] ^ RD_Q[1]) | (WR_Q[0] ^ RD_Q[0]);
  assign rdp1_ne_wr = (WR_Q[2] ^ RD_D[2]) | (WR_Q[1] ^ RD_D[1]) | (WR_Q[0] ^ RD_D[0]);
  assign move = (~mc1_free & ((rd_ne_wr & ~flag_q) | (rdp1_ne_wr & flag_q)));

  always @(ECLKB, RD_RSTN)
  begin
     if (RD_RSTN == 1'b0)
     begin
        half_q <= 1'b0;
        flag_q <= 1'b0;
     end
     else
     begin
        if (ECLKB == 1'b0 && last_ECLKB === 1'b1)
        begin
           half_q <= (move_half & ~flag_q);
        end

        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           flag_q <= (move_stable & (half_q || flag_q));
        end
     end
  end

  always @(ECLKB, RD_RSTN, move)
  begin
     if (RD_RSTN == 1'b0)
     begin
        move_half <= 1'b0;
        move_stable <= 1'b0;
     end
     else
     begin
        if (ECLKB == 1'b0)
        begin
           move_half <= move;
        end

        if (ECLKB == 1'b1)
        begin
           move_stable <= move;
        end
     end
  end

  assign rd_ena = flag_q | mc1_free;

  always @(ECLKB, RD_RSTN)
  begin
     if (RD_RSTN == 1'b0)
     begin
        rd_word_q <= 1'b0;
        rd_word_q_d1 <= 1'b0;
     end
     else
     begin
        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           if (RD_UPDATE_P1 == 1'b1)
           begin
              rd_word_q <= (move_stable & (half_q || flag_q));
           end
           rd_word_q_d1<=rd_word_q;      
        end
     end
  end

  assign rd_qq_ena = rd_word_q | mc1_free;

  always @(ECLKB, RD_RSTN)
  begin
     if (RD_RSTN == 1'b0)
     begin
        up_valid <= 1'b0;
     end
     else
     begin
        if (ECLKB == 1'b1 && last_ECLKB === 1'b0)
        begin
           if (UPDATE_PULSE == 1'b1)
           begin
              up_valid <= rd_word_q_d1;
           end
        end
     end
  end

  always @(SCLKB, RD_RSTN)
  begin
     if (RD_RSTN == 1'b0)
     begin
        DATAVALID_int <= 1'b0;
     end
     else
     begin
        if (SCLKB == 1'b1 && last_SCLKB === 1'b0)
        begin
           DATAVALID_int <= up_valid;
        end
     end
  end

always @ (ECLKB or RSTB2)     // pos edge
begin
   if (RSTB2 == 1'b1)
   begin
      RST_RELN <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         RST_RELN <= 1'b1;
      end
   end
end

always @ (ECLKB or RST_RELN)
begin
   if (RST_RELN == 1'b0)
   begin
      RD_CNT0 <= 1'b0;
      RD_CNT1 <= 1'b0;
   end
   else if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
   begin
      RD_CNT0 <= ~RD_CNT0;
      RD_CNT1 <= (RD_CNT0 ^ RD_CNT1);
   end
end
 
assign RD_UPDATE_SET = (sel_x4 == 1'b1) ? (~RD_CNT1 & RD_CNT0) : (~RD_CNT0); 

always @ (ECLKB or RST_RELN)     // pos edge
begin
   if (RST_RELN == 1'b0)
   begin
      RD_UPDATE_P1 <= 1'b0;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
      begin
         if (RD_UPDATE_SET == 1'b1)
         begin
            RD_UPDATE_P1 <= 1'b1;
         end
         else if (RD_UPDATE_SET == 1'b0)
         begin
            RD_UPDATE_P1 <= 1'b0;
         end
      end
   end
end

  always @(ECLKB, RSTB2)
  begin
     if (RSTB2 == 1'b1)
     begin
        UPDATE_PULSE <= 1'b0;
     end
     else if (ECLKB === 1'b1 && last_ECLKB === 1'b0)
     begin
        UPDATE_PULSE <= RD_UPDATE_P1;
     end
  end

endmodule

`endcelldefine


