module regs (
    input logic clk,
    input logic reset,

    input logic regwrite,

    input logic [4:0] rs1adr,
    input logic [4:0] rs2adr,
    input logic [4:0] rdadr,

    input  logic [31:0] rd,
    output logic [31:0] rs1,
    output logic [31:0] rs2
);

    // Internal register data structure
    typedef logic [31:0] registers_t [32];
    registers_t registers;

    // NOTE: Debug signals
    // logic [31:0]         reg0;
    // logic [31:0]         reg1;
    // logic [31:0]         reg2;
    // logic [31:0]         reg3;
    // logic [31:0]         reg4;
    // logic [31:0]         reg5;
    // logic [31:0]         reg6;
    // logic [31:0]         reg7;


    // Make sure x0 is always zero
    initial registers[0] = 0;

    always_ff @(posedge clk) begin
        if (reset) begin
            registers[0] <= 0;

            rs1 <= 0;
            rs2 <= 0;
        end else begin
            // Only perform write if control sets regwrite
            // and x0 isn't the target
            if (regwrite && rdadr != 0) begin
                registers[rdadr] <= rd;
            end

            // Perform read
            rs1 <= registers[rs1adr];
            rs2 <= registers[rs2adr];

            // NOTE: Remove after debugging
            // reg0 <= registers[0];
            // reg1 <= registers[1];
            // reg2 <= registers[2];
            // reg3 <= registers[3];
            // reg4 <= registers[4];
            // reg5 <= registers[5];
            // reg6 <= registers[6];
            // reg7 <= registers[7];
        end
    end

`ifdef FORMAL
`endif
endmodule  // regs
