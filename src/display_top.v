`timescale 1ns / 1ps

module display_top (
    input CLK100MHz,
    input reset,
    input select,  // Select between displaying the input/result: select 0-input, select 1-result
    input advance_display,  // Advance the display to the next 4 digits
    input [31:0] result_in,
    input [3:0] data_in_ones,  // Digits from data input module
    input [3:0] data_in_tens,
    input [3:0] data_in_hundreds,
    input [3:0] data_in_thousands,

    output [3:0] an_out,
    output [6:0] seg_out,
    output [1:0] LEDs_out  // LEDs to specify the current display mode
);

    reg [3:0] ones, tens, hundreds, thousands;
    reg [1:0] LEDs;
    wire [15:0] bcd_result;
    wire conversion_ready;

    assign LEDs_out = LEDs;

    // Instance of the 7-segment display control module
    seg7_control seg7 (
        .clock(CLK100MHz),
        .reset(reset),
        .ones(ones),
        .tens(tens),
        .hundreds(hundreds),
        .thousands(thousands),
        .LED_segment(seg_out),
        .anode_activation(an_out)
    );

    binary_to_decimal bcd (
        .CLK100MHz(CLK100MHz),
        .reset(reset),
        .en(select),  // enable the module only when the result is ready
        .binary_in(result_in),
        .thousands(bcd_result[15:12]),
        .hundreds(bcd_result[11:8]),
        .tens(bcd_result[7:4]),
        .ones(bcd_result[3:0]),
        .conversion_ready(conversion_ready)
    );

    always @(posedge CLK100MHz or posedge reset) begin
        if (reset) begin
            // Reset all display values
            LEDs <= 2'b00;
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
        end else begin
            if (select && conversion_ready) begin
                // Display the result from the arithmetic module
                if (advance_display) begin
                    // Display the last 4 digits
                    ones <= bcd_result[19:16];
                    tens <= bcd_result[23:20];
                    hundreds <= bcd_result[27:24];
                    thousands <= bcd_result[31:28];
                    LEDs <= 2'b01;
                end else begin
                    // Display the first 4 digits
                    ones <= bcd_result[3:0];
                    tens <= bcd_result[7:4];
                    hundreds <= bcd_result[11:8];
                    thousands <= bcd_result[15:12];
                    LEDs <= 2'b00;
                end
            end else begin
                // Display the input
                ones <= data_in_ones;
                tens <= data_in_tens;
                hundreds <= data_in_hundreds;
                thousands <= data_in_thousands;
                LEDs <= 2'b00;
            end
        end
    end
endmodule
