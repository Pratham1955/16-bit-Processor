`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2025 18:12:15
// Design Name: 
// Module Name: imem
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


module imem (
    input  wire [15:0] addr,
    output reg  [15:0] rdata
);

    reg [15:0] memory [0:1023]; // 1K x 16-bit

    initial begin
//        $readmemh("imem_init.hex", memory);
         $readmemh("imem.mem", memory);

    end

    always @(*) begin
        rdata = memory[addr[11:1]]; // 16-bit aligned
    end

endmodule
