module Timer #(
    /*This parameter allows you to extend the timer's bit width beyond 32 bits.
      It determines the number of additional bits appended to the base 32-bit timer width, must be a non negative number.
      A larger value increases the maximum timer count range, which can be useful for applications requiring long timer durations.
      Default value: 8 (TODO needs to be calculated with Clockrate, overflow rate etc.).*/
    parameter TIMER_ADDITIONAL_BITS = 8
) (
    input logic clk,
    input logic rst,

    input logic write,
    input logic [31:0] data_in,

    output logic timer_interrupt,
    output logic [31:0] data_out
);
    initial begin
        if(TIMER_ADDITIONAL_BITS<0) begin
        $error("TIMER_ADDITIONAL_BITS should be positive");
        end
    end

    localparam TIMER_BITS = 32 + TIMER_ADDITIONAL_BITS;

    logic [TIMER_BITS-1:0] timer_reg;
    logic [TIMER_BITS-1:0] timer_reg_minus_one;
    logic [TIMER_BITS-1:0] timer_reg_input;

    assign timer_reg_minus_one = (timer_reg > 0) ? (timer_reg - 1) : 0;
    assign timer_reg_input[TIMER_BITS-1:TIMER_ADDITIONAL_BITS] = data_in;
    assign timer_reg_input[TIMER_ADDITIONAL_BITS-1:0] = 0;

    assign timer_interrupt = (timer_reg == 1);

    assign data_out =  timer_reg[TIMER_BITS-1:TIMER_ADDITIONAL_BITS];

    always_ff @(posedge clk) begin      
        timer_reg <= timer_reg_minus_one;
        if(write) begin
            timer_reg <= timer_reg_input;
        end
        if(rst) begin
            timer_reg <= 0;
        end
    end

endmodule
/*
=== Timer ===

   Number of wires:                136
   Number of wire bits:            499
   Number of public wires:         136
   Number of public wire bits:     499
   Number of ports:                  6
   Number of port bits:             68
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                132
     CCU2C                          40
     LUT4                           49
     PFUMX                           3
     TRELLIS_FF                     40
*/
