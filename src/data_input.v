`timescale 1ns / 1ps
`include "control_states.v"
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

// slow clock for the debouncing circuit
module slow_clk (
    input  clk,
    input  reset,
    output slow_clk
);
    // input 100MHz clock
    // output 4Hz clock

    reg [26:0] counter;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter  <= 0;
            slow_clk <= 0;
        end else if (counter == 49999999) begin
            counter  <= 0;
            slow_clk <= ~slow_clk;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule

// Debouncing the button in the data input circuit
module debouncing_circuit (
    input  button_in,
    input  slow_clk,
    input  reset,
    output button_out
);
    reg ff1, ff2;

    assign button_out = ff1 & ~ff2;

    always @(posedge slow_clk) begin
        if (reset) begin
            ff1 <= 0;
            ff2 <= 0;
        end else begin
            ff1 <= button_in;
            ff2 <= ff1;
        end
    end

endmodule

// the main data input circuit
module data_input (
    input [4:0] buttons_in,
    input clk,
    input reset
);

    wire slow_clk_signal;
    reg [4:0] debounced_buttons;

    slow_clk slow_clk_inst (
        .clk(clk),
        .reset(reset)
        .slow_clk(slow_clk_signal)
    );

    always @(posedge clk) begin
        if (reset) begin
            debounced_buttons <= 0;
        end else begin
            debouncing_circuit(buttons_in[0], slow_clk_signal, reset, debounced_buttons[0]);
            debouncing_circuit(buttons_in[1], slow_clk_signal, reset, debounced_buttons[1]);
            debouncing_circuit(buttons_in[2], slow_clk_signal, reset, debounced_buttons[2]);
            debouncing_circuit(buttons_in[3], slow_clk_signal, reset, debounced_buttons[3]);
            debouncing_circuit(buttons_in[4], slow_clk_signal, reset, debounced_buttons[4]);
        end
    end

endmodule
