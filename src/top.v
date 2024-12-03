`timescale 1ns / 1ps

module top (
    input        clk_100MHz,  // from Basys 3
    input        reset,       // btnC
    output [0:6] seg,         // 7 segment display segment pattern
    output [3:0] digit        // 7 segment display anodes
);

    // Internal wires for connecting inner modules
    wire w_10Hz;
    wire [3:0] w_1s, w_10s, w_100s, w_1000s;
    wire sign_signal;

    // Instantiate inner design modules
    tenHz_gen hz10 (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .clk_10Hz(w_10Hz)
    );

    data_input button_input (
        .bt_C(btnC),
        .bt_U(btnU),
        .bt_L(btnL),
        .bt_R(btnR),
        .bt_D(btnD),
        .clk(clk_100MHz),
        .reset(reset),
        .ones_out(w_1s),
        .tens_out(w_10s),
        .hundreds_out(w_100s),
        .sign_out(sign_signal)
    );


    seg7_control seg7 (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .ones(w_1s),
        .tens(w_10s),
        .hundreds(w_100s),
        .thousands(3'b000),  // Change this line later to display the sign
        .seg(seg),
        .digit(digit)
    );

endmodule
