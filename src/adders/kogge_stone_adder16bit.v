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

module kogge_stone_adder16bit (
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] S,
    output Cout
);

    wire [15:0] G0, A0, P0;
    wire [15:0] G1, A1;
    wire [15:0] G2, A2;
    wire [15:0] G3, A3;
    wire [15:0] G4;

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
    entry entry8 (
        .Xi(A[8]),
        .Yi(B[8]),
        .Gi(G0[8]),
        .Ai(A0[8]),
        .Pi(P0[8])
    );
    entry entry9 (
        .Xi(A[9]),
        .Yi(B[9]),
        .Gi(G0[9]),
        .Ai(A0[9]),
        .Pi(P0[9])
    );
    entry entry10 (
        .Xi(A[10]),
        .Yi(B[10]),
        .Gi(G0[10]),
        .Ai(A0[10]),
        .Pi(P0[10])
    );
    entry entry11 (
        .Xi(A[11]),
        .Yi(B[11]),
        .Gi(G0[11]),
        .Ai(A0[11]),
        .Pi(P0[11])
    );
    entry entry12 (
        .Xi(A[12]),
        .Yi(B[12]),
        .Gi(G0[12]),
        .Ai(A0[12]),
        .Pi(P0[12])
    );
    entry entry13 (
        .Xi(A[13]),
        .Yi(B[13]),
        .Gi(G0[13]),
        .Ai(A0[13]),
        .Pi(P0[13])
    );
    entry entry14 (
        .Xi(A[14]),
        .Yi(B[14]),
        .Gi(G0[14]),
        .Ai(A0[14]),
        .Pi(P0[14])
    );
    entry entry15 (
        .Xi(A[15]),
        .Yi(B[15]),
        .Gi(G0[15]),
        .Ai(A0[15]),
        .Pi(P0[15])
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
    white_dot white_dot7 (
        .Ai  (A0[7]),
        .Ai_1(A0[8]),
        .Gi_1(G0[8]),
        .Gi  (G1[7]),
        .Aout(A1[8]),
        .Gout(G1[8])
    );
    white_dot white_dot8 (
        .Ai  (A0[8]),
        .Ai_1(A0[9]),
        .Gi_1(G0[9]),
        .Gi  (G1[8]),
        .Aout(A1[9]),
        .Gout(G1[9])
    );
    white_dot white_dot9 (
        .Ai  (A0[9]),
        .Ai_1(A0[10]),
        .Gi_1(G0[10]),
        .Gi  (G1[9]),
        .Aout(A1[10]),
        .Gout(G1[10])
    );
    white_dot white_dot10 (
        .Ai  (A0[10]),
        .Ai_1(A0[11]),
        .Gi_1(G0[11]),
        .Gi  (G1[10]),
        .Aout(A1[11]),
        .Gout(G1[11])
    );
    white_dot white_dot11 (
        .Ai  (A0[11]),
        .Ai_1(A0[12]),
        .Gi_1(G0[12]),
        .Gi  (G1[11]),
        .Aout(A1[12]),
        .Gout(G1[12])
    );
    white_dot white_dot12 (
        .Ai  (A0[12]),
        .Ai_1(A0[13]),
        .Gi_1(G0[13]),
        .Gi  (G1[12]),
        .Aout(A1[13]),
        .Gout(G1[13])
    );
    white_dot white_dot13 (
        .Ai  (A0[13]),
        .Ai_1(A0[14]),
        .Gi_1(G0[14]),
        .Gi  (G1[13]),
        .Aout(A1[14]),
        .Gout(G1[14])
    );
    white_dot white_dot14 (
        .Ai  (A0[14]),
        .Ai_1(A0[15]),
        .Gi_1(G0[15]),
        .Gi  (G1[14]),
        .Aout(A1[15]),
        .Gout(G1[15])
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
    white_dot white_dot16 (
        .Ai  (A1[1]),
        .Ai_1(A1[3]),
        .Gi_1(G1[3]),
        .Gi  (G2[1]),
        .Aout(A2[3]),
        .Gout(G2[3])
    );
    white_dot white_dot17 (
        .Ai  (A1[2]),
        .Ai_1(A1[4]),
        .Gi_1(G1[4]),
        .Gi  (G2[2]),
        .Aout(A2[4]),
        .Gout(G2[4])
    );
    white_dot white_dot18 (
        .Ai  (A1[3]),
        .Ai_1(A1[5]),
        .Gi_1(G1[5]),
        .Gi  (G2[3]),
        .Aout(A2[5]),
        .Gout(G2[5])
    );
    white_dot white_dot19 (
        .Ai  (A1[4]),
        .Ai_1(A1[6]),
        .Gi_1(G1[6]),
        .Gi  (G2[4]),
        .Aout(A2[6]),
        .Gout(G2[6])
    );
    white_dot white_dot20 (
        .Ai  (A1[5]),
        .Ai_1(A1[7]),
        .Gi_1(G1[7]),
        .Gi  (G2[5]),
        .Aout(A2[7]),
        .Gout(G2[7])
    );
    white_dot white_dot21 (
        .Ai  (A1[6]),
        .Ai_1(A1[8]),
        .Gi_1(G1[8]),
        .Gi  (G2[6]),
        .Aout(A2[8]),
        .Gout(G2[8])
    );
    white_dot white_dot22 (
        .Ai  (A1[7]),
        .Ai_1(A1[9]),
        .Gi_1(G1[9]),
        .Gi  (G2[7]),
        .Aout(A2[9]),
        .Gout(G2[9])
    );
    white_dot white_dot23 (
        .Ai  (A1[8]),
        .Ai_1(A1[10]),
        .Gi_1(G1[10]),
        .Gi  (G2[8]),
        .Aout(A2[10]),
        .Gout(G2[10])
    );
    white_dot white_dot24 (
        .Ai  (A1[9]),
        .Ai_1(A1[11]),
        .Gi_1(G1[11]),
        .Gi  (G2[9]),
        .Aout(A2[11]),
        .Gout(G2[11])
    );
    white_dot white_dot25 (
        .Ai  (A1[10]),
        .Ai_1(A1[12]),
        .Gi_1(G1[12]),
        .Gi  (G2[10]),
        .Aout(A2[12]),
        .Gout(G2[12])
    );
    white_dot white_dot26 (
        .Ai  (A1[11]),
        .Ai_1(A1[13]),
        .Gi_1(G1[13]),
        .Gi  (G2[11]),
        .Aout(A2[13]),
        .Gout(G2[13])
    );
    white_dot white_dot27 (
        .Ai  (A1[12]),
        .Ai_1(A1[14]),
        .Gi_1(G1[14]),
        .Gi  (G2[12]),
        .Aout(A2[14]),
        .Gout(G2[14])
    );
    white_dot white_dot28 (
        .Ai  (A1[13]),
        .Ai_1(A1[15]),
        .Gi_1(G1[15]),
        .Gi  (G2[13]),
        .Aout(A2[15]),
        .Gout(G2[15])
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
    white_dot white_dot29 (
        .Ai  (A2[3]),
        .Ai_1(A2[7]),
        .Gi_1(G2[7]),
        .Gi  (G3[3]),
        .Aout(A3[7]),
        .Gout(G3[7])
    );
    white_dot white_dot30 (
        .Ai  (A2[4]),
        .Ai_1(A2[8]),
        .Gi_1(G2[8]),
        .Gi  (G3[4]),
        .Aout(A3[8]),
        .Gout(G3[8])
    );
    white_dot white_dot31 (
        .Ai  (A2[5]),
        .Ai_1(A2[9]),
        .Gi_1(G2[9]),
        .Gi  (G3[5]),
        .Aout(A3[9]),
        .Gout(G3[9])
    );
    white_dot white_dot32 (
        .Ai  (A2[6]),
        .Ai_1(A2[10]),
        .Gi_1(G2[10]),
        .Gi  (G3[6]),
        .Aout(A3[10]),
        .Gout(G3[10])
    );
    white_dot white_dot33 (
        .Ai  (A2[7]),
        .Ai_1(A2[11]),
        .Gi_1(G2[11]),
        .Gi  (G3[7]),
        .Aout(A3[11]),
        .Gout(G3[11])
    );
    white_dot white_dot34 (
        .Ai  (A2[8]),
        .Ai_1(A2[12]),
        .Gi_1(G2[12]),
        .Gi  (G3[8]),
        .Aout(A3[12]),
        .Gout(G3[12])
    );
    white_dot white_dot35 (
        .Ai  (A2[9]),
        .Ai_1(A2[13]),
        .Gi_1(G2[13]),
        .Gi  (G3[9]),
        .Aout(A3[13]),
        .Gout(G3[13])
    );
    white_dot white_dot36 (
        .Ai  (A2[10]),
        .Ai_1(A2[14]),
        .Gi_1(G2[14]),
        .Gi  (G3[10]),
        .Aout(A3[14]),
        .Gout(G3[14])
    );
    white_dot white_dot37 (
        .Ai  (A2[11]),
        .Ai_1(A2[15]),
        .Gi_1(G2[15]),
        .Gi  (G3[11]),
        .Aout(A3[15]),
        .Gout(G3[15])
    );
    // Level 4
    assign G4[0] = G3[0];
    assign G4[1] = G3[1];
    assign G4[2] = G3[2];
    assign G4[3] = G3[3];
    assign G4[4] = G3[4];
    assign G4[5] = G3[5];
    assign G4[6] = G3[6];

    grey_dot grey_dot7 (
        .Gi_1(G3[7]),
        .Ai_1(A3[7]),
        .Gi  (Cin),
        .Gout(G4[7])
    );

    grey_dot grey_dot8 (
        .Gi_1(G3[8]),
        .Ai_1(A3[8]),
        .Gi  (G3[0]),
        .Gout(G4[8])
    );
    grey_dot grey_dot9 (
        .Gi_1(G3[9]),
        .Ai_1(A3[9]),
        .Gi  (G3[1]),
        .Gout(G4[9])
    );
    grey_dot grey_dot10 (
        .Gi_1(G3[10]),
        .Ai_1(A3[10]),
        .Gi  (G3[2]),
        .Gout(G4[10])
    );
    grey_dot grey_dot11 (
        .Gi_1(G3[11]),
        .Ai_1(A3[11]),
        .Gi  (G3[3]),
        .Gout(G4[11])
    );
    grey_dot grey_dot12 (
        .Gi_1(G3[12]),
        .Ai_1(A3[12]),
        .Gi  (G3[4]),
        .Gout(G4[12])
    );
    grey_dot grey_dot13 (
        .Gi_1(G3[13]),
        .Ai_1(A3[13]),
        .Gi  (G3[5]),
        .Gout(G4[13])
    );
    grey_dot grey_dot14 (
        .Gi_1(G3[14]),
        .Ai_1(A3[14]),
        .Gi  (G3[6]),
        .Gout(G4[14])
    );
    grey_dot grey_dot15 (
        .Gi_1(G3[15]),
        .Ai_1(A3[15]),
        .Gi  (G3[7]),
        .Gout(G4[15])
    );

    // Summation
    assign S[0]  = P0[0] ^ Cin;
    assign S[1]  = P0[1] ^ G4[0];
    assign S[2]  = P0[2] ^ G4[1];
    assign S[3]  = P0[3] ^ G4[2];
    assign S[4]  = P0[4] ^ G4[3];
    assign S[5]  = P0[5] ^ G4[4];
    assign S[6]  = P0[6] ^ G4[5];
    assign S[7]  = P0[7] ^ G4[6];
    assign S[8]  = P0[8] ^ G4[7];
    assign S[9]  = P0[9] ^ G4[8];
    assign S[10] = P0[10] ^ G4[9];
    assign S[11] = P0[11] ^ G4[10];
    assign S[12] = P0[12] ^ G4[11];
    assign S[13] = P0[13] ^ G4[12];
    assign S[14] = P0[14] ^ G4[13];
    assign S[15] = P0[15] ^ G4[14];

    // Cout
    grey_dot grey_dot16 (
        .Gi_1(G4[15]),
        .Ai_1(A3[15]),
        .Gi  (Cin),
        .Gout(Cout)
    );
endmodule
