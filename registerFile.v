`timescale 1ns / 1ps

module RegisterFile(
    input clk,                     // Clock signal
    input rst,                     // Reset signal
    input [3:0] read_addr1,        // Address for first read port
    input [3:0] read_addr2,        // Address for second read port
    input [3:0] write_addr,        // Address for write port
    input [15:0] write_data,       // Data to be written
    input write_enable,            // Write enable signal
    output reg [15:0] read_data1,  // Data from first read port
    output reg [15:0] read_data2   // Data from second read port
);

    // Register array
    reg [15:0] registers [0:15];

    // Read operation
    always @(*) begin
        read_data1 = registers[read_addr1];
        read_data2 = registers[read_addr2];
    end

    // Write operation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers to 0
         integer i;
            for (i = 0; i < 16; i = i + 1) begin
                registers[i] <= 16'b0;
            end
        end else if (write_enable) begin
            registers[write_addr] <= write_data;
        end
    end
endmodule