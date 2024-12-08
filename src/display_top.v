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
    input select,  // Select between displaying the input/result
    input advance_display,  // Advance the display to the next 4 digits
    input [31:0] result_in,
    input [3:0] data_in_ones,  // Digits from data input module
    input [3:0] data_in_tens,
    input [3:0] data_in_hundreds,
    input [3:0] data_in_thousands,
    input deb_U,  // Debounced up button
    input deb_D,  // Debounced down button

    output [3:0] an_out,
    output [6:0] seg_out,
    output [1:0] LEDs_out  // LEDs to specify the current display mode
);

    reg [3:0] ones, tens, hundreds, thousands;
    reg [1:0] display_mode;  // Which 4 digits to display
    wire [39:0] bcd_result;  // Adjusted to match the 16-bit BCD output
    wire conversion_ready;
    reg conversion_done;  // Flag to indicate if conversion has been done
    reg sign;  // Flag to indicate if the number is negative
    reg [31:0] unsigned_result_in;  // Unsigned representation of result_in

    assign LEDs_out = display_mode;

    // Instance of the BCD conversion module
    bcd bcd_conversion (
        .CLK100MHz(CLK100MHz),
        .en(select && (conversion_done == 0)),  // Enable conversion only when needed
        .bin_d_in(unsigned_result_in),
        .bcd_d_out(bcd_result),
        .conversion_ready(conversion_ready)
    );

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

    always @(posedge CLK100MHz or posedge reset) begin

        if (reset) begin
            // Reset all display values and conversion flag
            display_mode <= 2'b00;
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
            conversion_done <= 0;  // Reset conversion done flag
            sign <= 0;  // Reset sign flag
            unsigned_result_in <= 32'b0;  // Reset unsigned result
        end else begin
            // change the display digits
            if (deb_U && (display_mode < 2'b10)) display_mode <= display_mode + 1;
            else if (deb_D && (display_mode > 2'b00)) display_mode <= display_mode - 1;
            else if (deb_C && conversion_done) begin
                display_mode <= 2'b00;  // Reset display mode
                conversion_done <= 0;  // Reset conversion flag
            end


            // Check if the result is negative and convert to unsigned if necessary
            if (result_in[31] == 1) begin
                sign <= 1;
                unsigned_result_in <= ~result_in + 1;  // Two's complement to get the absolute value
            end else begin
                sign <= 0;
                unsigned_result_in <= result_in;
            end

            // Trigger conversion when a new segment is selected
            if (select && !conversion_done) begin
                if (conversion_ready) begin
                    conversion_done <= 1;  // Mark conversion as done
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
            end else if (!select) begin
                // Reset conversion flag when not in select mode
                conversion_done <= 0;

                // Display the input data if not in selection mode
                ones <= data_in_ones;
                tens <= data_in_tens;
                hundreds <= data_in_hundreds;
                thousands <= data_in_thousands;
                display_mode <= 2'b00;  // Reset display mode if displaying input
            end
        end
    end
endmodule
