`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

// todo: finish the control
module control (
    input CLK100MHz,
    input [15:0] sw,
    input deb_U,
    input deb_D,
    input deb_C,
    input deb_L,
    input deb_R,
    input result_ready_in,
    input [10:0] operation_in,
    input operand_selection_in,

    output reg reset_out,
    output reg [1:0] select_out,
    output reg [1:0] display_mode_out
);
    parameter INIT = 3'b000;
    parameter DATA_INPUT = 3'b001;
    parameter ARITHM = 3'b010;
    parameter DISPLAY_RES = 3'b011;
    reg [2:0] state;

    parameter INT = 1'b0;
    parameter FLOAT = 1'b1;
    reg result_type;

    reg [2:0] deb_C_counter;

    always @(posedge CLK100MHz) begin
        if (sw[0]) begin
            state <= INIT;
            reset_out <= 1;
            deb_C_counter <= 0;
            select_out <= 0;
            display_mode_out <= 0;
            result_type <= 0;
        end
        case (state)
            INIT: begin
                state <= DATA_INPUT;
                reset_out <= 1;
                deb_C_counter <= 0;
                select_out <= 0;
                display_mode_out <= 0;
                result_type <= 0;
            end
            DATA_INPUT: begin
                reset_out <= 0;
                if (deb_C) begin
                    if (deb_C_counter < 3) begin
                        state <= ARITHM;
                        deb_C_counter <= 0;
                    end else begin
                        deb_C_counter <= deb_C_counter + 1;
                    end
                end
                select_out <= 2'b00;
                display_mode_out <= 2'b00;
            end
            ARITHM: begin
                case (operation_in)
                    11'b10000000000: result_type <= INT;
                    11'b01000000000: result_type <= INT;
                    11'b00100000000: result_type <= INT;
                    11'b00010000000: result_type <= FLOAT;
                    11'b00001000000: result_type <= FLOAT;
                    11'b00000100000: result_type <= FLOAT;
                    11'b00000010000: result_type <= FLOAT;
                    11'b00000001000: result_type <= FLOAT;
                    11'b00000000100: result_type <= FLOAT;
                    11'b00000000010: result_type <= INT;
                    11'b00000000001: result_type <= FLOAT;
                    default: result_type <= INT;
                endcase
                if (result_ready_in) begin
                    state <= DISPLAY_RES;
                end
            end
            DISPLAY_RES: begin
                if (deb_C) begin
                    state <= INIT;
                end else begin
                    if (deb_U && (display_mode_out < 2'b10))
                        display_mode_out <= display_mode_out + 1;
                    else if (deb_D && (display_mode_out > 2'b00))
                        display_mode_out <= display_mode_out - 1;
                    case (result_type)
                        INT: begin
                            select_out <= 2'b01;
                        end
                        FLOAT: begin
                            select_out <= 2'b10;
                        end
                        default: begin
                            select_out <= 2'b01;
                        end
                    endcase
                end
            end
            default: begin
                state <= INIT;
            end
        endcase
    end
endmodule
