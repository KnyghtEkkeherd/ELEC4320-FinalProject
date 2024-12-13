`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

// slow clock for the debouncing circuit
module slow_clk (
    input  clk,
    input  reset,
    output slow_clk_out
);
    // input 100MHz clock
    // output 1kHz clock -- change after testing on the real board

    reg [16:0] counter;  // Adjusted counter size to match 1kHz output
    reg slow_clk;
    assign slow_clk_out = slow_clk;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter  <= 0;
            slow_clk <= 0;
        end else if (counter == 49_999) begin
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
    reg ff1, ff2, ff3;

    assign button_out = ff2 & ~ff3;

    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            ff1 <= 0;
            ff2 <= 0;
            ff3 <= 0;
        end else begin
            ff1 <= button_in;
            ff2 <= ff1;
            ff3 <= ff2;
        end
    end

endmodule


// the main data input circuit
module data_input (
    input bt_C,
    input bt_U,
    input bt_L,
    input bt_R,
    input bt_D,
    input [15:0] sw,
    input clk,
    input reset,
    input en,
    output reg [15:0] operandA,
    output reg [15:0] operandB,
    output reg [1:0] chosen_adder,
    output reg [1:0] chosen_operand,
    output reg input_ready,
    output reg clear
);

    wire slow_clk_signal;
    wire deb_C_out;
    wire deb_L_out;
    wire deb_R_out;
    wire deb_U_out;
    wire deb_D_out;

    parameter BRENT_KUNG = 2'b01;
    parameter KOGGE_STONE = 2'b10;
    parameter OPERAND_A = 2'b01;
    parameter OPERAND_B = 2'b10;



    slow_clk slow_clk_inst (
        .clk(clk),
        .reset(reset),
        .slow_clk_out(slow_clk_signal)
    );

    // Debouncing the buttons
    debouncing_circuit deb_C_inst (
        .button_in(bt_C),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_C_out)
    );

    debouncing_circuit deb_L_inst (
        .button_in(bt_L),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_L_out)
    );

    debouncing_circuit deb_R_inst (
        .button_in(bt_R),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_R_out)
    );

    debouncing_circuit deb_U_inst (
        .button_in(bt_U),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_U_out)
    );

    debouncing_circuit deb_D_inst (
        .button_in(bt_D),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_D_out)
    );

    always @(posedge slow_clk_signal or posedge reset) begin
        if (reset) begin
            operandA <= 16'b0;
            operandB <= 16'b0;
            chosen_adder <= 2'b00;
            input_ready <= 0;
            chosen_operand <= 0;
            clear <= 0;
        end else if (en) begin
            if (deb_U_out) begin
                chosen_adder <= BRENT_KUNG;
                clear <= 0;
            end else if (deb_C_out) begin
                chosen_adder <= KOGGE_STONE;
                if (clear) clear <= 0;  // clear the result and go back to the input state
                else clear <= 1;
            end else if (deb_D_out) begin
                operandA <= sw;
                chosen_operand <= OPERAND_A;
                clear <= 0;
            end else if (deb_L_out) begin
                operandB <= sw;
                chosen_operand <= OPERAND_B;
                clear <= 0;
            end else if (deb_R_out) begin
                input_ready <= 1;
                clear <= 0;
            end
        end
    end
endmodule
