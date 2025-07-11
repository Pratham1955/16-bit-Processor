`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2025 18:13:39
// Design Name: 
// Module Name: dmem
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


module dmem (
    input  wire        clk,
    input  wire [15:0] addr,
    input  wire [15:0] wdata,
    input  wire        we,
    output reg  [15:0] rdata
);

    reg [15:0] memory [0:1023]; // 1K x 16-bit

    always @(posedge clk) begin
        if (we)
            memory[addr[11:1]] <= wdata;
    end

    always @(*) begin
        rdata = memory[addr[11:1]];
    end

endmodule
