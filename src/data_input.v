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
    // output 1Hz clock

    reg [26:0] counter;
    reg slow_clk;
    assign slow_clk_out = slow_clk;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter  <= 0;
            slow_clk <= 0;
        end else if (counter == 49999999) begin
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
    reg ff1, ff2;

    assign button_out = ff1 & ~ff2;

    always @(posedge slow_clk) begin
        if (reset) begin
            ff1 <= 0;
            ff2 <= 0;
        end else begin
            ff1 <= button_in;
            ff2 <= ff1;
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

    // output data to be displayed to the 7-segment display
    output [3:0] ones_out,
    output [3:0] tens_out,
    output [3:0] hundreds_out,
    output sign_out  // sign signal of the inputs
);

    wire slow_clk_signal;
    // debounced values of the buttons
    reg deb_C;
    reg deb_L;
    reg deb_R;
    reg deb_U;
    reg deb_D;
    reg [15:0] input_data;  // 16 bit input data
    reg input_status;  // 0-A, 1-B
    reg [1:0] unit;  // 2 bit unit: thousands, hundreds, tens, ones

    // display outputs
    reg [3:0] ones;
    reg [3:0] tens;
    reg [3:0] hundreds;
    reg sign;  // used to show whether the number is positive or negative

    assign ones_out = ones;
    assign tens_out = tens;
    assign hundreds_out = hundreds;
    assign sign_out = sign;

    blk_mem_gen_0 BRAMROM (
        .clka (clk),
        .wea  (1'b1),                  // Write enable
        .addra(input_status ? 1 : 0),  // Address: 0 for A, 1 for B
        .dina (input_data),            // Data input
        .ena  (1'b1)                   // Enable the BRAM
    );

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
        .button_out(deb_C)
    );

    debouncing_circuit deb_L_inst (
        .button_in(bt_L),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_L)
    );

    debouncing_circuit deb_R_inst (
        .button_in(bt_R),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_R)
    );

    debouncing_circuit deb_U_inst (
        .button_in(bt_U),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_U)
    );

    debouncing_circuit deb_D_inst (
        .button_in(bt_D),
        .slow_clk(slow_clk_signal),
        .reset(reset),
        .button_out(deb_D)
    );
    // TODO: write code that keeps track of what has been input for ones, tens, hundreds, and thousands so that we can display it later without doing arithmetic
    // Handle the data input
    always @(bt_C or bt_U or bt_L or bt_R or bt_D or reset) begin
        // Handle the displaying and storing of the input data
        if (reset) begin
            // flush debounced button registers
            deb_C <= 0;
            deb_U <= 0;
            deb_L <= 0;
            deb_R <= 0;
            deb_D <= 0;
            input_data <= 0;
            input_status <= 0;
            unit <= 0;

            // flush the registers that take count of the digits
            ones <= 0;
            tens <= 0;
            hundreds <= 0;
            sign <= 0;  // thousands 0-positive, 1-negative
        end else begin
            if (bt_C) begin
                input_status <= ~input_status;
            end else if (bt_L) begin
                // disregard the thousands place -- just decide whether it is positive or negative
                if (unit < 4) begin
                    unit <= unit + 1;
                end else begin
                    unit <= 0;
                end
            end else if (bt_R) begin
                if (unit > 0) begin
                    unit <= unit - 1;
                end else begin
                    unit <= 4;
                end
            end else if (bt_U) begin
                // Increment of input_data
                if (unit == 0 && ones <= 9) begin
                    if (input_data < 999) begin
                        input_data <= input_data + 1;
                        ones <= ones + 1;
                    end
                end else if (unit == 1 && tens <= 9) begin
                    if (input_data <= 989) begin
                        input_data <= input_data + 10;
                        tens <= tens + 1;
                    end
                end else if (unit == 2 && hundreds <= 9) begin
                    if (input_data <= 899) begin
                        input_data <= input_data + 100;
                        hundreds   <= hundreds + 1;
                    end
                end else if (unit == 3) begin
                    sign <= ~sign;
                    input_data <= -input_data;
                end
            end else if (bt_D) begin
                // Decrement of input_data
                if (unit == 0 && ones > 0) begin
                    if (input_data > -999) begin
                        input_data <= input_data - 1;
                        ones <= ones - 1;
                    end
                end else if (unit == 1 && tens > 0) begin
                    if (input_data >= -989) begin
                        input_data <= input_data - 10;
                        tens <= tens - 1;
                    end
                end else if (unit == 2 && hundreds > 0) begin
                    if (input_data >= -899) begin
                        input_data <= input_data - 100;
                        hundreds   <= hundreds - 1;
                    end
                end else if (unit == 3) begin
                    sign <= ~sign;
                    input_data <= -input_data;
                end
            end
        end
    end
endmodule
