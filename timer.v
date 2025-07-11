`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2025 18:16:02
// Design Name: 
// Module Name: timer
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


module timer (
    input  wire        clk,
    input  wire        rst,
    input  wire [15:0] addr,
    input  wire [15:0] wdata,
    output reg  [15:0] rdata,
    input  wire        we
);

    reg [15:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst)
            counter <= 16'd0;
        else if (we && addr[3:0] == 4'h0)
            counter <= wdata;
        else
            counter <= counter + 1;
    end

    always @(*) begin
        if (addr[3:0] == 4'h0)
            rdata = counter;
        else
            rdata = 16'd0;
    end

endmodule
