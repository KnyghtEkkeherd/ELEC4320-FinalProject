//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module control (
    input clk,
    input input_ready,
    input [1:0] chosen_adder,
    input [1:0] chosen_operand,
    input computation_ready,
    input clear,
    input overflow_flag,

    output reg input_en,
    output reg arithm_en,
    output reg [1:0] display_mode,
    output reg reset_out,
    output reg [15:0] LED
);

    parameter [2:0] INIT = 3'b000;
    parameter [2:0] DATA_IN = 3'b001;
    parameter [2:0] BUSY = 3'b010;
    parameter [2:0] DONE = 3'b011;
    parameter [2:0] DISPLAY_RESULT = 3'b100;

    reg [2:0] state;

    always @(posedge clk) begin
        LED <= {overflow_flag, 12'b0, state};
        case (state)
            INIT: begin
                reset_out <= 1;
                state <= DATA_IN;
                display_mode <= 2'b00;
                input_en <= 0;
                arithm_en <= 0;
                LED <= 16'b0;
            end
            DATA_IN: begin
                reset_out <= 0;
                input_en <= 1;
                display_mode <= 2'b01;
                if (input_ready) begin
                    state <= BUSY;
                    input_en <= 0;
                    arithm_en <= 1;
                end
            end
            BUSY: begin
                if (computation_ready) begin
                    state <= DONE;
                    arithm_en <= 0;
                end
            end
            DONE: begin
                // handle the overflow here potentially
                state <= DISPLAY_RESULT;
            end
            DISPLAY_RESULT: begin
                display_mode <= 2'b10;
                input_en <= 1;
                if (clear) begin
                    state <= INIT;
                    input_en <= 0;
                end
            end
            default: begin
                state <= INIT;
            end
        endcase
    end
endmodule
