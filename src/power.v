// THIS DOES NOT WORK - TRY USING DEBUG STATEMENTS TO SEE WHAT'S GOING WRONG

`timescale 1ns / 1ps
`include multiplier.v

module power (
    input signed [15:0] A,
    input signed [15:0] B,
    input clk,
    input clear,
    input reset,
    output reg signed [31:0] C,
    output reg ready
);
    reg signed [15:0] temp; // Intermediate storage for multiplication
    reg [15:0] count; // Counter for the exponentiation process
    wire signed [31:0] product; // Output of the signed_multiplier
    wire multiplier_ready_signal; // Ready signal from signed_multiplier

    // Instance of signed_multiplier
    signed_multiplier multiplier (
        .A(temp),
        .B(A),
        .clk(clk),
        .clear(clear),
        .reset(reset),
        .C(product),
        .ready(multiplier_ready_signal)
    );

    // State machine process
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            C <= 32'b0;
            ready <= 1'b0;
            count <= 16'b0;
            temp <= 16'b1; // Initialize temp to 1
        end else if (clear) begin
            C <= 32'b0;
            ready <= 1'b0;
            count <= 16'b0;
            temp <= 16'b1; // Reset temp
        end else if (!ready) begin
            if (count == 0) begin
                // Handle the case when B is zero
                if (B == 0) begin
                    C <= 32'b1; 
                    ready <= 1'b1;
                end else begin
                    temp <= A; // Start with A for multiplication
                    count <= 1; // Start counting from 1
                end
            end else if (count <= B) begin
                // Wait for the multiplier to be ready
                if (multiplier_ready_signal) begin
                    if (count == 1) begin
                        C <= product; // First multiplication result
                    end else begin
                        temp <= C[15:0]; // Prepare for the next multiplication
                        C <= product; // Use the product from the multiplier
                    end
                    count <= count + 1; // Increment the counter
                end
            end else begin
                ready <= 1'b1; // Indicate that the operation is complete
            end
        end
    end
endmodule