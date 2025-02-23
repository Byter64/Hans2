/* |    7:4     |         3:2       |    1:0   |
** | operation  | Target & Source 1 | Source 2 |
**
** Instructions:
** 0000: Add
** 0001: Mul    //Source2 is considered as a fixed point decimal, with a 4 Bit decimal
** 0010: Load   //Source1 is the address, Value will be written to Source2
** 0011: Store  //Source1 is the address, Value will be written from Source2
** 0100: Jmp    //Takes only source 1
** 0101: Cmp    //Sets compare registers
** 0110: DEC    //Decodes Source1
** 0111: BRU    //SPECIAL: 1:0 decides the branch condition. If fullfilled, the program jumps to source 1 
                //00 - less, 01 - equal, 10 - greater, 11 - unequal
** else: SET    //SPECIAL CASE: Bits [6:0] are an unsigned, absolute value to which register 3 will be set
*/

//If a load OP with source 1 == R0 happens, readRAM is high, else low.
//If readRAM is low, an offset of 1876 is added to the address (2048 - 172 = 1876)

module APU (
    input clk,
    input rst,
    input[15:0] dataIn,
    input dataReady,
    input writeAcknowledge,

    output[31:0] address,
    output[15:0] dataOut,
    output writeEnable,
    output readEnable,
    output readRAM //1 if data should be read from RAM, 0 if from BRAM
);

localparam PROGRAMSTART = 0;

localparam ADD  = 4'b0000;
localparam MUL  = 4'b0001; 
localparam LOAD = 4'b0010;
localparam STORE= 4'b0011;
localparam JMP  = 4'b0100; 
localparam BRU  = 4'b0101;
localparam CMP  = 4'b0110;
localparam DEC  = 4'b0111;

logic[7:0] activeInstruction = 0;
logic[3:0] operation;
logic[1:0] source1; //This is also the destination register
logic[1:0] source2;

assign operation = activeInstruction[7:4];
assign source1 = activeInstruction[3:2];
assign source2 = activeInstruction[1:0];

logic[31:0] reg0 = 0;
logic[15:0] regs[3];
initial regs[0] = 0;
initial regs[1] = 0;
initial regs[2] = 0;

logic[31:0] regA;
logic[31:0] regB;

assign regA = source1 == 0 ? reg0 : regs[source1 - 1];
assign regB = source2 == 0 ? reg0 : regs[source2 - 1];

logic isLess;
logic isEqual;
logic isGreater;

logic[7:0] pc; //Always points towards the current instruction
logic[7:0] nextPC;

localparam FETCH = 0;
localparam EXECUTION = 1;
logic state = FETCH;

assign address = state == FETCH ? pc : source1 == 2'b00 ? regA :(regA + 1876);
assign readEnable = state == FETCH ? 1'b1 : operation == LOAD;
assign writeEnable = state == FETCH ? 1'b0 : operation == STORE;
assign dataOut = regB;
assign readRAM = operation == LOAD && source1 == 0;

always_comb begin : nextPCDecider
    case (state)
        FETCH: begin
            nextPC = pc + 1;
        end
        default: begin
            if(operation == JMP)
                nextPC = regA;
            else if(operation == BRU)
                if((source2 == 2'b00 && isLess) || 
                (source2 == 2'b01 && isEqual)   || 
                (source2 == 2'b10 && isGreater) || 
                (source2 == 2'b11 && !isEqual))
                    nextPC = regA;
                else
                    nextPC = pc;
            else
                nextPC = pc;
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
                state <= FETCH;
            end
        end
    endcase

    if(rst) begin
        state <= FETCH;
        activeInstruction <= 0;
    end
end

always_ff @(posedge clk) begin : ALU
    if(state == EXECUTION) begin
        case (operation)
            ADD: begin
                if(source1 == 0)
                    reg0 <= regA + regB;
                else
                    regs[source1 - 1] <= regA + regB;
            end
            MUL: begin
                if(source1 == 0)
                    reg0 <= ((regA << 4) * regB) >> 4;
                else
                    regs[source1 - 1] <= ((regA << 4) * regB) >> 4;
            end
            LOAD: begin
                if(dataReady) begin
                    if(source2 == 0)
                        reg0 <= dataIn;
                    else
                        regs[source2 - 1] <= dataIn;
                end
            end
            STORE: begin
                //See continuous assignment
            end
            JMP: begin
                //See PC Block
            end
            BRU: begin
                //See PC Block
            end
            CMP: begin
                isLess <= regA < regB;
                isEqual <= regA == regB;
                isGreater <= regA > regB;
            end
            DEC: begin
                if(source1 == 0)
                    reg0 <= {{3{regA[11]}}, regA, 1'b0};
                else
                    regs[source1 - 1] <= {{3{regA[11]}}, regA, 1'b0};
            end
            default: begin //This is the SET command
                regs[2] <= activeInstruction[6:0];
            end
        endcase
    end
end
    
endmodule