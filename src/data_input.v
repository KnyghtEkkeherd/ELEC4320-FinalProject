`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

// slow clock for the debouncing circuit
module slow_clk (
    input  clk,
    input  reset,
    output slow_clk_out
);
    // input 100MHz clock
    // output 1kHz clock -- change after testing on the real board

    reg [16:0] counter;  // Adjusted counter size to match 1kHz output
    reg slow_clk;
    assign slow_clk_out = slow_clk;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter  <= 0;
            slow_clk <= 0;
        end else if (counter == 49_999) begin
            counter  <= 0;
            slow_clk <= ~slow_clk;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule

// Debouncing the button in the data input circuit
module debouncing_circuit (
    input  button_in,
    input  slow_clk,
    input  reset,
    output button_out
);
    reg ff1, ff2, ff3;

    assign button_out = ff2 & ~ff3;

    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            ff1 <= 0;
            ff2 <= 0;
            ff3 <= 0;
        end else begin
            ff1 <= button_in;
            ff2 <= ff1;
            ff3 <= ff2;
        end
    end

endmodule


// the main data input circuit
module data_input (
    input bt_C,
    input bt_U,
    input bt_L,
    input bt_R,
    input bt_D,
    input clk,
    input reset,

    // outputs to write to BRAM
    output [15:0] input_data_out,
    // outputs to display the digits
    output [3:0] ones_out,
    output [3:0] tens_out,
    output [3:0] hundreds_out,
    output [3:0] sign_out,
    output reg [1:0] operand_selection,  // specifies whether A or B has been input: A-0, B-1
    output deb_C_out,  // output the center button if it's pressed again to clear the result
    output deb_U_out,  // output the left button if it's pressed again to clear the result
    output deb_D_out  // output the right button if it's pressed again to clear the result
);

    wire slow_clk_signal;
    // assign wires to registers from the debouncing circuit
    wire deb_L_out;
    wire deb_R_out;

    reg [15:0] input_data;
    reg [1:0] unit;  // 2 bit unit: thousands, hundreds, tens, ones
    // display outputs
    reg [3:0] ones;
    reg [3:0] tens;
    reg [3:0] hundreds;
    reg [3:0] sign;  // used to show whether the number is positive or negative
    reg [1:0] operand_selection;

    assign input_data_out = input_data;
    assign ones_out = ones;
    assign tens_out = tens;
    assign hundreds_out = hundreds;
    assign sign_out = sign;

    slow_clk slow_clk_inst (
        .clk(clk),
        .reset(reset),
        .slow_clk_out(slow_clk_signal)
    );

    // Debouncing the buttons
    debouncing_circuit deb_C_inst (
        .button_in(bt_C),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_C_out)
    );

    debouncing_circuit deb_L_inst (
        .button_in(bt_L),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_L_out)
    );

    debouncing_circuit deb_R_inst (
        .button_in(bt_R),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_R_out)
    );

    debouncing_circuit deb_U_inst (
        .button_in(bt_U),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_U_out)
    );

    debouncing_circuit deb_D_inst (
        .button_in(bt_D),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_D_out)
    );

    // Handle the data input
    initial begin
        input_data <= 0;
        unit <= 0;
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        sign <= 0;
        operand_selection <= 0;  // operand A is the first one after reset or init
    end

    always @(posedge slow_clk_signal or posedge reset) begin
        // Handle the displaying and storing of the input data
        if (reset) begin
            input_data <= 0;
            unit <= 0;
            ones <= 0;
            tens <= 0;
            hundreds <= 0;
            sign <= 0;
            operand_selection <= 0;
        end else begin
            if (deb_C_out) begin
                input_data <= 0;
                unit <= 0;
                ones <= 0;
                tens <= 0;
                hundreds <= 0;
                sign <= 0;

                // confirm inputs A and B
                if (operand_selection < 2) begin
                    operand_selection <= operand_selection + 1;
                end
            end else if (deb_L_out) begin
                // disregard the thousands place -- just decide whether it is positive or negative
                if (unit < 4) begin
                    unit <= unit + 1;
                end else begin
                    unit <= 0;
                end
            end else if (deb_R_out) begin
                if (unit > 0) begin
                    unit <= unit - 1;
                end else begin
                    unit <= 3;
                end
            end else if (deb_U_out) begin
                // Increment of input_data
                if (unit == 0 && ones < 9) begin
                    input_data <= input_data + 1;
                    ones <= ones + 1;
                end else if (unit == 1 && tens < 9) begin
                    input_data <= input_data + 10;
                    tens <= tens + 1;
                end else if (unit == 2 && hundreds < 9) begin
                    input_data <= input_data + 100;
                    hundreds   <= hundreds + 1;
                end else if (unit == 3) begin
                    case (sign)
                        4'b1010: sign <= 4'b0000;
                        4'b0000: sign <= 4'b1010;
                        default: sign <= 4'b0000;
                    endcase
                    input_data <= -input_data;
                end
            end else if (deb_D_out) begin
                // Decrement of input_data
                if (unit == 0 && ones > 0) begin
                    input_data <= input_data - 1;
                    ones <= ones - 1;
                end else if (unit == 1 && tens > 0) begin
                    input_data <= input_data - 10;
                    tens <= tens - 1;
                end else if (unit == 2 && hundreds > 0) begin
                    input_data <= input_data - 100;
                    hundreds   <= hundreds - 1;
                end else if (unit == 3) begin
                    case (sign)
                        4'b1010: sign <= 4'b0000;
                        4'b0000: sign <= 4'b1010;
                        default: sign <= 4'b0000;
                    endcase
                    input_data <= -input_data;
                end
            end
        end
    end
endmodule
