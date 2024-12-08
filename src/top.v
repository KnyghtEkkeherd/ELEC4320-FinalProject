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
    output [ 1:0] LED         // LEDs to specify the current display mode
);

    // Internal wires
    wire w_10Hz;
    wire [3:0] data_in_ones, data_in_tens, data_in_hundreds, data_in_sign;
    wire [15:0] input_data_out;
    wire [ 1:0] operand_selection;  // 0:A is being input, 1:B is being input, 2:ready to compute
    wire        reset = sw[0];  // Assign sw[0] to reset
    wire        advance_display = sw[1];  // show the next 4 digits
    wire [31:0] result;
    wire        result_ready;
    wire [10:0] operation = sw[15:5];  // 11 switches, each for one operation
    wire deb_C_out, deb_U_out, deb_D_out;

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
        .operand_selection(operand_selection),
        .deb_C_out(deb_C_out),
        .deb_U_out(deb_U_out),
        .deb_D_out(deb_D_out)
    );

    arithmetic_unit arith_unit (
        .input_data(input_data_out),
        .operand_selection(operand_selection),
        .operation(operation),
        .CLK100MHz(CLK100MHZ),
        .reset(reset),
        .result_out(result),
        .result_ready_out(result_ready),
        .deb_C(deb_C_out)
    );

    display_top disp_top (
        .CLK100MHz(CLK100MHZ),
        .reset(reset),
        .select(result_ready),  // if result is ready, display it. If not, display the current input
        .advance_display(advance_display),  // advance the display to the next 4 digits
        .result_in(result),  // no result to display for now
        .data_in_ones(data_in_ones),
        .data_in_tens(data_in_tens),
        .data_in_hundreds(data_in_hundreds),
        .data_in_thousands(data_in_sign),
        .deb_U(deb_U_out),  // buttons used for advancing the display
        .deb_D(deb_D_out),
        .an_out(an),
        .seg_out(seg),
        .LEDs_out(LED)
    );
endmodule
