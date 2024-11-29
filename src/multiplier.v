`timescale 1ns / 1ps
`include "adder.v"
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module twoBitMultiplier (
    input [1:0] A,
    input [1:0] B,
    input clk,
    input reset,
    output [3:0] C
);
    wire carry_wire;
    assign C[0] = A[0] & B[0];
    full_adder ha1 (
        A[0] & B[1],
        A[1] & B[0],
        1'b0,
        carry_wire,
        C[1]
    );
    full_adder ha2 (
        A[1] & B[1],
        1'b0,
        carry_wire,
        C[3],
        C[2]
    );
endmodule

module multiplier32 (
    input [31:0] A,
    input [31:0] B,
    input clk,
    input reset,
    output [63:0] C,
    output ready
);

    reg [63:0] C_reg;
    assign C_reg = C;

    initial begin
        C_reg <= 64'b0;
    end

    always @(posedge clk) begin
        if (reset) begin
            C_reg <= 64'b0;
        end else begin
            // TODO: finish the connections
        end
    end
endmodule
