`timescale 1ns / 1ps

module top (
    input        CLK100MHZ,  // from Basys 3
    //input        reset,      // btnC
    input        btnU,       // up
    input        btnL,       // left
    input        btnR,       // right
    input        btnD,       // down
    input        btnC,       // center
    input        reset,
    output [0:6] seg,        // 7 segment display segment pattern
    output [3:0] an          // 7 segment display anodes
);

    // Internal wires for connecting inner modules
    wire w_10Hz;
    wire [3:0] w_1s, w_10s, w_100s, w_1000s, sign_signal;
    wire [15:0] input_data_out;
    wire operand_selection;  // specifies whether A or B has been input: A-0, B-1

    // Instantiate inner design modules
    tenHz_gen hz10 (
        .clk_100MHz(CLK100MHZ),
        .reset(reset),
        .clk_10Hz(w_10Hz)
    );

    data_input button_input (
        .bt_C(btnC),
        .bt_U(btnU),
        .bt_L(btnL),
        .bt_R(btnR),
        .bt_D(btnD),
        .clk(CLK100MHZ),
        .reset(reset),
        .input_data_out(input_data_out),
        .ones_out(w_1s),
        .tens_out(w_10s),
        .hundreds_out(w_100s),
        .sign_out(sign_signal),
        .operand_selection_out(operand_selection)
    );

    seg7_control seg7 (
        .clock(CLK100MHZ),
        .reset(reset),
        .ones(w_1s),
        .tens(w_10s),
        .hundreds(w_100s),
        .thousands({3'b000, sign_signal}),
        .LED_segment(seg),
        .anode_activation(an)
    );

endmodule
