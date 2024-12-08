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
    wire [15:0] bcd_result;  // Adjusted to match the 40-bit BCD output
    wire conversion_ready;
    reg conversion_done;  // Flag to indicate if conversion has been done

    wire [11:0] selected_result = result_in[11:0];

    assign LEDs_out = LEDs;

    // Instance of the BCD conversion module
    bcd bcd_conversion (
        .CLK100MHz(CLK100MHz),
        .en(select),  // Enable conversion only when there
        .bin_d_in(selected_result),
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
            LEDs <= 2'b00;
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
            conversion_done <= 0;  // Reset conversion done flag
        end else begin
            if (conversion_ready) begin
                // Mark conversion as done
                conversion_done <= 1;

                if (select) begin
                    // Display the result from the BCD conversion
                    if (advance_display) begin
                        // Display the last 4 digits (most significant)
                        LEDs <= 2'b01;
                    end else begin
                        // Display the first 4 digits (least significant)
                        ones <= bcd_result[3:0];
                        tens <= bcd_result[7:4];
                        hundreds <= bcd_result[11:8];
                        thousands <= 0;
                        LEDs <= 2'b00;
                    end
                end
            end else if (!select) begin
                // Reset conversion flag when not in select mode
                conversion_done <= 0;

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
