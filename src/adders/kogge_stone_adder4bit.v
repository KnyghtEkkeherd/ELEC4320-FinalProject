`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module kogge_stone_adder4bit (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] S,
    output Cout
);

    wire [3:0] G0, P0;
    wire [3:0] G1, P1;
    wire [3:0] G2, P2;
    wire [3:0] G3;
    wire [4:0] C;

    assign G0 = A & B;
    assign P0 = A ^ B;

    // Level 1
    assign G1[0] = G0[0];
    assign P1[0] = P0[0];

    assign G1[1] = G0[1] | (P0[1] & G0[0]);
    assign P1[1] = P0[1] & P0[0];

    assign G1[2] = G0[2] | (P0[2] & G0[1]);
    assign P1[2] = P0[2] & P0[1];

    assign G1[3] = G0[3] | (P0[3] & G0[2]);
    assign P1[3] = P0[3] & P0[2];

    // Level 2
    assign G2[0] = G1[0];
    assign P2[0] = P1[0];

    assign G2[1] = G1[1];
    assign P2[1] = P1[1];

    assign G2[2] = G1[2] | (P1[2] & G1[0]);
    assign P2[2] = P1[2] & P1[0];

    assign G2[3] = G1[3] | (P1[3] & G1[1]);
    assign P2[3] = P1[3] & P1[1];

    // Output
    assign C[0] = Cin;  // Include Cin for the final carry calculation
    assign C[1] = G2[0];
    assign C[2] = G2[1];
    assign C[3] = G2[2];
    assign C[4] = G2[3];

    assign S[0] = P0[0] ^ C[0];
    assign S[1] = P0[1] ^ C[1];
    assign S[2] = P0[2] ^ C[2];
    assign S[3] = P0[3] ^ C[3];
    assign Cout = C[4];

endmodule
