`timescale 1ns / 1ps

module top (
    input         CLK100MHZ,  // from Basys 3
    input         btnU,       // up
    input         btnL,       // left
    input         btnR,       // right
    input         btnD,       // down
    input         btnC,       // center
    input  [15:0] sw,         // DIP switch inputs 0-15: reset: 0
    output [ 0:6] seg,        // 7 segment display segment pattern
    output [ 3:0] an,         // 7 segment display anodes
    output [ 1:0] LED,        // LEDs to specify the current display mode
    output        dp          // display dot point
);

    wire input_en, arithm_en;
    wire [15:0] operandA;
    wire [15:0] operandB;
    wire [31:0] result;
    wire [ 1:0] chosen_adder;
    wire [ 1:0] chosen_operand;
    wire input_ready, computation_ready;
    wire [1:0] display_mode;
    wire reset;

    data_input input_control (
        .clk(CLK100MHZ),
        .reset(reset),
        .bt_U(btnU),
        .bt_L(btnL),
        .bt_R(btnR),
        .bt_D(btnD),
        .bt_C(btnC),
        .sw(sw),
        .en(input_en),
        .operandA(operandA),
        .operandB(operandB),
        .chosen_adder(chosen_adder),
        .chosen_operand(chosen_operand),
        .input_ready(input_ready)
    );

    arithm arithm_unit (
        .clk(CLK100MHZ),
        .reset(reset),
        .operandA(operandA),
        .operandB(operandB),
        .chosen_adder(chosen_adder),
        .en(arithm_en),
        .result(result),
        .computation_ready(computation_ready)
    );

    control control_unit (
        .clk(CLK100MHZ),
        .input_ready(input_ready),
        .chosen_adder(chosen_adder),
        .chosen_operand(chosen_operand),
        .computation_ready(computation_ready),
        .input_en(input_en),
        .arithm_en(arithm_en),
        .display_mode(display_mode),
        .reset_out(reset)
    );

    display_top display_unit (
        .clk(CLK100MHZ),
        .reset(reset),  // find a reset button!
        .display_mode(display_mode),
        .chosen_operand(chosen_operand),
        .operandA(operandA),
        .operandB(operandB),
        .an(an),
        .seg(seg),
        .dp(dp)
    );

endmodule
