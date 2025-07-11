`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2025 18:14:38
// Design Name: 
// Module Name: gpio
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


module gpio (
    input  wire        clk,
    input  wire        rst,
    input  wire [15:0] addr,
    input  wire [15:0] wdata,
    output reg  [15:0] rdata,
    input  wire        we,
    input  wire [7:0]  gpio_in,
    output reg  [7:0]  gpio_out,
    output reg  [7:0]  gpio_dir
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            gpio_out <= 8'd0;
            gpio_dir <= 8'd0;
        end else if (we) begin
            case (addr[3:0])
                4'h0: gpio_out <= wdata[7:0];
                4'h4: gpio_dir <= wdata[7:0];
            endcase
        end
    end

    always @(*) begin
        case (addr[3:0])
            4'h0: rdata = {8'd0, gpio_in};
            4'h4: rdata = {8'd0, gpio_dir};
            default: rdata = 16'd0;
        endcase
    end

endmodule
