`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2025 18:16:46
// Design Name: 
// Module Name: system_control
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


module system_control (
    input  wire        clk,
    input  wire        rst,
    input  wire [15:0] addr,
    input  wire [15:0] wdata,
    output reg  [15:0] rdata,
    input  wire        we
);

    reg [15:0] sys_status;

    always @(posedge clk or posedge rst) begin
        if (rst)
            sys_status <= 16'd0;
        else if (we && addr[3:0] == 4'h0)
            sys_status <= wdata;
    end

    always @(*) begin
        if (addr[3:0] == 4'h0)
            rdata = sys_status;
        else
            rdata = 16'd0;
    end

endmodule
