`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout,
    output p
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | ((a ^ b) & cin);
    assign p = a ^ b;
endmodule

module carry_skip_adder_block (
// most optimal configuration for 8 bit carry skip adder is to use m = sqrt(8/2) = 2 bit blocks
// k = n/m, where k is the numebr of blocks needed and n is the number of input bits
    input [1:0] A,
    input [1:0] B,
    input Cin,
    output [1:0] Sum,
    output Cout
);

    wire [1:0] C;
    wire [1:0] P;

    assign Cout = (P[0] & P[1]) ? Cin : C[1];

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
endmodule

module carry_skip_adder8bit(
input [7:0] A,
input [7:0] B,
input Cin,
output [7:0] Sum,
output Cout
);

    wire [1:0] C[3:0];

    carry_skip_adder_block csab0 (
        .A(A[1:0]),
        .B(B[1:0]),
        .Cin(Cin),
        .Sum(Sum[1:0]),
        .Cout(C[0])
    );

    carry_skip_adder_block csab1 (
        .A(A[3:2]),
        .B(B[3:2]),
        .Cin(C[0]),
        .Sum(Sum[3:2]),
        .Cout(C[1])
    );

    carry_skip_adder_block csab2 (
        .A(A[5:4]),
        .B(B[5:4]),
        .Cin(C[1]),
        .Sum(Sum[5:4]),
        .Cout(C[2])
    );

    carry_skip_adder_block csab3 (
        .A(A[7:6]),
        .B(B[7:6]),
        .Cin(C[2]),
        .Sum(Sum[7:6]),
        .Cout(C[3])
    );

    assign Cout = C[3];
endmodule
