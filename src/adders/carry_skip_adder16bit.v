`timescale 1ns / 1ps

// The optimal configuration for an 8-bit carry skip adder uses m = sqrt(8/2) = 2-bit blocks
// k = n/m, where k is the number of blocks needed and n is the number of input bits

// Full Adder Module
module full_adder (
    input  a,      // First input bit
    input  b,      // Second input bit
    input  cin,    // Carry input
    output sum,    // Output sum bit
    output cout,   // Carry output
    output p       // Propagate signal (P = a ^ b)
);
    // Sum output is the XOR of inputs a, b, and cin
    assign sum = a ^ b ^ cin;
    // Carry output is generated based on the logic of full adders
    assign cout = (a & b) | ((a ^ b) & cin);
    // Propagate signal indicates whether carry needs to be propagated
    assign p = a ^ b;
endmodule

// Carry Skip Adder Block Module
module carry_skip_adder_block (
    input [2:0] A,     // 3-bit input A
    input [2:0] B,     // 3-bit input B
    input Cin,         // Carry input for this block
    output [2:0] Sum,  // 3-bit sum output
    output Cout        // Carry output for this block
);

    wire [2:0] C;  // Internal wires to hold carry outputs from full adders
    wire [2:0] P;  // Internal wires to hold propagate signals

    // Carry-out logic for the block
    // Cout is set to Cin if all propagate signals are high, otherwise it takes the last carry output
    assign Cout = (P[0] & P[1] & P[2]) ? Cin : C[2];

    // Instantiate full adders for each bit in the block
    full_adder fa0 (
        .a(A[0]),          // First bit of A
        .b(B[0]),          // First bit of B
        .cin(Cin),        // Carry input
        .sum(Sum[0]),     // Sum output for the first bit
        .cout(C[0]),      // Carry output for the first bit
        .p(P[0])          // Propagate signal for the first bit
    );

    full_adder fa1 (
        .a(A[1]),          // Second bit of A
        .b(B[1]),          // Second bit of B
        .cin(C[0]),        // Carry from the first full adder
        .sum(Sum[1]),     // Sum output for the second bit
        .cout(C[1]),      // Carry output for the second bit
        .p(P[1])          // Propagate signal for the second bit
    );

    full_adder fa2 (
        .a(A[2]),          // Third bit of A
        .b(B[2]),          // Third bit of B
        .cin(C[1]),        // Carry from the second full adder
        .sum(Sum[2]),     // Sum output for the third bit
        .cout(C[2]),      // Carry output for the third bit
        .p(P[2])          // Propagate signal for the third bit
    );

endmodule

// 16-bit Carry Skip Adder Module
module carry_skip_adder16bit (
    input [15:0] A,    // 16-bit input A
    input [15:0] B,    // 16-bit input B
    input Cin,         // Carry input for the entire adder
    output [15:0] Sum,  // 16-bit sum output
    output Cout        // Carry output for the entire adder
);

    wire [4:0] C;  // Declare a 5-bit wire to hold carry outputs from all blocks

    // Instantiate multiple 3-bit carry skip adder blocks
    carry_skip_adder_block csab0 (
        .A(A[2:0]),       // First 3 bits of A
        .B(B[2:0]),       // First 3 bits of B
        .Cin(Cin),        // Carry input
        .Sum(Sum[2:0]),   // Sum output from this block
        .Cout(C[0])       // Carry output from this block
    );

    carry_skip_adder_block csab1 (
        .A(A[5:3]),       // Second 3 bits of A
        .B(B[5:3]),       // Second 3 bits of B
        .Cin(C[0]),       // Carry input from the previous block
        .Sum(Sum[5:3]),   // Sum output from this block
        .Cout(C[1])       // Carry output from this block
    );

    carry_skip_adder_block csab2 (
        .A(A[8:6]),       // Third 3 bits of A
        .B(B[8:6]),       // Third 3 bits of B
        .Cin(C[1]),       // Carry input from the previous block
        .Sum(Sum[8:6]),   // Sum output from this block
        .Cout(C[2])       // Carry output from this block
    );

    carry_skip_adder_block csab3 (
        .A(A[11:9]),      // Fourth 3 bits of A
        .B(B[11:9]),      // Fourth 3 bits of B
        .Cin(C[2]),       // Carry input from the previous block
        .Sum(Sum[11:9]),  // Sum output from this block
        .Cout(C[3])       // Carry output from this block
    );

    carry_skip_adder_block csab4 (
        .A(A[14:12]),     // Fifth 3 bits of A
        .B(B[14:12]),     // Fifth 3 bits of B
        .Cin(C[3]),       // Carry input from the previous block
        .Sum(Sum[14:12]), // Sum output from this block
        .Cout(C[4])       // Carry output from this block
    );

    carry_skip_adder_block csab5 (
        .A({1'b0, A[15]}), // Most significant bit (MSB) of A, padded with 0
        .B({1'b0, B[15]}), // Most significant bit (MSB) of B, padded with 0
        .Cin(C[4]),        // Carry input from the previous block
        .Sum({Cout, Sum[15]}), // Sum output, with Cout as the MSB
        .Cout()            // Final carry output is not used
    );

endmodule