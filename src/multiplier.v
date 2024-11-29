`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module multiplier (
    input [31:0] A,
    input [31:0] B,
    input clk,
    input reset,
    output [63:0] P
);

    reg [63:0] product;
    assign P = product;

    initial begin
        product <= 64'b0;
    end

    always @(posedge clk) begin
        if (reset) begin
            product <= 64'b0;
        end else begin

        end
    end

endmodule
