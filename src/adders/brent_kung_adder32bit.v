// Outputs carryOutFinal as a separate variable

    module OrAndInvert(out, in1, in2, in3);
        output out;
        input in1, in2, in3;
        assign out = in1 | (in2 & in3);
    endmodule

    module AndOrInvert(out, in1, in2, in3, in4);
        output [1:0] out;
        input in1, in2, in3, in4;
        assign out[0] = in2 & in4;
        assign out[1] = in1 | (in2 & in3);
    endmodule

    module brent_kung_adder32bit(out, outputFinal, carryOutFinal, in1, in2, carryIn);
        output [32:0] out;
        output [31:0] outputFinal;
        output carryOutFinal;
        input [31:0] in1, in2;
        input carryIn;

        wire [31:0] generateSignals, propagateSignals;
        wire [30:0] stage1Signals;
        wire [14:0] stage2Signals;
        wire [6:0] stage3Signals;
        wire [2:0] stage4Signals;
        wire stage5Signal;
        wire stage6Signal;
        wire [2:0] stage7Signals;
        wire [6:0] stage8Signals;
        wire [14:0] stage9Signals;
        wire [31:0] intermediateWires;
        wire [31:0] carrySignals;

        assign generateSignals = in1 & in2;
        assign propagateSignals = in1 | in2;

        // Stage 1: Generate first level signals
        OrAndInvert M1(stage1Signals[0], generateSignals[1], propagateSignals[1], generateSignals[0]);
        AndOrInvert M2(stage1Signals[2:1], generateSignals[3], propagateSignals[3], generateSignals[2], propagateSignals[2]);
        AndOrInvert M3(stage1Signals[4:3], generateSignals[5], propagateSignals[5], generateSignals[4], propagateSignals[4]);
        AndOrInvert M4(stage1Signals[6:5], generateSignals[7], propagateSignals[7], generateSignals[6], propagateSignals[6]);
        AndOrInvert M5(stage1Signals[8:7], generateSignals[9], propagateSignals[9], generateSignals[8], propagateSignals[8]);
        AndOrInvert M6(stage1Signals[10:9], generateSignals[11], propagateSignals[11], generateSignals[10], propagateSignals[10]);
        AndOrInvert M7(stage1Signals[12:11], generateSignals[13], propagateSignals[13], generateSignals[12], propagateSignals[12]);
        AndOrInvert M8(stage1Signals[14:13], generateSignals[15], propagateSignals[15], generateSignals[14], propagateSignals[14]);
        AndOrInvert M9(stage1Signals[16:15], generateSignals[17], propagateSignals[17], generateSignals[16], propagateSignals[16]);
        AndOrInvert M10(stage1Signals[18:17], generateSignals[19], propagateSignals[19], generateSignals[18], propagateSignals[18]);
        AndOrInvert M11(stage1Signals[20:19], generateSignals[21], propagateSignals[21], generateSignals[20], propagateSignals[20]);
        AndOrInvert M12(stage1Signals[22:21], generateSignals[23], propagateSignals[23], generateSignals[22], propagateSignals[22]);
        AndOrInvert M13(stage1Signals[24:23], generateSignals[25], propagateSignals[25], generateSignals[24], propagateSignals[24]);
        AndOrInvert M14(stage1Signals[26:25], generateSignals[27], propagateSignals[27], generateSignals[26], propagateSignals[26]);
        AndOrInvert M15(stage1Signals[28:27], generateSignals[29], propagateSignals[29], generateSignals[28], propagateSignals[28]);
        AndOrInvert M16(stage1Signals[30:29], generateSignals[31], propagateSignals[31], generateSignals[30], propagateSignals[30]);

        // Stage 2: Combine signals for the next level
        OrAndInvert M17(stage2Signals[0], stage1Signals[2], stage1Signals[1], stage1Signals[0]);
        AndOrInvert M18(stage2Signals[2:1], stage1Signals[6], stage1Signals[5], stage1Signals[4], stage1Signals[3]);
        AndOrInvert M19(stage2Signals[4:3], stage1Signals[10], stage1Signals[9], stage1Signals[8], stage1Signals[7]);
        AndOrInvert M20(stage2Signals[6:5], stage1Signals[14], stage1Signals[13], stage1Signals[12], stage1Signals[11]);
        AndOrInvert M21(stage2Signals[8:7], stage1Signals[18], stage1Signals[17], stage1Signals[16], stage1Signals[15]);
        AndOrInvert M22(stage2Signals[10:9], stage1Signals[22], stage1Signals[21], stage1Signals[20], stage1Signals[19]);
        AndOrInvert M23(stage2Signals[12:11], stage1Signals[26], stage1Signals[25], stage1Signals[24], stage1Signals[23]);
        AndOrInvert M24(stage2Signals[14:13], stage1Signals[30], stage1Signals[29], stage1Signals[28], stage1Signals[27]);

        // Stage 3: Further combine signals
        OrAndInvert M25(stage3Signals[0], stage2Signals[2], stage2Signals[1], stage2Signals[0]);
        AndOrInvert M26(stage3Signals[2:1], stage2Signals[6], stage2Signals[5], stage2Signals[4], stage2Signals[3]);
        AndOrInvert M27(stage3Signals[4:3], stage2Signals[10], stage2Signals[9], stage2Signals[8], stage2Signals[7]);
        AndOrInvert M28(stage3Signals[6:5], stage2Signals[14], stage2Signals[13], stage2Signals[12], stage2Signals[11]);

        // Stage 4: Final combinations
        OrAndInvert M29(stage4Signals[0], stage3Signals[2], stage3Signals[1], stage3Signals[0]);
        AndOrInvert M30(stage4Signals[2:1], stage3Signals[6], stage3Signals[5], stage3Signals[4], stage3Signals[3]);

        // Stage 5: More signal combinations
        OrAndInvert M31(stage5Signal, stage4Signals[2], stage4Signals[1], stage4Signals[0]);

        // Stage 6: Additional logic
        OrAndInvert M32(stage6Signal, stage3Signals[4], stage3Signals[3], stage4Signals[0]);

        // Stage 7: Combination of earlier stages
        OrAndInvert M33(stage7Signals[0], stage2Signals[4], stage2Signals[3], stage3Signals[0]);
        OrAndInvert M34(stage7Signals[1], stage2Signals[8], stage2Signals[7], stage4Signals[0]);
        OrAndInvert M35(stage7Signals[2], stage2Signals[12], stage2Signals[11], stage6Signal);

        // Stage 8: More signal combinations
        OrAndInvert M36(stage8Signals[0], stage1Signals[4], stage1Signals[3], stage2Signals[0]);
        OrAndInvert M37(stage8Signals[1], stage1Signals[8], stage1Signals[7], stage3Signals[0]);
        OrAndInvert M38(stage8Signals[2], stage1Signals[12], stage1Signals[11], stage7Signals[0]);
        OrAndInvert M39(stage8Signals[3], stage1Signals[16], stage1Signals[15], stage4Signals[0]);
        OrAndInvert M40(stage8Signals[4], stage1Signals[20], stage1Signals[19], stage7Signals[1]);
        OrAndInvert M41(stage8Signals[5], stage1Signals[24], stage1Signals[23], stage6Signal);
        OrAndInvert M42(stage8Signals[6], stage1Signals[28], stage1Signals[27], stage7Signals[2]);

        // Stage 9: Final carry calculations
        OrAndInvert M43(stage9Signals[0], generateSignals[2], propagateSignals[2], stage1Signals[0]);
        OrAndInvert M44(stage9Signals[1], generateSignals[4], propagateSignals[4], stage2Signals[0]);
        OrAndInvert M45(stage9Signals[2], generateSignals[6], propagateSignals[6], stage8Signals[0]);
        OrAndInvert M46(stage9Signals[3], generateSignals[8], propagateSignals[8], stage3Signals[0]);
        OrAndInvert M47(stage9Signals[4], generateSignals[10], propagateSignals[10], stage8Signals[1]);
        OrAndInvert M48(stage9Signals[5], generateSignals[12], propagateSignals[12], stage7Signals[0]);
        OrAndInvert M49(stage9Signals[6], generateSignals[14], propagateSignals[14], stage8Signals[2]);
        OrAndInvert M50(stage9Signals[7], generateSignals[16], propagateSignals[16], stage4Signals[0]);
        OrAndInvert M51(stage9Signals[8], generateSignals[18], propagateSignals[18], stage8Signals[3]);
        OrAndInvert M52(stage9Signals[9], generateSignals[20], propagateSignals[20], stage7Signals[1]);
        OrAndInvert M53(stage9Signals[10], generateSignals[22], propagateSignals[22], stage8Signals[4]);
        OrAndInvert M54(stage9Signals[11], generateSignals[24], propagateSignals[24], stage6Signal);
        OrAndInvert M55(stage9Signals[12], generateSignals[26], propagateSignals[26], stage8Signals[5]);
        OrAndInvert M56(stage9Signals[13], generateSignals[28], propagateSignals[28], stage7Signals[2]);
        OrAndInvert M57(stage9Signals[14], generateSignals[30], propagateSignals[30], stage8Signals[6]);

        // Final carry calculations
        assign intermediateWires[0] = propagateSignals[0] & carryIn;
        assign carrySignals[0] = generateSignals[0] | intermediateWires[0];

        assign intermediateWires[1] = intermediateWires[0] & propagateSignals[1];
        assign carrySignals[1] = stage1Signals[0] | intermediateWires[1];

        assign intermediateWires[2] = intermediateWires[1] & propagateSignals[2];
        assign carrySignals[2] = stage9Signals[0] | intermediateWires[2];

        assign intermediateWires[3] = intermediateWires[2] & propagateSignals[3];
        assign carrySignals[3] = stage2Signals[0] | intermediateWires[3];

        assign intermediateWires[4] = intermediateWires[3] & propagateSignals[4];
        assign carrySignals[4] = stage9Signals[1] | intermediateWires[4];

        assign intermediateWires[5] = intermediateWires[4] & propagateSignals[5];
        assign carrySignals[5] = stage8Signals[0] | intermediateWires[5];

        assign intermediateWires[6] = intermediateWires[5] & propagateSignals[6];
        assign carrySignals[6] = stage9Signals[2] | intermediateWires[6];

        assign intermediateWires[7] = intermediateWires[6] & propagateSignals[7];
        assign carrySignals[7] = stage3Signals[0] | intermediateWires[7];

        assign intermediateWires[8] = intermediateWires[7] & propagateSignals[8];
        assign carrySignals[8] = stage9Signals[3] | intermediateWires[8];

        assign intermediateWires[9] = intermediateWires[8] & propagateSignals[9];
        assign carrySignals[9] = stage8Signals[1] | intermediateWires[9];

        assign intermediateWires[10] = intermediateWires[9] & propagateSignals[10];
        assign carrySignals[10] = stage9Signals[4] | intermediateWires[10];

        assign intermediateWires[11] = intermediateWires[10] & propagateSignals[11];
        assign carrySignals[11] = stage7Signals[0] | intermediateWires[11];

        assign intermediateWires[12] = intermediateWires[11] & propagateSignals[12];
        assign carrySignals[12] = stage9Signals[5] | intermediateWires[12];

        assign intermediateWires[13] = intermediateWires[12] & propagateSignals[13];
        assign carrySignals[13] = stage8Signals[2] | intermediateWires[13];

        assign intermediateWires[14] = intermediateWires[13] & propagateSignals[14];
        assign carrySignals[14] = stage9Signals[6] | intermediateWires[14];

        assign intermediateWires[15] = intermediateWires[14] & propagateSignals[15];
        assign carrySignals[15] = stage4Signals[0] | intermediateWires[15];

        assign intermediateWires[16] = intermediateWires[15] & propagateSignals[16];
        assign carrySignals[16] = stage9Signals[7] | intermediateWires[16];

        assign intermediateWires[17] = intermediateWires[16] & propagateSignals[17];
        assign carrySignals[17] = stage8Signals[3] | intermediateWires[17];

        assign intermediateWires[18] = intermediateWires[17] & propagateSignals[18];
        assign carrySignals[18] = stage9Signals[8] | intermediateWires[18];

        assign intermediateWires[19] = intermediateWires[18] & propagateSignals[19];
        assign carrySignals[19] = stage7Signals[1] | intermediateWires[19];

        assign intermediateWires[20] = intermediateWires[19] & propagateSignals[20];
        assign carrySignals[20] = stage9Signals[9] | intermediateWires[20];

        assign intermediateWires[21] = intermediateWires[20] & propagateSignals[21];
        assign carrySignals[21] = stage8Signals[4] | intermediateWires[21];

        assign intermediateWires[22] = intermediateWires[21] & propagateSignals[22];
        assign carrySignals[22] = stage9Signals[10] | intermediateWires[22];

        assign intermediateWires[23] = intermediateWires[22] & propagateSignals[23];
        assign carrySignals[23] = stage6Signal | intermediateWires[23];

        assign intermediateWires[24] = intermediateWires[23] & propagateSignals[24];
        assign carrySignals[24] = stage9Signals[11] | intermediateWires[24];

        assign intermediateWires[25] = intermediateWires[24] & propagateSignals[25];
        assign carrySignals[25] = stage8Signals[5] | intermediateWires[25];

        assign intermediateWires[26] = intermediateWires[25] & propagateSignals[26];
        assign carrySignals[26] = stage9Signals[12] | intermediateWires[26];

        assign intermediateWires[27] = intermediateWires[26] & propagateSignals[27];
        assign carrySignals[27] = stage7Signals[2] | intermediateWires[27];

        assign intermediateWires[28] = intermediateWires[27] & propagateSignals[28];
        assign carrySignals[28] = stage9Signals[13] | intermediateWires[28];

        assign intermediateWires[29] = intermediateWires[28] & propagateSignals[29];
        assign carrySignals[29] = stage8Signals[6] | intermediateWires[29];

        assign intermediateWires[30] = intermediateWires[29] & propagateSignals[30];
        assign carrySignals[30] = stage9Signals[14] | intermediateWires[30];

        assign intermediateWires[31] = intermediateWires[30] & propagateSignals[31];
        assign carrySignals[31] = stage5Signal | intermediateWires[31];

        assign out[31:0] = in1 ^ in2 ^ {carrySignals[30:0], carryIn};
        assign out[32] = carrySignals[31];

        assign outputFinal = out[31:0];
        assign carryOutFinal = out[32];
    endmodule