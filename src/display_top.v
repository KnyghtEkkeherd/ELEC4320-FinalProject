`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

// TODO:
// handle the display of negative numbers
// handle the display of numbers larger than 9999 -> enable switches to change the display mode -> fix it
// handle the display of decimal values
module display_top (
    input CLK100MHz,
    input reset,
    input [1:0] select,  // Select between displaying the input/result
    input [31:0] result_in,
    input [3:0] data_in_ones,  // Digits from data input module
    input [3:0] data_in_tens,
    input [3:0] data_in_hundreds,
    input [3:0] data_in_thousands,
    input [1:0] display_mode,
    input conversion_en,

    output reg conversion_ready,
    output [3:0] an_out,
    output [6:0] seg_out,
    output [1:0] LEDs_out,  // LEDs to specify the current display mode
    output dp
);

    reg [3:0] ones, tens, hundreds, thousands;
    reg [2:0] dot;  // index of the display dot point
    wire [39:0] bcd_result;  // Adjusted to match the 16-bit BCD output
    wire conversion_ready;
    reg conversion_done;  // Flag to indicate if conversion has been done
    reg sign;  // Flag to indicate if the number is negative
    reg [31:0] unsigned_result_in;  // Unsigned representation of result_in

    assign LEDs_out = display_mode;

    // Instance of the BCD conversion module
    bcd bcd_conversion (
        .CLK100MHz(CLK100MHz),
        .en(conversion_en),
        .bin_d_in(unsigned_result_in),
        .bcd_d_out(bcd_result),
        .conversion_ready(conversion_ready)
    );

    // Instance of the 7-segment display control module
    seg7_control seg7 (
        .clock(CLK100MHz),
        .reset(reset),
        .dot(dot),
        .ones(ones),
        .tens(tens),
        .hundreds(hundreds),
        .thousands(thousands),
        .LED_segment(seg_out),
        .anode_activation(an_out),
        .dp(dp)
    );

    always @(posedge CLK100MHz or posedge reset) begin

        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
            sign <= 0;  // Reset sign flag
            unsigned_result_in <= 32'b0;  // Reset unsigned result
        end else begin
            // Check if the result is negative and convert to unsigned if necessary
            if (result_in[31] == 1) begin
                sign <= 1;
                unsigned_result_in <= ~result_in + 1;  // Two's complement to get the absolute value
            end else begin
                sign <= 0;
                unsigned_result_in <= result_in;
            end

            // Display (large) integer values
            case (select)
                2'b00: begin
                    // Display the input data if not in selection mode
                    ones <= data_in_ones;
                    tens <= data_in_tens;
                    hundreds <= data_in_hundreds;
                    thousands <= data_in_thousands;
                    dot <= 3'b000;  // disable the dot
                end
                2'b01: begin
                    // Display the integer values
                    case (display_mode)
                        2'b00: begin
                            ones <= bcd_result[3:0];
                            tens <= bcd_result[7:4];
                            hundreds <= bcd_result[11:8];
                            thousands <= bcd_result[15:12];
                        end
                        2'b01: begin
                            ones <= bcd_result[19:16];
                            tens <= bcd_result[23:20];
                            hundreds <= bcd_result[27:24];
                            thousands <= bcd_result[31:28];
                        end
                        2'b10: begin
                            ones <= bcd_result[35:32];
                            tens <= bcd_result[39:36];
                            hundreds <= 0;
                            if (sign) thousands <= 4'b1001;  // Display a negative sign at the front
                            else thousands <= 4'b0000;
                        end
                        default: begin
                            ones <= 4'b0000;
                            tens <= 4'b0000;
                            hundreds <= 4'b0000;
                            thousands <= 4'b0000;
                        end
                    endcase
                end
                2'b10: begin
                    // Display the float result
                    ones <= 4'b1010;  // "-"
                    tens <= 4'b1010;
                    hundreds <= 4'b1010;
                    thousands <= 4'b1010;
                    dot <= 3'b010;  // point for tens place
                end
                default: begin
                    ones <= 4'b0000;
                    tens <= 4'b0000;
                    hundreds <= 4'b0000;
                    thousands <= 4'b0000;
                    dot <= 3'b000;  // disable the dot
                end
            endcase
        end
    end
endmodule
