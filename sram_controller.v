module sram_controller (
    input clk,
    input reset,
    input rd,
    input wr,
    input [3:0] addr,
    input [7:0] wdata,
    output reg [7:0] rdata,
    output reg ready
);

    // FSM states
    reg [1:0] state, next_state;

    parameter IDLE  = 2'b00,
              WRITE = 2'b01,
              READ  = 2'b10,
              DONE  = 2'b11;

    reg cs, we, oe;
    wire [7:0] mem_rdata;

    // SRAM instantiation
    sram mem (
        .clk(clk),
        .cs(cs),
        .we(we),
        .oe(oe),
        .addr(addr),
        .wdata(wdata),
        .rdata(mem_rdata)
    );

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (wr) next_state = WRITE;
                else if (rd) next_state = READ;
                else next_state = IDLE;
            end

            WRITE: next_state = DONE;
            READ : next_state = DONE;
            DONE : next_state = IDLE;

            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cs <= 0; we <= 0; oe <= 0;
            ready <= 0;
            rdata <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    cs <= 0; we <= 0; oe <= 0;
                    ready <= 0;
                end

                WRITE: begin
                    cs <= 1; we <= 1; oe <= 0;
                    ready <= 0;
                end

                READ: begin
                    cs <= 1; we <= 0; oe <= 1;
                    rdata <= mem_rdata;
                    ready <= 0;
                end

                DONE: begin
                    cs <= 0; we <= 0; oe <= 0;
                    ready <= 1;
                end
            endcase
        end
    end

endmodule
