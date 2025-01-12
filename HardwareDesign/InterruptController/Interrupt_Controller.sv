module Interrupt_Controller #(
    parameter INTERRUPT_COUNT = 10
) (
    input  logic clk,
    input  logic rst,

    input  logic [INTERRUPT_COUNT-1:0] timer_interrupts,

    input  logic read_interrupt,
    output logic out_interrupt

);
    
endmodule