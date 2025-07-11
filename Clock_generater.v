`timescale 1ns / 1ps

module ClockGenerator(
    output reg clk // Clock output
);

    parameter CLOCK_PERIOD = 10; // Clock period in nanoseconds

    initial begin
        clk = 0;
    end

    always begin
        #(CLOCK_PERIOD / 2) clk = ~clk; // Toggle clock every half-period
    end
endmodule