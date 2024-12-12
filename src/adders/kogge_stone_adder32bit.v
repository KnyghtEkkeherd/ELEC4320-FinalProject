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

module kogge_stone_adder32bit (
    input [31:0] A,
    input [31:0] B,
    input Cin,
    output [31:0] S,
    output Cout
);
    wire [31:0] G0, A0, P0;
    wire [31:0] G1, A1;
    wire [31:0] G2, A2;
    wire [31:0] G3, A3;
    wire [31:0] G4, A4;
    wire [31:0] G5, A5;

    // Preprocessing stage
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_entry
            entry entry_inst (
                .Xi(A[i]),
                .Yi(B[i]),
                .Gi(G0[i]),
                .Ai(A0[i]),
                .Pi(P0[i])
            );
        end
    endgenerate

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
    white_dot white_dot15 (
        .Ai  (A0[15]),
        .Ai_1(A0[16]),
        .Gi_1(G0[16]),
        .Gi  (G1[15]),
        .Aout(A1[16]),
        .Gout(G1[16])
    );
    white_dot white_dot16 (
        .Ai  (A0[16]),
        .Ai_1(A0[17]),
        .Gi_1(G0[17]),
        .Gi  (G1[16]),
        .Aout(A1[17]),
        .Gout(G1[17])
    );
    white_dot white_dot17 (
        .Ai  (A0[17]),
        .Ai_1(A0[18]),
        .Gi_1(G0[18]),
        .Gi  (G1[17]),
        .Aout(A1[18]),
        .Gout(G1[18])
    );
    white_dot white_dot18 (
        .Ai  (A0[18]),
        .Ai_1(A0[19]),
        .Gi_1(G0[19]),
        .Gi  (G1[18]),
        .Aout(A1[19]),
        .Gout(G1[19])
    );
    white_dot white_dot19 (
        .Ai  (A0[19]),
        .Ai_1(A0[20]),
        .Gi_1(G0[20]),
        .Gi  (G1[19]),
        .Aout(A1[20]),
        .Gout(G1[20])
    );
    white_dot white_dot20 (
        .Ai  (A0[20]),
        .Ai_1(A0[21]),
        .Gi_1(G0[21]),
        .Gi  (G1[20]),
        .Aout(A1[21]),
        .Gout(G1[21])
    );
    white_dot white_dot21 (
        .Ai  (A0[21]),
        .Ai_1(A0[22]),
        .Gi_1(G0[22]),
        .Gi  (G1[21]),
        .Aout(A1[22]),
        .Gout(G1[22])
    );
    white_dot white_dot22 (
        .Ai  (A0[22]),
        .Ai_1(A0[23]),
        .Gi_1(G0[23]),
        .Gi  (G1[22]),
        .Aout(A1[23]),
        .Gout(G1[23])
    );
    white_dot white_dot23 (
        .Ai  (A0[23]),
        .Ai_1(A0[24]),
        .Gi_1(G0[24]),
        .Gi  (G1[23]),
        .Aout(A1[24]),
        .Gout(G1[24])
    );
    white_dot white_dot24 (
        .Ai  (A0[24]),
        .Ai_1(A0[25]),
        .Gi_1(G0[25]),
        .Gi  (G1[24]),
        .Aout(A1[25]),
        .Gout(G1[25])
    );
    white_dot white_dot25 (
        .Ai  (A0[25]),
        .Ai_1(A0[26]),
        .Gi_1(G0[26]),
        .Gi  (G1[25]),
        .Aout(A1[26]),
        .Gout(G1[26])
    );
    white_dot white_dot26 (
        .Ai  (A0[26]),
        .Ai_1(A0[27]),
        .Gi_1(G0[27]),
        .Gi  (G1[26]),
        .Aout(A1[27]),
        .Gout(G1[27])
    );
    white_dot white_dot27 (
        .Ai  (A0[27]),
        .Ai_1(A0[28]),
        .Gi_1(G0[28]),
        .Gi  (G1[27]),
        .Aout(A1[28]),
        .Gout(G1[28])
    );
    white_dot white_dot28 (
        .Ai  (A0[28]),
        .Ai_1(A0[29]),
        .Gi_1(G0[29]),
        .Gi  (G1[28]),
        .Aout(A1[29]),
        .Gout(G1[29])
    );
    white_dot white_dot29 (
        .Ai  (A0[29]),
        .Ai_1(A0[30]),
        .Gi_1(G0[30]),
        .Gi  (G1[29]),
        .Aout(A1[30]),
        .Gout(G1[30])
    );
    white_dot white_dot30 (
        .Ai  (A0[30]),
        .Ai_1(A0[31]),
        .Gi_1(G0[31]),
        .Gi  (G1[30]),
        .Aout(A1[31]),
        .Gout(G1[31])
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
    white_dot white_dot31 (  // 28 in total
        .Ai  (A1[1]),
        .Ai_1(A1[2]),
        .Gi_1(G1[2]),
        .Gi  (G2[1]),
        .Aout(A2[3]),
        .Gout(G2[3])
    );
    white_dot white_dot32 (
        .Ai  (A1[2]),
        .Ai_1(A1[3]),
        .Gi_1(G1[3]),
        .Gi  (G2[2]),
        .Aout(A2[4]),
        .Gout(G2[4])
    );
    white_dot white_dot33 (
        .Ai  (A1[3]),
        .Ai_1(A1[4]),
        .Gi_1(G1[4]),
        .Gi  (G2[3]),
        .Aout(A2[5]),
        .Gout(G2[5])
    );
    white_dot white_dot34 (
        .Ai  (A1[4]),
        .Ai_1(A1[5]),
        .Gi_1(G1[5]),
        .Gi  (G2[4]),
        .Aout(A2[6]),
        .Gout(G2[6])
    );
    white_dot white_dot35 (
        .Ai  (A1[5]),
        .Ai_1(A1[6]),
        .Gi_1(G1[6]),
        .Gi  (G2[5]),
        .Aout(A2[7]),
        .Gout(G2[7])
    );
    white_dot white_dot36 (
        .Ai  (A1[6]),
        .Ai_1(A1[7]),
        .Gi_1(G1[7]),
        .Gi  (G2[6]),
        .Aout(A2[8]),
        .Gout(G2[8])
    );
    white_dot white_dot37 (
        .Ai  (A1[7]),
        .Ai_1(A1[8]),
        .Gi_1(G1[8]),
        .Gi  (G2[7]),
        .Aout(A2[9]),
        .Gout(G2[9])
    );
    white_dot white_dot38 (
        .Ai  (A1[8]),
        .Ai_1(A1[9]),
        .Gi_1(G1[9]),
        .Gi  (G2[8]),
        .Aout(A2[10]),
        .Gout(G2[10])
    );
    white_dot white_dot39 (
        .Ai  (A1[9]),
        .Ai_1(A1[10]),
        .Gi_1(G1[10]),
        .Gi  (G2[9]),
        .Aout(A2[11]),
        .Gout(G2[11])
    );
    white_dot white_dot40 (
        .Ai  (A1[10]),
        .Ai_1(A1[11]),
        .Gi_1(G1[11]),
        .Gi  (G2[10]),
        .Aout(A2[12]),
        .Gout(G2[12])
    );
    white_dot white_dot41 (
        .Ai  (A1[11]),
        .Ai_1(A1[12]),
        .Gi_1(G1[12]),
        .Gi  (G2[11]),
        .Aout(A2[13]),
        .Gout(G2[13])
    );
    white_dot white_dot42 (
        .Ai  (A1[12]),
        .Ai_1(A1[13]),
        .Gi_1(G1[13]),
        .Gi  (G2[12]),
        .Aout(A2[14]),
        .Gout(G2[14])
    );
    white_dot white_dot43 (
        .Ai  (A1[13]),
        .Ai_1(A1[14]),
        .Gi_1(G1[14]),
        .Gi  (G2[13]),
        .Aout(A2[15]),
        .Gout(G2[15])
    );
    white_dot white_dot44 (
        .Ai  (A1[14]),
        .Ai_1(A1[15]),
        .Gi_1(G1[15]),
        .Gi  (G2[14]),
        .Aout(A2[16]),
        .Gout(G2[16])
    );
    white_dot white_dot45 (
        .Ai  (A1[15]),
        .Ai_1(A1[16]),
        .Gi_1(G1[16]),
        .Gi  (G2[15]),
        .Aout(A2[17]),
        .Gout(G2[17])
    );
    white_dot white_dot46 (
        .Ai  (A1[16]),
        .Ai_1(A1[17]),
        .Gi_1(G1[17]),
        .Gi  (G2[16]),
        .Aout(A2[18]),
        .Gout(G2[18])
    );
    white_dot white_dot47 (
        .Ai  (A1[17]),
        .Ai_1(A1[18]),
        .Gi_1(G1[18]),
        .Gi  (G2[17]),
        .Aout(A2[19]),
        .Gout(G2[19])
    );
    white_dot white_dot48 (
        .Ai  (A1[18]),
        .Ai_1(A1[19]),
        .Gi_1(G1[19]),
        .Gi  (G2[18]),
        .Aout(A2[20]),
        .Gout(G2[20])
    );
    white_dot white_dot49 (
        .Ai  (A1[19]),
        .Ai_1(A1[20]),
        .Gi_1(G1[20]),
        .Gi  (G2[19]),
        .Aout(A2[21]),
        .Gout(G2[21])
    );
    white_dot white_dot50 (
        .Ai  (A1[20]),
        .Ai_1(A1[21]),
        .Gi_1(G1[21]),
        .Gi  (G2[20]),
        .Aout(A2[22]),
        .Gout(G2[22])
    );
    white_dot white_dot51 (
        .Ai  (A1[21]),
        .Ai_1(A1[22]),
        .Gi_1(G1[22]),
        .Gi  (G2[21]),
        .Aout(A2[23]),
        .Gout(G2[23])
    );
    white_dot white_dot52 (
        .Ai  (A1[22]),
        .Ai_1(A1[23]),
        .Gi_1(G1[23]),
        .Gi  (G2[22]),
        .Aout(A2[24]),
        .Gout(G2[24])
    );
    white_dot white_dot53 (
        .Ai  (A1[23]),
        .Ai_1(A1[24]),
        .Gi_1(G1[24]),
        .Gi  (G2[23]),
        .Aout(A2[25]),
        .Gout(G2[25])
    );
    white_dot white_dot54 (
        .Ai  (A1[24]),
        .Ai_1(A1[25]),
        .Gi_1(G1[25]),
        .Gi  (G2[24]),
        .Aout(A2[26]),
        .Gout(G2[26])
    );
    white_dot white_dot55 (
        .Ai  (A1[25]),
        .Ai_1(A1[26]),
        .Gi_1(G1[26]),
        .Gi  (G2[25]),
        .Aout(A2[27]),
        .Gout(G2[27])
    );
    white_dot white_dot56 (
        .Ai  (A1[26]),
        .Ai_1(A1[27]),
        .Gi_1(G1[27]),
        .Gi  (G2[26]),
        .Aout(A2[28]),
        .Gout(G2[28])
    );
    white_dot white_dot57 (
        .Ai  (A1[27]),
        .Ai_1(A1[28]),
        .Gi_1(G1[28]),
        .Gi  (G2[27]),
        .Aout(A2[29]),
        .Gout(G2[29])
    );
    white_dot white_dot58 (
        .Ai  (A1[28]),
        .Ai_1(A1[29]),
        .Gi_1(G1[29]),
        .Gi  (G2[28]),
        .Aout(A2[30]),
        .Gout(G2[30])
    );
    white_dot white_dot59 (
        .Ai  (A1[29]),
        .Ai_1(A1[30]),
        .Gi_1(G1[30]),
        .Gi  (G2[29]),
        .Aout(A2[31]),
        .Gout(G2[31])
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
    white_dot white_dot60 (
        .Ai  (A2[3]),
        .Ai_1(A2[7]),
        .Gi_1(G2[7]),
        .Gi  (G3[3]),
        .Aout(A3[7]),
        .Gout(G3[7])
    );
    white_dot white_dot61 (
        .Ai  (A2[4]),
        .Ai_1(A2[8]),
        .Gi_1(G2[8]),
        .Gi  (G3[4]),
        .Aout(A3[8]),
        .Gout(G3[8])
    );
    white_dot white_dot62 (
        .Ai  (A2[5]),
        .Ai_1(A2[9]),
        .Gi_1(G2[9]),
        .Gi  (G3[5]),
        .Aout(A3[9]),
        .Gout(G3[9])
    );
    white_dot white_dot63 (
        .Ai  (A2[6]),
        .Ai_1(A2[10]),
        .Gi_1(G2[10]),
        .Gi  (G3[6]),
        .Aout(A3[10]),
        .Gout(G3[10])
    );
    white_dot white_dot64 (
        .Ai  (A2[7]),
        .Ai_1(A2[11]),
        .Gi_1(G2[11]),
        .Gi  (G3[7]),
        .Aout(A3[11]),
        .Gout(G3[11])
    );
    white_dot white_dot65 (
        .Ai  (A2[8]),
        .Ai_1(A2[12]),
        .Gi_1(G2[12]),
        .Gi  (G3[8]),
        .Aout(A3[12]),
        .Gout(G3[12])
    );
    white_dot white_dot66 (
        .Ai  (A2[9]),
        .Ai_1(A2[13]),
        .Gi_1(G2[13]),
        .Gi  (G3[9]),
        .Aout(A3[13]),
        .Gout(G3[13])
    );
    white_dot white_dot67 (
        .Ai  (A2[10]),
        .Ai_1(A2[14]),
        .Gi_1(G2[14]),
        .Gi  (G3[10]),
        .Aout(A3[14]),
        .Gout(G3[14])
    );
    white_dot white_dot68 (
        .Ai  (A2[11]),
        .Ai_1(A2[15]),
        .Gi_1(G2[15]),
        .Gi  (G3[11]),
        .Aout(A3[15]),
        .Gout(G3[15])
    );
    white_dot white_dot69 (
        .Ai  (A2[12]),
        .Ai_1(A2[16]),
        .Gi_1(G2[16]),
        .Gi  (G3[12]),
        .Aout(A3[16]),
        .Gout(G3[16])
    );
    white_dot white_dot70 (
        .Ai  (A2[13]),
        .Ai_1(A2[17]),
        .Gi_1(G2[17]),
        .Gi  (G3[13]),
        .Aout(A3[17]),
        .Gout(G3[17])
    );
    white_dot white_dot71 (
        .Ai  (A2[14]),
        .Ai_1(A2[18]),
        .Gi_1(G2[18]),
        .Gi  (G3[14]),
        .Aout(A3[18]),
        .Gout(G3[18])
    );
    white_dot white_dot72 (
        .Ai  (A2[15]),
        .Ai_1(A2[19]),
        .Gi_1(G2[19]),
        .Gi  (G3[15]),
        .Aout(A3[19]),
        .Gout(G3[19])
    );
    white_dot white_dot73 (
        .Ai  (A2[16]),
        .Ai_1(A2[20]),
        .Gi_1(G2[20]),
        .Gi  (G3[16]),
        .Aout(A3[20]),
        .Gout(G3[20])
    );
    white_dot white_dot74 (
        .Ai  (A2[17]),
        .Ai_1(A2[21]),
        .Gi_1(G2[21]),
        .Gi  (G3[17]),
        .Aout(A3[21]),
        .Gout(G3[21])
    );
    white_dot white_dot75 (
        .Ai  (A2[18]),
        .Ai_1(A2[22]),
        .Gi_1(G2[22]),
        .Gi  (G3[18]),
        .Aout(A3[22]),
        .Gout(G3[22])
    );
    white_dot white_dot76 (
        .Ai  (A2[19]),
        .Ai_1(A2[23]),
        .Gi_1(G2[23]),
        .Gi  (G3[19]),
        .Aout(A3[23]),
        .Gout(G3[23])
    );
    white_dot white_dot77 (
        .Ai  (A2[20]),
        .Ai_1(A2[24]),
        .Gi_1(G2[24]),
        .Gi  (G3[20]),
        .Aout(A3[24]),
        .Gout(G3[24])
    );
    white_dot white_dot78 (
        .Ai  (A2[21]),
        .Ai_1(A2[25]),
        .Gi_1(G2[25]),
        .Gi  (G3[21]),
        .Aout(A3[25]),
        .Gout(G3[25])
    );
    white_dot white_dot79 (
        .Ai  (A2[22]),
        .Ai_1(A2[26]),
        .Gi_1(G2[26]),
        .Gi  (G3[22]),
        .Aout(A3[26]),
        .Gout(G3[26])
    );
    white_dot white_dot80 (
        .Ai  (A2[23]),
        .Ai_1(A2[27]),
        .Gi_1(G2[27]),
        .Gi  (G3[23]),
        .Aout(A3[27]),
        .Gout(G3[27])
    );
    white_dot white_dot81 (
        .Ai  (A2[24]),
        .Ai_1(A2[28]),
        .Gi_1(G2[28]),
        .Gi  (G3[24]),
        .Aout(A3[28]),
        .Gout(G3[28])
    );
    white_dot white_dot82 (
        .Ai  (A2[25]),
        .Ai_1(A2[29]),
        .Gi_1(G2[29]),
        .Gi  (G3[25]),
        .Aout(A3[29]),
        .Gout(G3[29])
    );
    white_dot white_dot83 (
        .Ai  (A2[26]),
        .Ai_1(A2[30]),
        .Gi_1(G2[30]),
        .Gi  (G3[26]),
        .Aout(A3[30]),
        .Gout(G3[30])
    );
    white_dot white_dot84 (
        .Ai  (A2[27]),
        .Ai_1(A2[31]),
        .Gi_1(G2[31]),
        .Gi  (G3[27]),
        .Aout(A3[31]),
        .Gout(G3[31])
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
    white_dot white_dot85 (
        .Ai  (A3[7]),
        .Ai_1(A3[15]),
        .Gi_1(G3[15]),
        .Gi  (G4[7]),
        .Aout(A4[15]),
        .Gout(G4[15])
    );
    white_dot white_dot86 (
        .Ai  (A3[8]),
        .Ai_1(A3[16]),
        .Gi_1(G3[16]),
        .Gi  (G4[8]),
        .Aout(A4[16]),
        .Gout(G4[16])
    );
    white_dot white_dot87 (
        .Ai  (A3[9]),
        .Ai_1(A3[17]),
        .Gi_1(G3[17]),
        .Gi  (G4[9]),
        .Aout(A4[17]),
        .Gout(G4[17])
    );
    white_dot white_dot88 (
        .Ai  (A3[10]),
        .Ai_1(A3[18]),
        .Gi_1(G3[18]),
        .Gi  (G4[10]),
        .Aout(A4[18]),
        .Gout(G4[18])
    );
    white_dot white_dot89 (
        .Ai  (A3[11]),
        .Ai_1(A3[19]),
        .Gi_1(G3[19]),
        .Gi  (G4[11]),
        .Aout(A4[19]),
        .Gout(G4[19])
    );
    white_dot white_dot90 (
        .Ai  (A3[12]),
        .Ai_1(A3[20]),
        .Gi_1(G3[20]),
        .Gi  (G4[12]),
        .Aout(A4[20]),
        .Gout(G4[20])
    );
    white_dot white_dot91 (
        .Ai  (A3[13]),
        .Ai_1(A3[21]),
        .Gi_1(G3[21]),
        .Gi  (G4[13]),
        .Aout(A4[21]),
        .Gout(G4[21])
    );
    white_dot white_dot92 (
        .Ai  (A3[14]),
        .Ai_1(A3[22]),
        .Gi_1(G3[22]),
        .Gi  (G4[14]),
        .Aout(A4[22]),
        .Gout(G4[22])
    );
    white_dot white_dot93 (
        .Ai  (A3[15]),
        .Ai_1(A3[23]),
        .Gi_1(G3[23]),
        .Gi  (G4[15]),
        .Aout(A4[23]),
        .Gout(G4[23])
    );
    white_dot white_dot94 (
        .Ai  (A3[16]),
        .Ai_1(A3[24]),
        .Gi_1(G3[24]),
        .Gi  (G4[16]),
        .Aout(A4[24]),
        .Gout(G4[24])
    );
    white_dot white_dot95 (
        .Ai  (A3[17]),
        .Ai_1(A3[25]),
        .Gi_1(G3[25]),
        .Gi  (G4[17]),
        .Aout(A4[25]),
        .Gout(G4[25])
    );
    white_dot white_dot96 (
        .Ai  (A3[18]),
        .Ai_1(A3[26]),
        .Gi_1(G3[26]),
        .Gi  (G4[18]),
        .Aout(A4[26]),
        .Gout(G4[26])
    );
    white_dot white_dot97 (
        .Ai  (A3[19]),
        .Ai_1(A3[27]),
        .Gi_1(G3[27]),
        .Gi  (G4[19]),
        .Aout(A4[27]),
        .Gout(G4[27])
    );
    white_dot white_dot98 (
        .Ai  (A3[20]),
        .Ai_1(A3[28]),
        .Gi_1(G3[28]),
        .Gi  (G4[20]),
        .Aout(A4[28]),
        .Gout(G4[28])
    );
    white_dot white_dot99 (
        .Ai  (A3[21]),
        .Ai_1(A3[29]),
        .Gi_1(G3[29]),
        .Gi  (G4[21]),
        .Aout(A4[29]),
        .Gout(G4[29])
    );
    white_dot white_dot100 (
        .Ai  (A3[22]),
        .Ai_1(A3[30]),
        .Gi_1(G3[30]),
        .Gi  (G4[22]),
        .Aout(A4[30]),
        .Gout(G4[30])
    );
    white_dot white_dot101 (
        .Ai  (A3[23]),
        .Ai_1(A3[31]),
        .Gi_1(G3[31]),
        .Gi  (G4[23]),
        .Aout(A4[31]),
        .Gout(G4[31])
    );

    // Level 5
    assign G5[0]  = G4[0];
    assign G5[1]  = G4[1];
    assign G5[2]  = G4[2];
    assign G5[3]  = G4[3];
    assign G5[4]  = G4[4];
    assign G5[5]  = G4[5];
    assign G5[6]  = G4[6];
    assign G5[7]  = G4[7];
    assign G5[8]  = G4[8];
    assign G5[9]  = G4[9];
    assign G5[10] = G4[10];
    assign G5[11] = G4[11];
    assign G5[12] = G4[12];
    assign G5[13] = G4[13];
    assign G5[14] = G4[14];

    grey_dot grey_dot15 (
        .Gi_1(G4[15]),
        .Ai_1(A4[15]),
        .Gi  (Cin),
        .Gout(G5[15])
    );
    grey_dot grey_dot16 (
        .Gi_1(G4[16]),
        .Ai_1(A4[16]),
        .Gi  (G4[0]),
        .Gout(G5[16])
    );
    grey_dot grey_dot17 (
        .Gi_1(G4[17]),
        .Ai_1(A4[17]),
        .Gi  (G4[1]),
        .Gout(G5[17])
    );
    grey_dot grey_dot18 (
        .Gi_1(G4[18]),
        .Ai_1(A4[18]),
        .Gi  (G4[2]),
        .Gout(G5[18])
    );
    grey_dot grey_dot19 (
        .Gi_1(G4[19]),
        .Ai_1(A4[19]),
        .Gi  (G4[3]),
        .Gout(G5[19])
    );
    grey_dot grey_dot20 (
        .Gi_1(G4[20]),
        .Ai_1(A4[20]),
        .Gi  (G4[4]),
        .Gout(G5[20])
    );
    grey_dot grey_dot21 (
        .Gi_1(G4[21]),
        .Ai_1(A4[21]),
        .Gi  (G4[5]),
        .Gout(G5[21])
    );
    grey_dot grey_dot22 (
        .Gi_1(G4[22]),
        .Ai_1(A4[22]),
        .Gi  (G4[6]),
        .Gout(G5[22])
    );
    grey_dot grey_dot23 (
        .Gi_1(G4[23]),
        .Ai_1(A4[23]),
        .Gi  (G4[7]),
        .Gout(G5[23])
    );
    grey_dot grey_dot24 (
        .Gi_1(G4[24]),
        .Ai_1(A4[24]),
        .Gi  (G4[8]),
        .Gout(G5[24])
    );
    grey_dot grey_dot25 (
        .Gi_1(G4[25]),
        .Ai_1(A4[25]),
        .Gi  (G4[9]),
        .Gout(G5[25])
    );
    grey_dot grey_dot26 (
        .Gi_1(G4[26]),
        .Ai_1(A4[26]),
        .Gi  (G4[10]),
        .Gout(G5[26])
    );
    grey_dot grey_dot27 (
        .Gi_1(G4[27]),
        .Ai_1(A4[27]),
        .Gi  (G4[11]),
        .Gout(G5[27])
    );
    grey_dot grey_dot28 (
        .Gi_1(G4[28]),
        .Ai_1(A4[28]),
        .Gi  (G4[12]),
        .Gout(G5[28])
    );
    grey_dot grey_dot29 (
        .Gi_1(G4[29]),
        .Ai_1(A4[29]),
        .Gi  (G4[13]),
        .Gout(G5[29])
    );
    grey_dot grey_dot30 (
        .Gi_1(G4[30]),
        .Ai_1(A4[30]),
        .Gi  (G4[14]),
        .Gout(G5[30])
    );
    white_dot white_dot102 (
        .Ai  (A4[15]),
        .Ai_1(A4[31]),
        .Gi_1(G4[31]),
        .Gi  (G5[15]),
        .Aout(A5[31]),
        .Gout(G5[31])
    );

    // Summation
    assign S[0] = P0[0] ^ Cin;
    assign S[1] = P0[1] ^ G5[0];
    assign S[2] = P0[2] ^ G5[1];
    assign S[3] = P0[3] ^ G5[2];
    assign S[4] = P0[4] ^ G5[3];
    assign S[5] = P0[5] ^ G5[4];
    assign S[6] = P0[6] ^ G5[5];
    assign S[7] = P0[7] ^ G5[6];
    assign S[8] = P0[8] ^ G5[7];
    assign S[9] = P0[9] ^ G5[8];
    assign S[10] = P0[10] ^ G5[9];
    assign S[11] = P0[11] ^ G5[10];
    assign S[12] = P0[12] ^ G5[11];
    assign S[13] = P0[13] ^ G5[12];
    assign S[14] = P0[14] ^ G5[13];
    assign S[15] = P0[15] ^ G5[14];
    assign S[16] = P0[16] ^ G5[15];
    assign S[17] = P0[17] ^ G5[16];
    assign S[18] = P0[18] ^ G5[17];
    assign S[19] = P0[19] ^ G5[18];
    assign S[20] = P0[20] ^ G5[19];
    assign S[21] = P0[21] ^ G5[20];
    assign S[22] = P0[22] ^ G5[21];
    assign S[23] = P0[23] ^ G5[22];
    assign S[24] = P0[24] ^ G5[23];
    assign S[25] = P0[25] ^ G5[24];
    assign S[26] = P0[26] ^ G5[25];
    assign S[27] = P0[27] ^ G5[26];
    assign S[28] = P0[28] ^ G5[27];
    assign S[29] = P0[29] ^ G5[28];
    assign S[30] = P0[30] ^ G5[29];
    assign S[31] = P0[31] ^ G5[30];

    // Cout
    grey_dot grey_dot31 (
        .Gi_1(G5[31]),
        .Ai_1(A5[31]),
        .Gi  (Cin),
        .Gout(Cout)
    );

endmodule
