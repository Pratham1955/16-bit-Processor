`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2025 18:27:33
// Design Name: 
// Module Name: datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Datapath(
    input clk,
    input rst,
    input [15:0] gpio_in,
    output [15:0] gpio_out
);

    // Wires and registers
    wire [15:0] instruction;
    wire [3:0] opcode;
    wire [3:0] rs1, rs2, rd;
    wire [15:0] imm;
    wire [15:0] A, B;
    wire [15:0] alu_result;
    wire [15:0] mem_data;
    wire [15:0] pc_out;
    wire mem_read, mem_write, reg_write, pc_write, branch_eq, branch_ne, imm_load;
    wire [3:0] alu_op;

    // Program Counter
    PC pc_inst (
        .clk(clk),
        .rst(rst),
        .load(pc_write),
        .data(alu_result),   // address to jump if needed
        .count(pc_out)
    );

    // Instruction Memory (fetch instruction)
    memory instr_mem (
        .clk(clk),
        .en(1'b1),
        .wr_en(1'b0),
        .address(pc_out),
        .wr_data(16'b0),
        .data(instruction)
    );

    // Decode instruction
    assign opcode = instruction[15:12];
    assign rs1 = instruction[11:8];
    assign rs2 = instruction[7:4];
    assign rd = instruction[3:0];
    assign imm = instruction[7:0]; // Or as per your instruction format

    // Control Unit
    ControlUnit cu (
        .opcode(opcode),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .alu_op(alu_op),
        .pc_write(pc_write),
        .branch_eq(branch_eq),
        .branch_ne(branch_ne),
        .imm_load(imm_load)
    );

    // Register File
    RegisterFile rf (
        .clk(clk),
        .rst(rst),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .write_addr(rd),
        .write_data(alu_result),   // or mem_data based on load
        .write_enable(reg_write),
        .read_data1(A),
        .read_data2(B)
    );

    // ALU
    alu alu_inst (
        .clk(clk),
        .rst(rst),
        .load(pc_write),
        .en(mem_read | mem_write),
        .wr_en(mem_write),
        .OPsel(alu_op),
        .A(A),
        .B(B),
        .result(alu_result),
        .Z(),
        .N(),
        .C(),
        .V(),
        .pc_out(),     // you already updated PC separately
        .mem_data(mem_data)
    );

    // GPIO (example direct connection)
    assign gpio_out = A;  // A register value can be sent outside
    // Similarly, gpio_in can be loaded into a register if you want

endmodule
