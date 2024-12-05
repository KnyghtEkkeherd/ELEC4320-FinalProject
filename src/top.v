`timescale 1ns / 1ps

module top (
    input        CLK100MHZ,  // from Basys 3
    //input        reset,      // btnC
    input        btnU,       // up
    input        btnL,       // left
    input        btnR,       // right
    input        btnD,       // down
    input        btnC,       // center
    input        reset,      // DIP switch 0
    input        sw,         // DIP switch inputs 1-15
    output [0:6] seg,        // 7 segment display segment pattern
    output [3:0] an,         // 7 segment display anodes
    output [1:0] LED         // LEDs to specify the current display mode
);

    // Internal wires for connecting inner modules
    wire w_10Hz;
    wire [3:0] data_in_ones, data_in_tens, data_in_hundreds, data_in_sign;
    wire [15:0] input_data_out;
    wire operand_selection;  // specifies whether A or B has been input: A-0, B-1

    // Instantiate inner design modules

    data_input button_input (
        .bt_C(btnC),
        .bt_U(btnU),
        .bt_L(btnL),
        .bt_R(btnR),
        .bt_D(btnD),
        .clk(CLK100MHZ),
        .reset(reset),
        .input_data_out(input_data_out),
        .ones_out(data_in_ones),
        .tens_out(data_in_tens),
        .hundreds_out(data_in_hundreds),
        .sign_out(data_in_sign),
        .operand_selection_out(operand_selection)
    );

    display_top(
        .CLK100MHz(CLK100MHZ),
        .reset(reset),
        .select(1'b0),  // just display the input for now
        .advance_display(sw[1]),  // advance the display to the next 4 digits
        .result_in(32'b0),  // no result to display for now
        .data_in_ones(data_in_ones),
        .data_in_tens(data_in_tens),
        .data_in_hundreds(data_in_hundreds),
        .data_in_thousands(data_in_sign),
        .an_out(an),
        .seg_out(seg),
        .LEDs_out(LED)
    );
endmodule
