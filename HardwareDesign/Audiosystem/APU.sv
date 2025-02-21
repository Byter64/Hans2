/* |    7:4     |         3:2       |    1:0   |
** | operation  | Target & Source 1 | Source 2 |
**
** Instructions:
** 0000: Add
** 0001: Mul    //Source2 is considered as a fixed point decimal, with a 4 Bit decimal
** 0010: Load   //Source1 is the address, Value will be written to Source2
** 0011: Store  //Source1 is the address, Value will be written from Source2
** 0100: Jmp    //Takes only source 1
** 0101: Cmp    //regb == 0?
** 0110: DEC    //Decodes Source1
** 0111: BEQ    //If source 1 == 0, program jumps to source 2
** else: SET    //SPECIAL CASE: Bits [6:0] are an unsigned, absolute value to which register 3 will be set
*/

//Store/Load: The first 2048 Bytes need to address the BRAM, the others the RAM

module APU (
    input clk,
    input rst,
    input[15:0] dataIn,
    input dataReady,
    input writeAcknowledge,

    output[31:0] address,
    output[15:0] dataOut,
    output writeEnable,
    output readEnable
);

localparam PROGRAMSTART = 0;

localparam ADD  = 4'b0000;
localparam MUL  = 4'b0001; 
localparam LOAD = 4'b0010;
localparam STORE= 4'b0011;
localparam JMP  = 4'b0100; 
localparam BEZ  = 4'b0101;
localparam CMP  = 4'b0110;
localparam DEC  = 4'b0111;

logic[7:0] activeInstruction;
logic[3:0] operation = activeInstruction[7:4];
logic[1:0] source1 = activeInstruction[3:2]; //This is also the target
logic[1:0] source2 = activeInstruction[1:0];

logic[31:0] reg0;
logic[15:0] regs[3];
logic[7:0] pc = 0; //Always points towards the current instruction
logic[7:0] nextPC;

logic[31:0] regA = source1 == 0 ? reg0 : regs[source1];
logic[31:0] regB = source2 == 0 ? reg0 : regs[source2];

//PC und Load/Store muss noch gemacht werden
localparam FETCH = 0;
localparam EXECUTION = 1;
logic state = EXECUTION;

assign address = state == FETCH ? pc : regA;
assign readEnable = state == FETCH ? 1'b1 : operation == LOAD;
assign writeEnable = state == FETCH ? 1'b0 : operation == STORE;
assign dataOut = regB;

always_comb begin : nextPC
    case (state)
        FETCH: begin
            nextPC = pc + 1;
        end
        default: begin
            if(operation == JMP)
                nextPC = regA;
            else if(operation == BEZ)
                nextPC = regA == 0 ? regB : pc + 1;
            else if(operation == LOAD)
                nextPC = dataReady ? pc + 1 : pc;
            else if(operation == STORE)
                nextPC = writeAcknowledge ? pc + 1 : pc;
            else
                nextPC = pc + 1;
            end
    endcase
end

always_ff @(posedge clk) begin : PC
    pc <= nextPC;

    if(rst)
        pc <= PROGRAMSTART;
end

always_ff @(posedge clk) begin : Controller
    case (state)
        FETCH: begin
            if(dataReady) begin
                state <= EXECUTION;
                activeInstruction <= dataIn[7:0];
            end
        end
        EXECUTION: begin
            if((operation != LOAD && operation != STORE) || 
            (writeAcknowledge | dataReady)) begin
                pc <= pc + 1;
            end
        end
    endcase

    if(rst) begin
        state = FETCH;
        activeInstruction <= 0;
    end
end

always_ff @(posedge clk) begin : ALU

    if(state == EXECUTION) begin
        case (operation)
            ADD: begin
                regA <= regA + regB;
            end
            MUL: begin
                regA <= ((regA << 4) * regB) >> 4;
            end
            LOAD: begin
                if(dataReady) begin
                    regB <= dataIn;
                end
            end
            STORE: begin
                //See continuous assignment
            end
            JMP: begin
                //See PC Block
            end
            BEZ: begin
                //See PC Block
            end
            CMP: begin
                regA <= regB == 0;
            end
            DEC: begin
                regA <= {3{regA[11]}, regA, 1'b0};
            end
            default: begin //This is the SET command
                regs[3] <= activeInstruction[6:0];
            end
        endcase
    end
    if(rst) begin
        writeEnable <= 0;
    end
end
    
endmodule