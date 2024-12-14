//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// Full Adder Module
module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout,
    output p
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | ((a ^ b) & cin);
    assign p = a ^ b;
endmodule

// Carry Skip Adder Block Module
module carry_skip_adder_block (
    input [2:0] A,
    input [2:0] B,
    input Cin,
    output [2:0] Sum,
    output Cout
);

    wire [2:0] C;  // Carry wires
    wire [2:0] P;  // Propagate wires

    // Carry-out logic
    assign Cout = (P[0] & P[1] & P[2]) ? Cin : C[2];

    // Instantiate full adders
    full_adder fa0 (
        .a(A[0]),
        .b(B[0]),
        .cin(Cin),
        .sum(Sum[0]),
        .cout(C[0]),
        .p(P[0])
    );

    full_adder fa1 (
        .a(A[1]),
        .b(B[1]),
        .cin(C[0]),
        .sum(Sum[1]),
        .cout(C[1]),
        .p(P[1])
    );

    full_adder fa2 (
        .a(A[2]),
        .b(B[2]),
        .cin(C[1]),
        .sum(Sum[2]),
        .cout(C[2]),
        .p(P[2])
    );

endmodule

// 16-bit Carry Skip Adder Module
module carry_skip_adder16bit (
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] Sum,
    output Cout
);

    wire [4:0] C;  // Declare as a 5-bit wire to hold carries

    carry_skip_adder_block csab0 (
        .A(A[2:0]),
        .B(B[2:0]),
        .Cin(Cin),
        .Sum(Sum[2:0]),
        .Cout(C[0])
    );

    carry_skip_adder_block csab1 (
        .A(A[5:3]),
        .B(B[5:3]),
        .Cin(C[0]),
        .Sum(Sum[5:3]),
        .Cout(C[1])
    );

    carry_skip_adder_block csab2 (
        .A(A[8:6]),
        .B(B[8:6]),
        .Cin(C[1]),
        .Sum(Sum[8:6]),
        .Cout(C[2])
    );

    carry_skip_adder_block csab3 (
        .A(A[11:9]),
        .B(B[11:9]),
        .Cin(C[2]),
        .Sum(Sum[11:9]),
        .Cout(C[3])
    );

    carry_skip_adder_block csab4 (
        .A(A[14:12]),
        .B(B[14:12]),
        .Cin(C[3]),
        .Sum(Sum[14:12]),
        .Cout(C[4])
    );

    carry_skip_adder_block csab5 (
        .A({1'b0, A[15]}),
        .B({1'b0, B[15]}),
        .Cin(C[4]),
        .Sum({Cout, Sum[15]}),
        .Cout()  // Connect final carry out directly to output
    );

endmodule
