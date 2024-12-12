`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module kogge_stone_adder32bit (
    input [31:0] A,
    input [31:0] B,
    input Cin,
    output [31:0] S,
    output Cout
);

    wire [15:0] S0, S1;  // Sum outputs from the two 16-bit adders
    wire Cout0;  // Carry out from the first 16-bit adder

    // Instantiate the first 16-bit Kogge-Stone adder
    kogge_stone_adder16bit KSA0 (
        .A(A[15:0]),
        .B(B[15:0]),
        .Cin(Cin),
        .S(S0),
        .Cout(Cout0)
    );

    // Instantiate the second 16-bit Kogge-Stone adder
    kogge_stone_adder16bit KSA1 (
        .A(A[31:16]),
        .B(B[31:16]),
        .Cin(Cout0),  // Carry out from the first adder becomes the carry in for the second
        .S(S1),
        .Cout(Cout)
    );

    // Combine the results
    assign S = {S1, S0};  // Concatenate the two sums

endmodule
