`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module grey_dot (
    // Grey dot
    input  Gi_1,
    input  Ai_1,
    input  Gi,
    output Gout
);

    assign Gout = Gi_1 | (Ai_1 & Gi);

endmodule

module white_dot (
    // White dot
    input  Ai,
    input  Ai_1,
    input  Gi_1,
    input  Gi,
    output Gout,
    output Aout
);

    assign Aout = Ai & Ai_1;
    assign Gout = Gi_1 | (Ai_1 & Gi);
endmodule

module entry (
    input  Xi,
    input  Yi,
    output Gi,
    output Ai,
    output Pi
);

    assign Gi = Xi & Yi;
    assign Ai = Xi | Yi;
    assign Pi = Xi ^ Yi;

endmodule

module kogge_stone_adder8bit (
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] S,
    output Cout
);

    wire [7:0] G0, A0, P0;
    wire [7:0] G1, A1, P1;
    wire [7:0] G2, A2, P2;
    wire [7:0] G3, A3, P3;

    // Preprocessing stage
    entry entry0 (
        .Xi(A[0]),
        .Yi(B[0]),
        .Gi(G0[0]),
        .Ai(A0[0]),
        .Pi(P0[0])
    );
    entry entry1 (
        .Xi(A[1]),
        .Yi(B[1]),
        .Gi(G0[1]),
        .Ai(A0[1]),
        .Pi(P0[1])
    );
    entry entry2 (
        .Xi(A[2]),
        .Yi(B[2]),
        .Gi(G0[2]),
        .Ai(A0[2]),
        .Pi(P0[2])
    );
    entry entry3 (
        .Xi(A[3]),
        .Yi(B[3]),
        .Gi(G0[3]),
        .Ai(A0[3]),
        .Pi(P0[3])
    );
    entry entry4 (
        .Xi(A[4]),
        .Yi(B[4]),
        .Gi(G0[4]),
        .Ai(A0[4]),
        .Pi(P0[4])
    );
    entry entry5 (
        .Xi(A[5]),
        .Yi(B[5]),
        .Gi(G0[5]),
        .Ai(A0[5]),
        .Pi(P0[5])
    );
    entry entry6 (
        .Xi(A[6]),
        .Yi(B[6]),
        .Gi(G0[6]),
        .Ai(A0[6]),
        .Pi(P0[6])
    );
    entry entry7 (
        .Xi(A[7]),
        .Yi(B[7]),
        .Gi(G0[7]),
        .Ai(A0[7]),
        .Pi(P0[7])
    );

    // Level 1
    grey_dot grey_dot0 (
        .Gi_1(G0[0]),
        .Ai_1(A0[0]),
        .Gi  (Cin),
        .Gout(G1[0])
    );
    white_dot white_dot0 (
        .Ai  (A0[0]),
        .Ai_1(A0[1]),
        .Gi_1(G0[1]),
        .Gi  (G1[0]),
        .Aout(A1[1]),
        .Gout(G1[1])
    );
    white_dot white_dot1 (
        .Ai  (A0[1]),
        .Ai_1(A0[2]),
        .Gi_1(G0[2]),
        .Gi  (G1[1]),
        .Aout(A1[2]),
        .Gout(G1[2])
    );
    white_dot white_dot2 (
        .Ai  (A0[2]),
        .Ai_1(A0[3]),
        .Gi_1(G0[3]),
        .Gi  (G1[2]),
        .Aout(A1[3]),
        .Gout(G1[3])
    );
    white_dot white_dot3 (
        .Ai  (A0[3]),
        .Ai_1(A0[4]),
        .Gi_1(G0[4]),
        .Gi  (G1[3]),
        .Aout(A1[4]),
        .Gout(G1[4])
    );
    white_dot white_dot4 (
        .Ai  (A0[4]),
        .Ai_1(A0[5]),
        .Gi_1(G0[5]),
        .Gi  (G1[4]),
        .Aout(A1[5]),
        .Gout(G1[5])
    );
    white_dot white_dot5 (
        .Ai  (A0[5]),
        .Ai_1(A0[6]),
        .Gi_1(G0[6]),
        .Gi  (G1[5]),
        .Aout(A1[6]),
        .Gout(G1[6])
    );
    white_dot white_dot6 (
        .Ai  (A0[6]),
        .Ai_1(A0[7]),
        .Gi_1(G0[7]),
        .Gi  (G1[6]),
        .Aout(A1[7]),
        .Gout(G1[7])
    );

    // Level 2
    assign G2[0] = G1[0];

    grey_dot grey_dot1 (
        .Gi_1(G1[1]),
        .Ai_1(A1[1]),
        .Gi  (Cin),
        .Gout(G2[1])
    );
    grey_dot grey_dot2 (
        .Gi_1(G1[2]),
        .Ai_1(A1[2]),
        .Gi  (G1[0]),
        .Gout(G2[2])
    );
    white_dot white_dot7 (
        .Ai  (A1[1]),
        .Ai_1(A1[3]),
        .Gi_1(G1[3]),
        .Gi  (G2[1]),
        .Aout(A2[3]),
        .Gout(G2[3])
    );
    white_dot white_dot8 (
        .Ai  (A1[2]),
        .Ai_1(A1[4]),
        .Gi_1(G1[4]),
        .Gi  (G2[2]),
        .Aout(A2[4]),
        .Gout(G2[4])
    );
    white_dot white_dot9 (
        .Ai  (A1[3]),
        .Ai_1(A1[5]),
        .Gi_1(G1[5]),
        .Gi  (G2[3]),
        .Aout(A2[5]),
        .Gout(G2[5])
    );
    white_dot white_dot10 (
        .Ai  (A1[4]),
        .Ai_1(A1[6]),
        .Gi_1(G1[6]),
        .Gi  (G2[4]),
        .Aout(A2[6]),
        .Gout(G2[6])
    );
    white_dot white_dot11 (
        .Ai  (A1[5]),
        .Ai_1(A1[7]),
        .Gi_1(G1[7]),
        .Gi  (G2[5]),
        .Aout(A2[7]),
        .Gout(G2[7])
    );

    // Level 3
    assign G3[0] = G2[0];
    assign G3[1] = G2[1];
    assign G3[2] = G2[2];

    grey_dot grey_dot3 (
        .Gi_1(G2[3]),
        .Ai_1(A2[3]),
        .Gi  (Cin),
        .Gout(G3[3])
    );
    grey_dot grey_dot4 (
        .Gi_1(G2[4]),
        .Ai_1(A2[4]),
        .Gi  (G2[0]),
        .Gout(G3[4])
    );
    grey_dot grey_dot5 (
        .Gi_1(G2[5]),
        .Ai_1(A2[5]),
        .Gi  (G2[1]),
        .Gout(G3[5])
    );
    grey_dot grey_dot6 (
        .Gi_1(G2[6]),
        .Ai_1(A2[6]),
        .Gi  (G2[2]),
        .Gout(G3[6])
    );
    white_dot white_dot12 (
        .Ai  (A2[3]),
        .Ai_1(A2[7]),
        .Gi_1(G2[7]),
        .Gi  (G3[3]),
        .Aout(A3[7]),
        .Gout(G3[7])
    );

    // Summation
    assign S[0] = P0[0] ^ Cin;
    assign S[1] = P0[1] ^ G3[0];
    assign S[2] = P0[2] ^ G3[1];
    assign S[3] = P0[3] ^ G3[2];
    assign S[4] = P0[4] ^ G3[3];
    assign S[5] = P0[5] ^ G3[4];
    assign S[6] = P0[6] ^ G3[5];
    assign S[7] = P0[7] ^ G3[6];

    // Cout
    grey_dot grey_dot7 (
        .Gi_1(G3[7]),
        .Ai_1(A3[7]),
        .Gi  (Cin),
        .Gout(Cout)
    );

endmodule
