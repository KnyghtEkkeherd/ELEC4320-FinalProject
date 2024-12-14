//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// most optimal configuration for 8 bit carry skip adder is to use m = sqrt(32/2) = sqrt(16) = 4 bit blocks
// k = n/m, where k is the numebr of blocks needed and n is the number of input bits

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

module carry_skip_adder_block (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
);

    wire [3:0] C;
    wire [3:0] P;

    assign Cout = (P[0] & P[1] & P[2] & P[3]) ? Cin : C[3];

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

    full_adder fa3 (
        .a(A[3]),
        .b(B[3]),
        .cin(C[2]),
        .sum(Sum[3]),
        .cout(C[3]),
        .p(P[3])
    );
endmodule

module carry_skip_adder_32bit (
    input [31:0] A,
    input [31:0] B,
    input Cin,
    output [31:0] Sum,
    output Cout
);

    wire [7:0] C;

    carry_skip_adder_block csab0 (
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(Cin),
        .Sum(Sum[3:0]),
        .Cout(C[0])
    );

    carry_skip_adder_block csab1 (
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(C[0]),
        .Sum(Sum[7:4]),
        .Cout(C[1])
    );

    carry_skip_adder_block csab2 (
        .A(A[11:8]),
        .B(B[11:8]),
        .Cin(C[1]),
        .Sum(Sum[11:8]),
        .Cout(C[2])
    );

    carry_skip_adder_block csab3 (
        .A(A[15:12]),
        .B(B[15:12]),
        .Cin(C[2]),
        .Sum(Sum[15:12]),
        .Cout(C[3])
    );

    carry_skip_adder_block csab4 (
        .A(A[19:16]),
        .B(B[19:16]),
        .Cin(C[3]),
        .Sum(Sum[19:16]),
        .Cout(C[4])
    );

    carry_skip_adder_block csab5 (
        .A(A[23:20]),
        .B(B[23:20]),
        .Cin(C[4]),
        .Sum(Sum[23:20]),
        .Cout(C[5])
    );

    carry_skip_adder_block csab6 (
        .A(A[27:24]),
        .B(B[27:24]),
        .Cin(C[5]),
        .Sum(Sum[27:24]),
        .Cout(C[6])
    );

    carry_skip_adder_block csab7 (
        .A(A[31:28]),
        .B(B[31:28]),
        .Cin(C[6]),
        .Sum(Sum[31:28]),
        .Cout(C[7])
    );

    assign Cout = C[7];
endmodule
