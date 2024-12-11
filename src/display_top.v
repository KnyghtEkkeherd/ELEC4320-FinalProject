`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////


module display_top (
    input clk,
    input reset,
    input [1:0] display_mode,
    input [1:0] chosen_operand,
    input [15:0] operandA,
    input [15:0] operandB,
    input [31:0] result,

    output [3:0] an,
    output [6:0] seg,
    output dp
);
    reg [3:0] hex_0, hex_1, hex_2, hex_3;
    wire [3:0] ones, tens, hundreds, thousands;
    reg [2:0] dot;

    assign ones = hex_0;
    assign tens = hex_1;
    assign hundreds = hex_2;
    assign thousands = hex_3;

    parameter OPERAND_A = 2'b01;
    parameter OPERAND_B = 2'b10;

    seg7_control seg7 (
        .clk(clk),
        .reset(reset),
        .dot(dot),
        .ones(ones),
        .tens(tens),
        .hundreds(hundreds),
        .thousands(thousands),
        .LED_segment(seg),
        .anode_activation(an),
        .dp(dp)
    );

    always @(posedge clk) begin
        dot <= 0;
        if (reset) begin
            hex_0 <= 4'b0000;
            hex_1 <= 4'b0000;
            hex_2 <= 4'b0000;
            hex_3 <= 4'b0000;
            dot   <= 0;
        end
        case (display_mode)
            2'b00: begin
                hex_0 <= 4'b0000;
                hex_1 <= 4'b0000;
                hex_2 <= 4'b0000;
                hex_3 <= 4'b0000;
            end
            2'b01: begin
                case (chosen_operand)
                    OPERAND_A: begin
                        hex_0 <= operandA[3:0];  // Bits 0 to 3
                        hex_1 <= operandA[7:4];  // Bits 4 to 7
                        hex_2 <= operandA[11:8];  // Bits 8 to 11
                        hex_3 <= operandA[15:12];  // Bits 12 to 15
                    end
                    OPERAND_B: begin
                        hex_0 <= operandB[3:0];  // Bits 0 to 3
                        hex_1 <= operandB[7:4];  // Bits 4 to 7
                        hex_2 <= operandB[11:8];  // Bits 8 to 11
                        hex_3 <= operandB[15:12];  // Bits 12 to 15
                    end
                    default: begin
                        hex_0 <= 4'b0000;
                        hex_1 <= 4'b0000;
                        hex_2 <= 4'b0000;
                        hex_3 <= 4'b0000;
                    end
                endcase
            end
            2'b10: begin
                // display the result
                hex_0 <= result[3:0];  // Bits 0 to 3
                hex_1 <= result[7:4];  // Bits 4 to 7
                hex_2 <= result[11:8];  // Bits 8 to 11
                hex_3 <= result[15:12];  // Bits 12 to 15
            end
            default: begin
                hex_0 <= 4'b0000;
                hex_1 <= 4'b0000;
                hex_2 <= 4'b0000;
                hex_3 <= 4'b0000;
            end
        endcase

    end
endmodule
