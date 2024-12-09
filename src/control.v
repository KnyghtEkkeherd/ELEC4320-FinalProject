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
    input conversion_ready,

    output reg reset_out,
    output reg [1:0] select_out,
    output reg [1:0] display_mode_out,
    output reg conversion_en
);
    parameter [2:0] INIT = 3'b000;
    parameter [2:0] DATA_INPUT = 3'b001;
    parameter [2:0] ARITHM = 3'b010;
    parameter [2:0] DISPLAY_RES = 3'b011;
    reg [2:0] state;

    parameter INT = 1'b0;
    parameter FLOAT = 1'b1;
    reg result_type;

    reg [2:0] deb_C_counter;
    reg conversion_done;

    reg deb_U_prev, deb_D_prev, deb_C_prev, deb_L_prev, deb_R_prev;

    always @(posedge CLK100MHz) begin
        if (sw[0]) begin
            state <= INIT;
            reset_out <= 1;
            deb_C_counter <= 0;
            select_out <= 0;
            display_mode_out <= 0;
            result_type <= 0;
            conversion_done <= 0;
            deb_U_prev <= 0;
            deb_D_prev <= 0;
            deb_C_prev <= 0;
            deb_L_prev <= 0;
            deb_R_prev <= 0;
        end
        case (state)
            INIT: begin
                state <= DATA_INPUT;
                reset_out <= 1;
                deb_C_counter <= 0;
                select_out <= 0;
                display_mode_out <= 0;
                result_type <= 0;
                conversion_done <= 0;
                deb_U_prev <= 0;
                deb_D_prev <= 0;
                deb_C_prev <= 0;
                deb_L_prev <= 0;
                deb_R_prev <= 0;
            end
            DATA_INPUT: begin
                reset_out <= 0;
                if (deb_C && !deb_C_prev) begin
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
                    11'b10000000000: result_type <= INT;  // ADD
                    11'b01000000000: result_type <= INT;  // SUB
                    11'b00100000000: result_type <= INT;  // MUL
                    11'b00010000000: result_type <= FLOAT;  // DIV
                    11'b00001000000: result_type <= FLOAT;  // SQRT
                    11'b00000100000: result_type <= FLOAT;  // SIN
                    11'b00000010000: result_type <= FLOAT;  // COS
                    11'b00000001000: result_type <= FLOAT;  // TAN
                    11'b00000000100: result_type <= FLOAT;  // LOG
                    11'b00000000010: result_type <= INT;  // POW
                    11'b00000000001: result_type <= FLOAT;  // EXP
                    default: result_type <= INT;
                endcase
                if (result_ready_in) begin
                    state <= DISPLAY_RES;
                end
            end
            DISPLAY_RES: begin
                if (deb_C && !deb_C_prev) begin
                    state <= INIT;
                end else if (!conversion_done) begin
                    conversion_en <= 1;
                    if (conversion_ready) begin
                        conversion_done <= 1;
                        conversion_en   <= 0;
                    end
                end else if (conversion_done) begin
                    if (deb_U && !deb_U_prev) display_mode_out <= display_mode_out + 1;

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

        deb_U_prev <= deb_U;
        deb_D_prev <= deb_D;
        deb_C_prev <= deb_C;
        deb_L_prev <= deb_L;
        deb_R_prev <= deb_R;
    end
endmodule
