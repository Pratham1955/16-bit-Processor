`timescale 1ns / 1ps

module alu(
    input clk,               // Clock for synchronous operations
    input rst,               // Reset signal for ALU
    input load,              // Load enable for Program Counter (PC)
    input en,                // Enable signal for memory
    input wr_en,             // Write enable signal for memory
    input [3:0] OPsel,       // 4-bit opcode to select ALU operation
    input [15:0] A,          // 16-bit Register input (data)
    input [15:0] B,          // 16-bit Address input (address)
    output reg [15:0] result, // 16-bit ALU result
    output reg Z,            // Zero flag
    output reg N,            // Negative flag
    output reg C,            // Carry flag
    output reg V,            // Overflow flag
    output [15:0] pc_out,    // Program Counter output
    output [15:0] mem_data   // Data read from memory (for LDR operation)
);

    // Program Counter instance
    reg pc_load; // Control signal for PC load
    PC pc_inst(
        .clk(clk),
        .rst(rst),
        .load(pc_load),
        .data(B),       // Jump address comes from B
        .count(pc_out)  // PC output
    );

    // Memory instance
    reg [15:0] wr_data; // Data to write to memory
    memory mem_inst(
        .clk(clk),
        .en(en),
        .wr_en(wr_en),
        .address(B),    // B is now the memory address
        .wr_data(wr_data), // Correctly assign wr_data
        .data(mem_data) // Data read from memory
    );

    always @(*) begin
        // Initialize outputs
        result = 16'b0;
        pc_load = 0;
        Z = 0;
        N = 0;
        C = 0;
        V = 0;

        case (OPsel)
            4'b0000: begin // Addition
                {C, result} = A + B;                // Carry is MSB of addition
                V = (~A[15] & ~B[15] & result[15]) | (A[15] & B[15] & ~result[15]); // Overflow
            end
            4'b0001: begin // Subtraction
                {C, result} = A - B;                // Carry is MSB of subtraction
                V = (A[15] & ~B[15] & ~result[15]) | (~A[15] & B[15] & result[15]); // Overflow
            end
            4'b0010: result = A * B;                // Multiplication
            4'b0011: result = (B != 0) ? A / B : 16'b0; // Division (avoid div by 0)
            4'b0100: result = A & B;                // AND
            4'b0101: result = A | B;                // OR
            4'b0110: result = A ^ B;                // XOR
            4'b0111: result = ~A;                   // NOT
            4'b1000: result = mem_data;             // LDR (Load from memory)
            4'b1001: wr_data = A;                   // STR (Store to memory)
            4'b1100: begin                          // JMP (Jump to address in B)
                pc_load = 1;                        // Enable PC load with B
            end
            4'b1101: begin                          // BNE (Jump if not equal)
                if (!Z)
                    pc_load = 1;                    // Enable PC load with B
            end
            4'b1110: begin                          // BEQ (Jump if equal)
                if (Z)
                    pc_load = 1;                    // Enable PC load with B
            end
            4'b1111: ;                              // NOP (No operation)
            default: result = 16'b0;                // Default to zero if no match
        endcase

        // Update flags
        Z = (result == 16'b0) ? 1'b1 : 1'b0;  // Zero flag
        N = result[15];                       // Negative flag (MSB is sign bit)
    end

endmodule