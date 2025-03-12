module lerper #(
    parameter SIGNAL_WIDTH = 16
) (
    input clk,
    input rstn,

    input[SIGNAL_WIDTH - 1 : 0] i_signal,
    input[15:0] speed, //Signed int. Negative numbers are interpreted as fractional slowdown. E.g. -4 is interpreted as a speed of 0.25. A speed of 0 will cause the output to be equal to the input.

    output reg[SIGNAL_WIDTH - 1 : 0] o_signal
);

localparam IDLE = 0;
localparam FASTER = 1;
localparam SLOWER = 2;
localparam FINISH = 4;

wire[SIGNAL_WIDTH - 1 : 0] signal_delta = o_signal - i_signal;
reg[3:0] state = 0;

wire[15:0] slow_speed = -speed;
reg[15:0] slower_counter = 0;
wire slow_tick = slower_counter == 0;

always @(posedge clk) begin
    if(rstn == 0) begin
        state <= 0;
    end else begin
        case(state)
            IDLE: begin
                if(signal_delta != 0)
                    state <= $signed(speed) < 0 ? SLOWER : $signed(speed) > 0 ? FASTER  : IDLE; 
                if(speed == 0)
                    state <= FINISH;
            end
            FASTER: begin
                if(($signed(signal_delta) < $signed(speed) && $signed(signal_delta) > $signed(-speed)) || speed == 0) 
                    state <= FINISH;
                else if ($signed(speed) < 0)
                    state <= SLOWER;
            end
            SLOWER: begin
                if(($signed(signal_delta) == 0) || speed == 0)
                    state <= FINISH;
                else if($signed(speed) > 0)
                    state <= FASTER;
            end
            FINISH: begin
                state <= IDLE;
            end
        endcase
    end
end

always @(posedge clk) begin
    if(rstn == 0) begin
        o_signal <= i_signal;
        slower_counter = 0;
    end else begin
        case (state)
            IDLE: begin
                if(speed == 0)
                    o_signal <= i_signal;
                slower_counter <= 0;
            end
            FASTER: begin
                if($signed(signal_delta) < 0)
                    o_signal <= o_signal + speed;
                else if($signed(signal_delta) > 0)
                    o_signal <= o_signal - speed;
            end
            SLOWER: begin
                if(slow_tick) begin 
                    if($signed(signal_delta) < 0)
                        o_signal <= o_signal + 1;
                    else if($signed(signal_delta) > 0)
                        o_signal <= o_signal - 1;
                end
            end
            FINISH: begin
                o_signal <= i_signal;
            end
        endcase
    end
end

always @(posedge clk) begin
    if(rstn == 0) begin
        slower_counter <= 0;
    end else begin
        if($signed(speed) > 0) begin
            slower_counter <= 0;
        end else begin
            slower_counter <= slower_counter + 1;
            if(slower_counter + 1 == slow_speed) begin
                slower_counter <= 0;
            end
        end
    end
end

endmodule
