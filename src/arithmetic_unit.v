`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module arithmetic_unit (
    input [15:0] input_data,
    input operand_selection,
    input [10:0] operation,  // 11 switches, each for one operation
    input CLK100MHz,
    input reset,

    output [31:0] result_out,
    output result_ready_out
);

    reg [15:0] operand_A, operand_B;
    reg [31:0] result;
    reg result_ready;

    assign result_out = result;
    assign result_ready_out = result_ready;

    // only calculate the result when the input changes
    always @(input_data or reset) begin
        if (reset) begin
            operand_A <= 16'b0;
            operand_B <= 16'b0;
            result <= 32'b0;
            result_ready <= 0;
        end else begin
            if (operand_selection == 0) begin
                operand_A <= input_data;
            end else if (operand_selection == 1) begin
                operand_B <= input_data;
            end
        end
        if (result_ready == 0) begin
            case (operation)  // operation switch has to be chosen after the inputs
                11'b10000000000: begin
                    result <= operand_A + operand_B;
                    operand_A <= operand_A;  // refresh operand_A
                    operand_B <= operand_B;  // refresh operand_B
                    result_ready <= 1;
                end
                11'b01000000000: begin
                    result <= operand_A - operand_B;
                    operand_A <= operand_A;  // refresh operand_A
                    operand_B <= operand_B;  // refresh operand_B
                    result_ready <= 1;
                end
                default: begin
                    result <= 32'b0;
                end
            endcase
        end
    end
endmodule
