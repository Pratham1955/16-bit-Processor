`timescale 1ns / 1ps
module memory(
    input clk,
    input en,
    input wr_en,
    input [15:0] address,
    input [15:0] wr_data, 
    output reg [15:0] data
);

reg [15:0] mem [0:1023]; 

always @(posedge clk) begin
    if (en) begin
        if (wr_en) begin
            mem[address] <= wr_data; // Write operation
        end
        data <= mem[address]; // Read operation
    end
end

endmodule