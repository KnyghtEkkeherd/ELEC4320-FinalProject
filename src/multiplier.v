`timescale 1ns / 1ps
`include "adder.v"

// Bingo bango bongo boom boom boom skrrrrra

module multiplier (
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
                count <= count + 1;
            end else begin
                // Adjust the sign of the product
                if (A_sign ^ B_sign) begin
                    product = -product;
                end
                C <= product;
                ready <= 1'b1;
            end
        end
    end
endmodule

// Testbench:

// `timescale 1ns / 1ps
// module signed_multiplier_tb;
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
    
//     // Generate clock signal
//     always #5 clk = ~clk;
    
//     initial begin
//         // Initialize inputs
//         A = 16'd1000;
//         B = -16'd20;
//         clk = 0;
//         clear = 0;
//         reset = 1;
        
//         // Apply reset
//         #10 reset = 0;
//         clear = 1;
//         #10 clear = 0;
        
//         // Wait for the ready signal
//         wait(ready);
        
//         // Display the result
//         $display("A = %d, B = %d, C = %d", A, B, C);
        
//         // Test another value
//         reset = 1;
//         #10 reset = 0;
//         clear = 1;
//         A = -16'd123;
//         B = 16'd456;
//         #10 clear = 0;
        
//         // Wait for the ready signal
//         wait(ready);
        
//         // Display the result
//         $display("A = %d, B = %d, C = %d", A, B, C);
        
//         // Finish simulation
//         #10 $finish;
//     end
// endmodule
