`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module kogge_stone_adder16bit (
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] S,
    output Cout
);

    wire [7:0] S0, S1;  // Sum outputs from the two 8-bit adders
    wire Cout0;  // Carry out from the first 8-bit adder

    // Instantiate the first 8-bit Kogge-Stone adder
    kogge_stone_adder8bit KSA0 (
        .A(A[7:0]),
        .B(B[7:0]),
        .Cin(Cin),
        .S(S0),
        .Cout(Cout0)
    );

    // Instantiate the second 8-bit Kogge-Stone adder
    kogge_stone_adder8bit KSA1 (
        .A(A[15:8]),
        .B(B[15:8]),
        .Cin(Cout0),  // Carry out from the first adder becomes the carry in for the second
        .S(S1),
        .Cout(Cout)
    );

    // Combine the results
    assign S = {S1, S0};  // Concatenate the two sums

endmodule
