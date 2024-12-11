`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module arithm (
    input [15:0] operandA,
    input [15:0] operandB,
    input clk,
    input reset,
    input [1:0] chosen_adder,
    input en,

    output reg [31:0] result,
    output reg computation_ready,
    output reg overflow_flag
);
    parameter CARRY_SKIP = 2'b00;
    parameter BRENT_KUNG = 2'b01;
    parameter KOGGE_STONE = 2'b10;
    parameter CARRY_SELECT = 2'b11;

    // Put the adder modules here:
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result <= 0;
            computation_ready <= 0;
            overflow_flag <= 0;
        end else if (en) begin
            case (chosen_adder)
                CARRY_SKIP: begin
                    result <= operandA + operandB;
                    computation_ready <= 1;
                end
                BRENT_KUNG: begin
                    result <= operandA + operandB;
                    computation_ready <= 1;
                end
                KOGGE_STONE: begin
                    result <= operandA + operandB;
                    computation_ready <= 1;
                end
                CARRY_SELECT: begin
                    result <= operandA + operandB;
                    computation_ready <= 1;
                end
                default: begin
                    result <= operandA + operandB;
                    computation_ready <= 1;
                end
            endcase
        end
    end
endmodule
