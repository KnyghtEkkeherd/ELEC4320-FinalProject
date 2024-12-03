`timescale 1ns / 1ps

module top (
    input        CLK100MHZ,  // from Basys 3
    input        reset,      // btnC
    input        btnU,       // up
    input        btnL,       // left
    input        btnR,       // right
    input        btnD,       // down
    input        btnC,       // center
    output [0:6] seg,        // 7 segment display segment pattern
    output [3:0] digit       // 7 segment display anodes
);

    // Internal wires for connecting inner modules
    wire w_10Hz;
    wire [3:0] w_1s, w_10s, w_100s, w_1000s;
    wire sign_signal;

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
        .ones_out(w_1s),
        .tens_out(w_10s),
        .hundreds_out(w_100s),
        .sign_out(sign_signal)
    );


    seg7_control seg7 (
        .clock(CLK100MHZ),
        .reset(reset),
        .ones(w_1s),
        .tens(w_10s),
        .hundreds(w_100s),
        .thousands(3'b000),  // Change this line later to display the sign
        .LED_segment(seg),
        .anode_activation(digit)
    );

endmodule
