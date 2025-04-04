module ProcessingUnit #(
	parameter [ 0:0] ENABLE_COUNTERS = 1,
	parameter [ 0:0] ENABLE_COUNTERS64 = 1,
	parameter [ 0:0] ENABLE_REGS_16_31 = 1,
	parameter [ 0:0] ENABLE_REGS_DUALPORT = 1,
	parameter [ 0:0] LATCHED_MEM_RDATA = 0,
	parameter [ 0:0] TWO_STAGE_SHIFT = 1,
	parameter [ 0:0] BARREL_SHIFTER = 0,
	parameter [ 0:0] TWO_CYCLE_COMPARE = 0,
	parameter [ 0:0] TWO_CYCLE_ALU = 0,
	parameter [ 0:0] COMPRESSED_ISA = 0,
	parameter [ 0:0] CATCH_MISALIGN = 1,
	parameter [ 0:0] CATCH_ILLINSN = 1,
	parameter [ 0:0] ENABLE_PCPI = 0,
	parameter [ 0:0] ENABLE_MUL = 0,
	parameter [ 0:0] ENABLE_FAST_MUL = 0,
	parameter [ 0:0] ENABLE_DIV = 0,
	parameter [ 0:0] ENABLE_IRQ = 0,
	parameter [ 0:0] ENABLE_IRQ_QREGS = 1,
	parameter [ 0:0] ENABLE_IRQ_TIMER = 1,
	parameter [ 0:0] ENABLE_TRACE = 0,
	parameter [ 0:0] REGS_INIT_ZERO = 0,
	parameter [31:0] MASKED_IRQ = 32'h 0000_0000,
	parameter [31:0] LATCHED_IRQ = 32'h ffff_ffff,
	parameter [31:0] PROGADDR_RESET = 32'h 0000_0000,
	parameter [31:0] PROGADDR_IRQ = 32'h 0000_0010,
	parameter [31:0] STACKADDR = 32'h ffff_ffff
    ) (
    output cpu_trap,

	// Wishbone interfaces
	input cpu_wb_rst_i,
	input cpu_wb_clk_i,

	output reg [31:0] cpu_wbm_adr_o,
	output reg [31:0] cpu_wbm_dat_o,
	input [31:0] cpu_wbm_dat_i,
	output reg cpu_wbm_we_o,
	output reg [3:0] cpu_wbm_sel_o,
	output reg cpu_wbm_stb_o,
	input cpu_wbm_ack_i,
	output reg cpu_wbm_cyc_o,

	// IRQ interface
	input  [31:0] cpu_irq,
	output [31:0] cpu_eoi,

	// Trace Interface
	output        cpu_trace_valid,
	output [35:0] cpu_trace_data,

	output cpu_mem_instr
	);

    // Pico Co-Processor Interface (PCPI)
	logic        cpu_pcpi_valid;
	logic [31:0] cpu_pcpi_insn;
	logic [31:0] cpu_pcpi_rs1;
	logic [31:0] cpu_pcpi_rs2;
	logic        cpu_pcpi_wr;
	logic [31:0] cpu_pcpi_rd;
	logic        cpu_pcpi_wait;
	logic        cpu_pcpi_ready;


	picorv32_wb #(
		.ENABLE_COUNTERS     (ENABLE_COUNTERS     ),
		.ENABLE_COUNTERS64   (ENABLE_COUNTERS64   ),
		.ENABLE_REGS_16_31   (ENABLE_REGS_16_31   ),
		.ENABLE_REGS_DUALPORT(ENABLE_REGS_DUALPORT),
		.TWO_STAGE_SHIFT     (TWO_STAGE_SHIFT     ),
		.BARREL_SHIFTER      (BARREL_SHIFTER      ),
		.TWO_CYCLE_COMPARE   (TWO_CYCLE_COMPARE   ),
		.TWO_CYCLE_ALU       (TWO_CYCLE_ALU       ),
		.COMPRESSED_ISA      (COMPRESSED_ISA      ),
		.CATCH_MISALIGN      (CATCH_MISALIGN      ),
		.CATCH_ILLINSN       (CATCH_ILLINSN       ),
		.ENABLE_PCPI         (ENABLE_PCPI         ),
		.ENABLE_MUL          (ENABLE_MUL          ),
		.ENABLE_FAST_MUL     (ENABLE_FAST_MUL     ),
		.ENABLE_DIV          (ENABLE_DIV          ),
		.ENABLE_IRQ          (ENABLE_IRQ          ),
		.ENABLE_IRQ_QREGS    (ENABLE_IRQ_QREGS    ),
		.ENABLE_IRQ_TIMER    (ENABLE_IRQ_TIMER    ),
		.ENABLE_TRACE        (ENABLE_TRACE        ),
		.REGS_INIT_ZERO      (REGS_INIT_ZERO      ),
		.MASKED_IRQ          (MASKED_IRQ          ),
		.LATCHED_IRQ         (LATCHED_IRQ         ),
		.PROGADDR_RESET      (PROGADDR_RESET      ),
		.PROGADDR_IRQ        (PROGADDR_IRQ        ),
		.STACKADDR           (STACKADDR           )
    ) cpu (
        .trap(cpu_trap),

        .wb_rst_i(cpu_wb_rst_i),
	    .wb_clk_i(cpu_wb_clk_i),

	    .wbm_adr_o(cpu_wbm_adr_o),
	    .wbm_dat_o(cpu_wbm_dat_o),
	    .wbm_dat_i(cpu_wbm_dat_i),
	    .wbm_we_o (cpu_wbm_we_o),
	    .wbm_sel_o(cpu_wbm_sel_o),
	    .wbm_stb_o(cpu_wbm_stb_o),
	    .wbm_ack_i(cpu_wbm_ack_i),
	    .wbm_cyc_o(cpu_wbm_cyc_o),

		.pcpi_valid(cpu_pcpi_valid),
		.pcpi_insn (cpu_pcpi_insn ),
		.pcpi_rs1  (cpu_pcpi_rs1  ),
		.pcpi_rs2  (cpu_pcpi_rs2  ),
		.pcpi_wr   (cpu_pcpi_wr   ),
		.pcpi_rd   (cpu_pcpi_rd   ),
		.pcpi_wait (cpu_pcpi_wait ),
		.pcpi_ready(cpu_pcpi_ready),

		.irq(cpu_irq),
		.eoi(cpu_eoi),

        .trace_valid(cpu_trace_valid),
	    .trace_data(cpu_trace_data),
	    
        .mem_instr(cpu_mem_instr)
	);

    FPUTop fpu (
        .clk        (cpu_wb_clk_i   ),
        .rst        (cpu_wb_rst_i   ),

        .pcpi_insn  (cpu_pcpi_insn  ),
        .pcpi_rd    (cpu_pcpi_rd    ),
        .pcpi_ready (cpu_pcpi_ready ),
        .pcpi_rs1   (cpu_pcpi_rs1   ),
        .pcpi_rs2   (cpu_pcpi_rs2   ),
        .pcpi_valid (cpu_pcpi_valid ),
        .pcpi_wait  (cpu_pcpi_wait  ),
        .pcpi_wr    (cpu_pcpi_wr    )
    );
    
endmodule