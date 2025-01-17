module FPUTop (
    input           clk,
    input           rst,

    input           pcpi_valid,
    input  [31:0]   pcpi_insn,
    input  [31:0]   pcpi_rs1,
    input  [31:0]   pcpi_rs2,

    output reg      pcpi_wr,
    output reg[31:0]pcpi_rd,
    output reg      pcpi_wait,
    output reg      pcpi_ready
);
    
endmodule