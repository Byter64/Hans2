module topmodule (
    input  logic clk_25mhz,
    input  logic [7:0] btn,

    output logic [7:0] led
);

/////////// RESET ///////////////////
    logic reset;

/////////// CLOCK ///////////////////
    logic [3:0] clocks;
    `ifdef SYNTHESIS
    ecp5pll
    #(
        .in_hz(25*10**6),
        .out0_hz(25*10**6),                 .out0_tol_hz(0),
        .out1_hz(50*10**6), .out1_deg( 90), .out1_tol_hz(0),
        .out2_hz(100*10**6), .out2_deg(180), .out2_tol_hz(0),
        .out3_hz(140*10**6), .out3_deg(300), .out3_tol_hz(0)
    )
    ecp5pll_inst
    (
        .clk_i(clk_25mhz),
        .clk_o(clocks)
    );
    `else
    initial begin
        clocks = 0;
    end
    always #20 clocks[0] = ~ clocks[0];
    always #10 clocks[1] = ~ clocks[1];
    always #5 clocks[2] = ~ clocks[2];
    always #3 clocks[3] = ~ clocks[3];    
    `endif
// In Synthesis include PLL/ecp5pll.sv, for simulation it needs to be excluded since it has primitives

/////////// CPU ///////////////////
	logic cpu_trap;

	// Wishbone interfaces
	logic cpu_wb_rst_i; //Reset
	logic cpu_wb_clk_i; //Clock

	logic [31:0] cpu_wbm_adr_o;
	logic [31:0] cpu_wbm_dat_o;
	logic [31:0] cpu_wbm_dat_i;
	logic cpu_wbm_we_o;
	logic [3:0] cpu_wbm_sel_o;
	logic cpu_wbm_stb_o;
	logic cpu_wbm_ack_i;
	logic cpu_wbm_cyc_o;

	// Pico Co-Processor Interface (PCPI)
	logic        cpu_pcpi_valid;
	logic [31:0] cpu_pcpi_insn;
	logic [31:0] cpu_pcpi_rs1;
	logic [31:0] cpu_pcpi_rs2;
	logic        cpu_pcpi_wr;
	logic [31:0] cpu_pcpi_rd;
	logic        cpu_pcpi_wait;
	logic        cpu_pcpi_ready;

	// IRQ interface
	logic [31:0] cpu_irq;
	logic [31:0] cpu_eoi;

	// Trace Interface
	logic        cpu_trace_valid;
	logic [35:0] cpu_trace_data;

	logic cpu_mem_instr;

	picorv32_wb #(
		.ENABLE_COUNTERS     (1),//0? TODO
		.ENABLE_COUNTERS64   (1),//0? TODO
		.ENABLE_REGS_16_31   (1),
		.ENABLE_REGS_DUALPORT(1),
		.TWO_STAGE_SHIFT     (0),
		.BARREL_SHIFTER      (1),
		.TWO_CYCLE_COMPARE   (0),// Only with timing issues
		.TWO_CYCLE_ALU       (0),// Only with timing issues
		.COMPRESSED_ISA      (0),
		.CATCH_MISALIGN      (0),// TODO
		.CATCH_ILLINSN       (0),// TODO
		.ENABLE_PCPI         (0),// TODO FPU
		.ENABLE_MUL          (0),
		.ENABLE_FAST_MUL     (1),
		.ENABLE_DIV          (1),
		.ENABLE_IRQ          (1),
		.ENABLE_IRQ_QREGS    (1),// TODO
		.ENABLE_IRQ_TIMER    (1),// TODO
		.ENABLE_TRACE        (0),// TODO
		.REGS_INIT_ZERO      (0),// TODO
		.MASKED_IRQ          (32'h 0000_0000),// TODO
		.LATCHED_IRQ         (32'h ffff_ffff),// TODO
		.PROGADDR_RESET      (32'h 0000_0000),// TODO
		.PROGADDR_IRQ        (32'h 0000_0010),// TODO
		.STACKADDR           (32'h ffff_ffff)// TODO
    ) cpu (
        .trap(cpu_trap),

        .wb_rst_i(reset),
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

/////////// GPU ///////////////////

/////////// APU ///////////////////
endmodule