`timescale 1ns/1ps

module tb_sram_controller;

reg clk, reset, rd, wr;
reg [3:0] addr;
reg [7:0] wdata;
wire [7:0] rdata;
wire ready;

sram_controller dut (
    clk, reset, rd, wr, addr, wdata, rdata, ready
);

always #5 clk = ~clk;

initial begin
    $dumpfile("sram.vcd");
    $dumpvars(0, tb_sram_controller);

    clk = 0;
    reset = 1;
    rd = 0; wr = 0;
    addr = 0; wdata = 0;

    #10 reset = 0;

    // WRITE
    #10 addr = 4'h4; wdata = 8'h5A; wr = 1;
    #10 wr = 0;

    // READ
    #20 rd = 1;
    #10 rd = 0;

    #100 $finish;
end

endmodule

