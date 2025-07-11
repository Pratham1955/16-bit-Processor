module ControlUnit (
    input [3:0] opcode,      // 4-bit opcode
    output reg mem_read,     // Memory read signal
    output reg mem_write,    // Memory write signal
    output reg reg_write,    // Register write signal
    output reg [3:0] alu_op, // ALU operation control
    output reg pc_write,     // Program Counter update
    output reg branch_eq,    // Branch if equal signal
    output reg branch_ne,    // Branch if not equal signal
    output reg imm_load      // Immediate value load signal
);

    always @(*) begin
        // Default control signals
        mem_read = 0;
        mem_write = 0;
        reg_write = 0;
        alu_op = 4'b0000;
        pc_write = 0;
        branch_eq = 0;
        branch_ne = 0;
        imm_load = 0;

        case (opcode)
            4'b0000: begin // ADD
                alu_op = 4'b0000; // ADD operation
                reg_write = 1;
            end
            4'b0001: begin // SUB
                alu_op = 4'b0001; // SUB operation
                reg_write = 1;
            end
            4'b0010: begin // MUL
                alu_op = 4'b0010; // MUL operation
                reg_write = 1;
            end
            4'b0011: begin // DIV
                alu_op = 4'b0011; // DIV operation
                reg_write = 1;
            end
            4'b0100: begin // AND
                alu_op = 4'b0100; // AND operation
                reg_write = 1;
            end
            4'b0101: begin // OR
                alu_op = 4'b0101; // OR operation
                reg_write = 1;
            end
            4'b0110: begin // XOR
                alu_op = 4'b0110; // XOR operation
                reg_write = 1;
            end
            4'b0111: begin // NOT
                alu_op = 4'b0111; // NOT operation
                reg_write = 1;
            end
            4'b1000: begin // LOAD (LDR)
                alu_op = 4'b1000; // LDR operation
                mem_read = 1;
                reg_write = 1;
            end
            4'b1001: begin // STORE (STR)
                alu_op = 4'b1001; // STR operation
                mem_write = 1;
            end
            4'b1010: begin // MOVE
                alu_op = 4'b1010; // MOVE operation (pass-through)
                reg_write = 1;
            end
            4'b1011: begin // IMMEDIATE
                imm_load = 1;
                reg_write = 1;
            end
            4'b1100: begin // JUMP
                alu_op = 4'b1100; // JMP operation
                pc_write = 1;
            end
            4'b1101: begin // BRANCH IF EQUAL (BEQ)
                alu_op = 4'b1101; // BEQ operation
                branch_eq = 1;
            end
            4'b1110: begin // BRANCH IF NOT EQUAL (BNE)
                alu_op = 4'b1110; // BNE operation
                branch_ne = 1;
            end
            4'b1111: begin // NOP
                // No operation
            end
            default: begin
                // Default case for undefined opcodes
                alu_op = 4'b0000;
            end
        endcase

        // Additional signals for PC and memory integration
        if (mem_write) begin
            pc_write = 0; // Ensure PC write is disabled during memory write
        end

        if (mem_read) begin
            pc_write = 0; // Ensure PC write is disabled during memory read
        end
    end

endmodule