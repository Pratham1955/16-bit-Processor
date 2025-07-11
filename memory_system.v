module memory_system (
    input  wire        clk,
    input  wire        rst,
    input  wire [15:0] addr,
    input  wire [15:0] wdata,
    input  wire        write_en,
    input  wire        read_en,
    output reg  [15:0] rdata,

    // Instruction Memory
    output wire [15:0] imem_addr,
    input  wire [15:0] imem_rdata,

    // Data Memory
    output wire [15:0] dmem_addr,
    input  wire [15:0] dmem_rdata,
    output wire [15:0] dmem_wdata,
    output wire        dmem_we,

    // GPIO
    output wire [15:0] gpio_addr,
    input  wire [15:0] gpio_rdata,
    output wire [15:0] gpio_wdata,
    output wire        gpio_we,

    // Timer
    output wire [15:0] timer_addr,
    input  wire [15:0] timer_rdata,
    output wire [15:0] timer_wdata,
    output wire        timer_we,

    // System Control
    output wire [15:0] sysctrl_addr,
    input  wire [15:0] sysctrl_rdata,
    output wire [15:0] sysctrl_wdata,
    output wire        sysctrl_we
);

    always @(*) begin
        rdata = 16'd0;
        case (addr[15:12])
            4'h0: rdata = imem_rdata;
            4'h4: rdata = dmem_rdata;
            4'h8: rdata = gpio_rdata;
            4'hA: rdata = timer_rdata;
            4'hB: rdata = sysctrl_rdata;
            default: rdata = 16'd0;
        endcase
    end

    assign imem_addr    = addr;
    assign dmem_addr    = addr;
    assign dmem_wdata   = wdata;
    assign dmem_we      = write_en & (addr[15:12] == 4'h4);

    assign gpio_addr    = addr;
    assign gpio_wdata   = wdata;
    assign gpio_we      = write_en & (addr[15:12] == 4'h8);

    assign timer_addr   = addr;
    assign timer_wdata  = wdata;
    assign timer_we     = write_en & (addr[15:12] == 4'hA);

    assign sysctrl_addr = addr;
    assign sysctrl_wdata= wdata;
    assign sysctrl_we   = write_en & (addr[15:12] == 4'hB);

endmodule
