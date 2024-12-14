//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

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
    generate
        for (i = 1; i < 32; i = i + 1) begin : gen_white_dot1
            white_dot white_dot_inst (
                .Ai  (A0[i-1]),
                .Ai_1(A0[i]),
                .Gi_1(G0[i]),
                .Gi  (G1[i-1]),
                .Aout(A1[i]),
                .Gout(G1[i])
            );
        end
    endgenerate

    // Level 2
    assign G2[0] = G1[0];

    grey_dot grey_dot1 (
        .Gi_1(G1[1]),
        .Ai_1(A1[1]),
        .Gi  (Cin),
        .Gout(G2[1])
    );
    generate
        for (i = 2; i < 32; i = i + 1) begin : gen_white_dot2
            white_dot white_dot_inst (
                .Ai  (A1[i-2]),
                .Ai_1(A1[i]),
                .Gi_1(G1[i]),
                .Gi  (G2[i-2]),
                .Aout(A2[i]),
                .Gout(G2[i])
            );
        end
    endgenerate

    // Level 3
    assign G3[0] = G2[0];
    assign G3[1] = G2[1];
    assign G3[2] = G2[2];

    grey_dot grey_dot2 (
        .Gi_1(G2[3]),
        .Ai_1(A2[3]),
        .Gi  (Cin),
        .Gout(G3[3])
    );
    generate
        for (i = 4; i < 32; i = i + 1) begin : gen_white_dot3
            white_dot white_dot_inst (
                .Ai  (A2[i-4]),
                .Ai_1(A2[i]),
                .Gi_1(G2[i]),
                .Gi  (G3[i-4]),
                .Aout(A3[i]),
                .Gout(G3[i])
            );
        end
    endgenerate

    // Level 4
    assign G4[0] = G3[0];
    assign G4[1] = G3[1];
    assign G4[2] = G3[2];
    assign G4[3] = G3[3];
    assign G4[4] = G3[4];
    assign G4[5] = G3[5];
    assign G4[6] = G3[6];

    grey_dot grey_dot3 (
        .Gi_1(G3[7]),
        .Ai_1(A3[7]),
        .Gi  (Cin),
        .Gout(G4[7])
    );
    generate
        for (i = 8; i < 32; i = i + 1) begin : gen_white_dot4
            white_dot white_dot_inst (
                .Ai  (A3[i-8]),
                .Ai_1(A3[i]),
                .Gi_1(G3[i]),
                .Gi  (G4[i-8]),
                .Aout(A4[i]),
                .Gout(G4[i])
            );
        end
    endgenerate

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

    grey_dot grey_dot4 (
        .Gi_1(G4[15]),
        .Ai_1(A4[15]),
        .Gi  (Cin),
        .Gout(G5[15])
    );
    generate
        for (i = 16; i < 32; i = i + 1) begin : gen_white_dot5
            white_dot white_dot_inst (
                .Ai  (A4[i-16]),
                .Ai_1(A4[i]),
                .Gi_1(G4[i]),
                .Gi  (G5[i-16]),
                .Aout(A5[i]),
                .Gout(G5[i])
            );
        end
    endgenerate

    // Summation
    assign S[0] = P0[0] ^ Cin;
    generate
        for (i = 1; i < 32; i = i + 1) begin : gen_sum
            assign S[i] = P0[i] ^ G5[i-1];
        end
    endgenerate

    // Cout
    grey_dot grey_dot5 (
        .Gi_1(G5[31]),
        .Ai_1(A5[31]),
        .Gi  (Cin),
        .Gout(Cout)
    );

endmodule
