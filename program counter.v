`timescale 1ns / 1ps

module PC(
    input clk,                 // Clock signal
    input rst,                 // Active-high reset signal
    input load,                // Load enable signal
    input [15:0] data,         // Data to load into the PC
    output reg [15:0] count    // Current value of the PC
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 16'b0;    // Reset PC to 0
        end else if (load) begin
            count <= data;     // Load the input data into the PC
        end else begin
            count <= count + 1; // Increment the PC
        end
    end

endmodule