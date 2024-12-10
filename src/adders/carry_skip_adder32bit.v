`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

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
    assign sum  = a ^ b ^ cin;
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
