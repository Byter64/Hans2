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
// Simulation Library File for DLLDELD in ECP5U/M, LIFMD
//
// $Header: 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DLLDELD (A, DDRDEL, LOADN, MOVE, DIRECTION, CFLAG, Z);

input A, DDRDEL, LOADN, MOVE, DIRECTION;
output CFLAG, Z;

localparam PHASE_SHIFT = 90;

wire CLKIB, DDRDELB, LOADNB, MOVEB, DIRECTIONB;
reg drn, CLKOB, CFLAGB, last_MOVEB, clock_valid;
wire [7:0] cntl_reg;
reg  [7:0] cntl_reg_load;
realtime delta, cntl_delay;
realtime next_clock_edge, last_clock_edge;
realtime t_in_clk, t_in_clk1, t_in_clk2;
realtime t_90, t_45, t_57, t_68, t_79;
realtime t_101, t_112, t_123, t_135;
integer cntl_ratio;
reg first_time;

   buf (CLKIB, A);
   buf (DDRDELB, DDRDEL);
   buf (LOADNB, LOADN);
   buf (MOVEB, MOVE);
   buf (DIRECTIONB, DIRECTION);
   buf (Z, CLKOB);
   buf (CFLAG, CFLAGB);

initial
begin
   cntl_delay = 0.0;
   cntl_reg_load = 8'b00000000;
   cntl_ratio = 0;
   delta = 0.025;
   clock_valid = 1'b0;
   CFLAGB = 0;
   drn = 0;
   first_time = 1'b1;
end

initial 
begin
   CFLAGB = 0;
end

   always @ (MOVEB)
   begin
      last_MOVEB <= MOVEB;
   end

   always @(LOADNB, MOVEB)
   begin
      if (LOADNB == 1'b0)
      begin
         drn <= 1'b0;
      end
      else
      begin
         if (MOVEB === 1'b1 && last_MOVEB === 1'b0)
            drn <= DIRECTIONB;
      end
   end

  always @(posedge CLKIB)
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
//         if (t_in_clk == t_in_clk1)
            clock_valid = 1;
         else
            clock_valid = 0;
        end
                                                                                                       
    if (t_in_clk > 0)
    begin
        t_45 = (t_in_clk / 8 );
        t_57 = ((t_in_clk * 5) / 32 );
        t_68 = ((t_in_clk * 3) / 16 );
        t_79 = ((t_in_clk * 7) / 32 );
        t_90 = (t_in_clk / 4 );
        t_101 = ((t_in_clk * 9) / 32 );
        t_112 = ((t_in_clk * 5) / 16 );
        t_123 = ((t_in_clk * 11) / 32 );
        t_135 = ((t_in_clk * 3) / 8 );
     end
                                                                                                       
     if (PHASE_SHIFT == 90)
     begin
        if (t_90 > 0)
        begin
           cntl_ratio = (t_90 / delta);
        end
     end
   end

   assign cntl_reg = cntl_ratio;

   always @(cntl_reg, LOADNB, MOVEB, clock_valid, DDRDELB)
   begin
      if (first_time == 1'b1 && clock_valid == 1'b1 && DDRDELB == 1'b1)
      begin
         cntl_reg_load <= cntl_reg;
         first_time <= 1'b0;
      end
      else if (LOADNB == 1'b0)
      begin
         if (DDRDELB == 1'b1)
            cntl_reg_load <= cntl_reg;
         else
            cntl_reg_load <= 8'b00000000;
      end
      else 
      begin
         if (MOVEB === 1'b0 && last_MOVEB === 1'b1)
         begin
            if (LOADNB == 1'b1)
            begin
               if (drn == 1'b0)   // up-delay
               begin
                  if (CFLAGB == 1'b0 || (cntl_reg_load == 8'b00000000))
                  begin
                     cntl_reg_load <= cntl_reg_load + 1;
                  end
               end
               else if (drn == 1'b1)   // down-delay
               begin
                  if (CFLAGB == 1'b0 || (cntl_reg_load == 8'b11111111))
                  begin
                     cntl_reg_load <= cntl_reg_load - 1'b1;
                  end
               end
            end
         end
      end
   end

  always @(cntl_reg_load)
  begin
      cntl_delay = cntl_reg_load * delta;
  end

  always @(CLKIB)
  begin
     CLKOB <= #(cntl_delay) CLKIB;
  end

/*
  always @(CLKIB)
  begin
     if (DDRDELB == 1'b1 && CFLAGB == 1'b0 )
        CLKOB <= #(cntl_delay) CLKIB;
     else 
        CLKOB <= CLKIB;
  end
*/

  always @(cntl_reg_load)
  begin
     if ((cntl_reg_load == 8'b11111111 && drn == 1'b0) || (cntl_reg_load == 8'b00000000 && drn == 1'b1))
        CFLAGB <= 1'b1;
     else
        CFLAGB <= 1'b0;
  end


endmodule

`endcelldefine
