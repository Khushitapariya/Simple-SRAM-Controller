module sram (
    input clk,
    input cs,
    input we,
    input oe,
    input [3:0] addr,
    input [7:0] wdata,
    output reg [7:0] rdata
);

    reg [7:0] mem [0:15];

    always @(posedge clk) begin
        if (cs && we)
            mem[addr] <= wdata;
    end

    always @(posedge clk) begin
        if (cs && oe)
            rdata <= mem[addr];
    end

endmodule
