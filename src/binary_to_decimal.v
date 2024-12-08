`timescale 1ns / 1ps
module binary_to_decimal (
    input             CLK100MHz,        // Clock signal
    input             reset,            // Reset signal
    input             en,               // Enable signal
    input      [31:0] binary_in,        // 32-bit binary input
    output reg [ 3:0] thousands,        // Thousands place
    output reg [ 3:0] hundreds,         // Hundreds place
    output reg [ 3:0] tens,             // Tens place
    output reg [ 3:0] ones,             // Ones place
    output reg        conversion_ready  // Indicate conversion is ready
);

    reg [31:0] temp;  // Temporary variable for conversion
    reg [ 4:0] count;  // Counter for 32 iterations
    reg        processing;  // Flag to indicate if processing is ongoing

    // Synchronous logic
    always @(posedge CLK100MHz or posedge reset) begin
        if (reset) begin
            // Reset outputs and temp variable
            thousands <= 0;
            hundreds <= 0;
            tens <= 0;
            ones <= 0;
            temp <= 0;
            count <= 0;
            conversion_ready <= 0;  // Reset conversion ready signal
            processing <= 0;  // Reset processing flag
        end else if (en && !processing) begin
            // Start processing only if enabled and not already processing
            temp             <= binary_in;  // Load the input binary number
            count            <= 0;  // Reset count
            processing       <= 1;  // Set processing flag
            conversion_ready <= 0;  // Reset conversion ready signal
        end else if (processing) begin
            if (count < 32) begin
                // Convert binary to decimal using repeated division by 10
                // Shift left by 1 (multiply by 2)
                thousands <= (thousands << 1) | (hundreds >> 3);
                hundreds <= (hundreds << 1) | (tens >> 3);
                tens <= (tens << 1) | (ones >> 3);
                ones <= (ones << 1) | (temp[31]);

                // If the number is greater than or equal to 10, subtract 10 from it
                if (ones >= 10) begin
                    ones <= ones - 10;
                    tens <= tens + 1;
                end
                if (tens >= 10) begin
                    tens <= tens - 10;
                    hundreds <= hundreds + 1;
                end
                if (hundreds >= 10) begin
                    hundreds  <= hundreds - 10;
                    thousands <= thousands + 1;
                end

                // Shift the temp variable to the right
                temp  <= temp << 1;
                count <= count + 1;  // Increment the count
            end else begin
                // After 32 cycles, mark processing as done
                processing <= 0;  // Clear processing flag
                conversion_ready <= 1;  // Indicate conversion is ready
            end
        end
    end
endmodule
