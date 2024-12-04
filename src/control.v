`timescale 1ns / 1ps
`include "control_states.v"

module control (
    input clk,
    input reset,
    input operation_chosen,
    input computation_ready,
    input display_update,
    input update_done,

    output current_state[1:0]
);
    reg [1:0] current_state;

    always @(posedge clk) begin
        case (current_state)
            `SWITCH_INPUT: begin
                if (reset) begin
                    current_state = `SWITCH_INPUT;
                end else if (operation_chosen) begin
                    current_state = `ARITHM_PROC;
                end else begin
                    current_state = `SWITCH_INPUT;
                end
            end
            `ARITHM_PROC: begin
                if (reset) begin
                    current_state = `SWITCH_INPUT;
                end else if (computation_ready) begin
                    current_state = `RES_PROC;
                end else begin
                    current_state = `ARITHM_PROC;
                end
            end
            `RES_PROC: begin
                if (reset) begin
                    current_state = `SWITCH_INPUT;
                end else if (not_finished) begin
                    current_state = `RES_PROC;
                end else begin
                    current_state = `DISP_UPDATE;
                end
            end
            `DISP_UPDATE: begin
                if (reset) begin
                    current_state = `SWITCH_INPUT;
                end else if (update_done) begin
                    current_state = `SWITCH_INPUT;
                end else begin
                    current_state = `DISP_UPDATE;
                end
            end
            default: begin
                current_state = `SWITCH_INPUT;
            end
        endcase
    end

endmodule
