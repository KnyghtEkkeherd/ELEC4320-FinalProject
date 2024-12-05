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
    wire CLK10Hz;

    assign w_1s = ones;
    assign w_10s = tens;
    assign w_100s = hundreds;
    assign w_1000s = thousands;
    assign LEDs_out = LEDs;

    tenHz_gen hz10 (
        .clk_100MHz(CLK100MHZ),
        .reset(reset),
        .clk_10Hz(CLK10Hz)
    );

    seg7_control seg7 (
        .clock(CLK10Hz),
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
    end

    always @(posedge clk10Hz or posedge reset) begin
        if (reset) begin
            LEDs <= 2'b00;
        end else if (select) begin
            // display the result from the arithmetic module
            if (dadvance_display) begin
                // display the last 4 digits
                ones <= (result_in[19:16] <= 9) ? result_in[19:16] : 4'b0000;
                tens <= (result_in[23:20] <= 9) ? result_in[23:20] : 4'b0000;
                hundreds <= (result_in[27:24] <= 9) ? result_in[27:24] : 4'b0000;
                thousands <= (result_in[31:28] <= 9) ? result_in[31:28] : 4'b0000;
                LEDs <= 2'b01;
            end else begin
                // display the first 4 digits
                ones <= (result_in[3:0] <= 9) ? result_in[3:0] : 4'b0000;
                tens <= (result_in[7:4] <= 9) ? result_in[7:4] : 4'b0000;
                hundreds <= (result_in[11:8] <= 9) ? result_in[11:8] : 4'b0000;
                thousands <= (result_in[15:12] <= 9) ? result_in[15:12] : 4'b0000;
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
