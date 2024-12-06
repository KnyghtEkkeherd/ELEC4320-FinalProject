`timescale 1ns / 1ps

module display_top (
    input CLK100MHz,
    input reset,
    input select,  // select between displaying the input/result: select 0-input, select 1-result
    input advance_display,  // advance the display to the next 4 digits
    input [31:0] result_in,
    input [3:0] data_in_ones,  // digits from data input module
    input [3:0] data_in_tens,
    input [3:0] data_in_hundreds,
    input [3:0] data_in_thousands,

    output [3:0] an_out,
    output [6:0] seg_out,
    output [1:0] LEDs_out  // LEDs to specify the current display mode
);

    reg [3:0] ones, tens, hundreds, thousands;
    reg [1:0] LEDs;
    wire [3:0] w_1s, w_10s, w_100s, w_1000s;

    assign w_1s = ones;
    assign w_10s = tens;
    assign w_100s = hundreds;
    assign w_1000s = thousands;
    assign LEDs_out = LEDs;

    seg7_control seg7 (
        .clock(CLK100MHz),
        .reset(reset),
        .ones(w_1s),
        .tens(w_10s),
        .hundreds(w_100s),
        .thousands(w_1000s),
        .LED_segment(seg_out),
        .anode_activation(an_out)
    );

    initial begin
        LEDs <= 2'b00;
        ones <= 4'b0000;
        tens <= 4'b0000;
        hundreds <= 4'b0000;
        thousands <= 4'b0000;
    end

    always @(CLK10Hz or reset or select or advance_display or result_in or data_in_ones or data_in_tens or data_in_hundreds or data_in_thousands) begin
        if (reset) begin
            LEDs <= 2'b00;
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
        end else if (select) begin
            // display the result from the arithmetic module
            if (advance_display) begin
                // display the last 4 digits
                ones <= 4'b0010;
                tens <= 4'b0010;
                hundreds <= 4'b0010;
                thousands <= 4'b0010;
                LEDs <= 2'b01;
            end else begin
                // display the first 4 digits
                ones <= 4'b0001;
                tens <= 4'b0001;
                hundreds <= 4'b0001;
                thousands <= 4'b0001;
                LEDs <= 2'b00;
            end

        end else begin
            // display the input
            ones <= data_in_ones;
            tens <= data_in_tens;
            hundreds <= data_in_hundreds;
            thousands <= data_in_thousands;
            LEDs <= 2'b00;
        end
    end

endmodule
