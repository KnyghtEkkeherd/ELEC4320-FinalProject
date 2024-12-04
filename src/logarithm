module Logarithm(
    input signed [15:0] A,        // Input value to compute the logarithm
    input signed [15:0] B,        // Base for the logarithm
    input clk,                    // Clock signal
    input clear,                  // Clear signal to reset outputs
    input reset,                  // Reset signal to initialize the module
    output reg signed [31:0] C,   // Output for the logarithm result
    output reg ready              // Signal indicating readiness of the result
);
    reg [31:0] log_result;        // Variable to store the logarithm result
    reg [4:0] count;              // Counter to track division iterations
    reg [15:0] temp_A;            // Temporary storage for input A during calculations
    reg calculating;              // Flag to indicate if calculation is in progress

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers and outputs
            C <= 0;                
            ready <= 0;
            calculating <= 0;
            count <= 0;
        end else if (clear) begin
            // Clear outputs and reset state
            C <= 0;                
            ready <= 0;
            calculating <= 0;
            count <= 0;
        end else if (A > 0 && B > 0 && !calculating) begin
            // Start calculation if A and B are positive and not already calculating
            temp_A <= A;
            log_result <= 0;
            count <= 0;
            calculating <= 1;      // Set calculating flag
            ready <= 0;            // Not ready until calculation is complete
        end else if (calculating) begin
            // Continue calculating logarithm using repeated division
            if (temp_A >= B) begin
                temp_A <= temp_A / B;   // Divide temp_A by B
                log_result <= log_result + 1; // Increment log result
                count <= count + 1;     // Increment count
            end else begin
                // Calculation complete; set output and ready flag
                C <= log_result;        
                ready <= 1;             
                calculating <= 0;       // Clear calculating flag
            end
        end
    end
endmodule