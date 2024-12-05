`timescale 1ns / 1ps

// Bingo bango bongo boom boom boom skrrrrra

module signed_multiplier (
    input signed [15:0] A,
    input signed [15:0] B,
    input clk,
    input clear,
    input reset,
    output reg signed [31:0] C,
    output reg ready
);
    reg signed [31:0] product;
    reg [15:0] abs_A, abs_B;
    reg A_sign, B_sign;
    reg [4:0] count;  // Counter for the multiplication process
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            product <= 32'b0;
            C <= 32'b0;
            ready <= 1'b0;
            count <= 5'b0;
        end else if (clear) begin
            product <= 32'b0;
            C <= 32'b0;
            ready <= 1'b0;
            count <= 5'b0;
        end else if (!ready) begin
            if (count == 0) begin
                // Determine the signs of A and B
                A_sign = A[15];
                B_sign = B[15];
                
                // Take the absolute values of A and B
                abs_A = A_sign ? -A : A;
                abs_B = B_sign ? -B : B;
                product = 0;
            end
            
            // Multiply the absolute values using shift-and-add method
            if (count < 16) begin
                if (abs_B[count]) begin
                    product = product + (abs_A << count);
                end
                count <= count + 1; // Increment count
            end else begin
                // Adjust the sign of the product
                if (A_sign ^ B_sign) begin
                    product = -product; // Negate product if signs are different
                end
                C <= product; // Assign the final product
                ready <= 1'b1; // Assert ready when done
            end
        end
    end
endmodule

// === TESTBENCH ===

// `timescale 1ns / 1ps

// module tb_signed_multiplier;

//     // Parameters
//     reg signed [15:0] A;
//     reg signed [15:0] B;
//     reg clk;
//     reg clear;
//     reg reset;
//     wire signed [31:0] C;
//     wire ready;

//     // Instantiate the signed_multiplier module
//     signed_multiplier uut (
//         .A(A),
//         .B(B),
//         .clk(clk),
//         .clear(clear),
//         .reset(reset),
//         .C(C),
//         .ready(ready)
//     );

//     // Clock generation
//     always begin
//         #5 clk = ~clk; // 100MHz clock
//     end

//     // Initial block for stimulus
//     initial begin
//         // Initialize signals
//         clk = 0;
//         clear = 0;
//         reset = 1;
//         A = 0;
//         B = 0;
        
//         // Release reset
//         #10 reset = 0;
        
//         // Test case 1: A = 3, B = 4
//         A = 16'sd3;
//         B = 16'sd4;
//         clear = 1; // Clear the multiplier
//         #10 clear = 0; // Release clear
//         wait(ready); // Wait until ready is asserted
        
//         // Check results for Test case 1
//         if (C !== 12) $display("Test case 1 failed: C = %d (expected 12)", C);
//         else $display("Test case 1 passed: C = %d", C);
        
//         // Clear for the next test
//         clear = 1; 
//         #10 clear = 0; // Release clear

//         // Test case 2: A = -5, B = 6
//         A = -16'sd5;
//         B = 16'sd6;
//         clear = 1; // Clear the multiplier
//         #10 clear = 0; // Release clear
//         wait(ready); // Wait until ready is asserted
        
//         // Check results for Test case 2
//         if (C !== -30) $display("Test case 2 failed: C = %d (expected -30)", C);
//         else $display("Test case 2 passed: C = %d", C);
        
//         // Clear for the next test
//         clear = 1; 
//         #10 clear = 0; // Release clear

//         // Test case 3: A = 0, B = 7
//         A = 16'sd0;
//         B = 16'sd7;
//         clear = 1; // Clear the multiplier
//         #10 clear = 0; // Release clear
//         wait(ready); // Wait until ready is asserted
        
//         // Check results for Test case 3
//         if (C !== 0) $display("Test case 3 failed: C = %d (expected 0)", C);
//         else $display("Test case 3 passed: C = %d", C);

//         // End simulation
//         $finish;
//     end

// endmodule