`timescale 1ns / 1ps
`include "adder.v"
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
// Little Endian 32-bit multiplier
//////////////////////////////////////////////////////////////////////////////////

module multiplier (
    input [31:0] A,
    input [31:0] B,
    input clk,
    input clear,
    input reset,
    output [63:0] C,
    output reg ready
);
    reg [31:0] A_reg;
    reg [31:0] B_reg;
    reg [63:0] C_reg;
    reg [ 4:0] count;
    assign C = C_reg;

    always @(posedge clk) begin
        if (reset || clear) begin
            A_reg <= A;
            B_reg <= B;
            C_reg <= 64'b0;
            count <= 5'b0;
            ready <= 1'b0;
        end else if (count < 32) begin
            if (B_reg[0] == 1) begin
                C_reg <= C_reg + A_reg;
            end

            C_reg <= C_reg >> 1;
            B_reg <= B_reg >> 1;
            count <= count + 1;
        end else begin
            ready <= 1'b1;
        end

    end

endmodule
