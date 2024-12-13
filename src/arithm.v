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

    output reg [15:0] result,
    output reg computation_ready,
    output reg overflow_flag
);
    parameter [1:0] BRENT_KUNG = 2'b01;
    parameter [1:0] KOGGE_STONE = 2'b10;

    wire [15:0] ksa_sum;
    wire ksa_cout;
    wire [16:0] brent_kung_sum;

    kogge_stone_adder16bit KSA (
        .A(operandA),
        .B(operandB),
        .Cin(1'b0),
        .S(ksa_sum),
        .Cout(ksa_cout)
    );

    brent_kung_adder16bit BKU (
        .in1(operandA),
        .in2(operandB),
        .carryIn(1'b0),
        .out(brent_kung_sum)
    );

    // Put the adder modules here:
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result <= 0;
            computation_ready <= 0;
            overflow_flag <= 0;
        end else if (en) begin
            case (chosen_adder)
                BRENT_KUNG: begin
                    result = brent_kung_sum[15:0];
                    overflow_flag = brent;
                    computation_ready = 1;
                end
                KOGGE_STONE: begin
                    result = ksa_sum;
                    overflow_flag = ksa_cout;
                    computation_ready = 1;
                end
                default: begin
                    result <= 0;
                    computation_ready <= 1;
                end
            endcase
        end
    end
endmodule
