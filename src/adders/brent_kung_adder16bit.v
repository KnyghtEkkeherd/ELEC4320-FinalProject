//////////////////////////////////////////////////////////////////////////////////
// Name: Armaan Dayal
// Email: adayal@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

module OrAndInvert (output out, input in1, in2, in3);
    assign out = in1 | (in2 & in3);
endmodule

module AndOrInvert (output [1:0] out, input in1, in2, in3, in4);
    assign out[0] = in2 & in4;
    assign out[1] = in1 | (in2 & in3);
endmodule

module brent_kung_adder16bit (output [16:0] out, input [15:0] in1, in2, input carryIn);
    wire [15:0] generateSignals, propagateSignals;
    wire [14:0] stage1Signals;
    wire [6:0] stage2Signals;
    wire [2:0] stage3Signals;
    wire stage4Signal;
    wire stage5Signal;
    wire [2:0] stage6Signals;
    wire [6:0] stage7Signals;
    wire [14:0] stage8Signals;
    wire [15:0] intermediateWires;
    wire [15:0] carrySignals;

    assign generateSignals  = in1 & in2;
    assign propagateSignals = in1 | in2;

    // Stage 1: Generate first level signals
    OrAndInvert M1 (stage1Signals[0], generateSignals[1], propagateSignals[1], generateSignals[0]);
    AndOrInvert M2 (stage1Signals[2:1], generateSignals[3], propagateSignals[3], generateSignals[2], propagateSignals[2]);
    AndOrInvert M3 (stage1Signals[4:3], generateSignals[5], propagateSignals[5], generateSignals[4], propagateSignals[4]);
    AndOrInvert M4 (stage1Signals[6:5], generateSignals[7], propagateSignals[7], generateSignals[6], propagateSignals[6]);
    AndOrInvert M5 (stage1Signals[8:7], generateSignals[9], propagateSignals[9], generateSignals[8], propagateSignals[8]);
    AndOrInvert M6 (stage1Signals[10:9], generateSignals[11], propagateSignals[11], generateSignals[10], propagateSignals[10]);
    AndOrInvert M7 (stage1Signals[12:11], generateSignals[13], propagateSignals[13], generateSignals[12], propagateSignals[12]);
    AndOrInvert M8 (stage1Signals[14:13], generateSignals[15], propagateSignals[15], generateSignals[14], propagateSignals[14]);

    // Stage 2: Combine signals for the next level
    OrAndInvert M9 (stage2Signals[0], stage1Signals[2], stage1Signals[1], stage1Signals[0]);
    AndOrInvert M10 (stage2Signals[2:1], stage1Signals[6], stage1Signals[5], stage1Signals[4], stage1Signals[3]);
    AndOrInvert M11 (stage2Signals[4:3], stage1Signals[10], stage1Signals[9], stage1Signals[8], stage1Signals[7]);
    AndOrInvert M12 (stage2Signals[6:5], stage1Signals[14], stage1Signals[13], stage1Signals[12], stage1Signals[11]);

    // Stage 3: Further combine signals
    OrAndInvert M13 (stage3Signals[0], stage2Signals[2], stage2Signals[1], stage2Signals[0]);
    AndOrInvert M14 (stage3Signals[2:1], stage2Signals[6], stage2Signals[5], stage2Signals[4], stage2Signals[3]);

    // Stage 4: Final combinations
    OrAndInvert M15 (stage4Signal, stage3Signals[2], stage3Signals[1], stage3Signals[0]);

    // Stage 5: Additional logic
    OrAndInvert M16 (stage5Signal, stage3Signals[2], stage3Signals[1], stage4Signal);

    // Stage 6: Combination of earlier stages
    OrAndInvert M17 (stage6Signals[0], stage2Signals[4], stage2Signals[3], stage3Signals[0]);
    OrAndInvert M18 (stage6Signals[1], stage2Signals[6], stage2Signals[5], stage4Signal);
    OrAndInvert M19 (stage6Signals[2], stage2Signals[6], stage2Signals[5], stage5Signal);

    // Stage 7: More signal combinations
    OrAndInvert M20 (stage7Signals[0], stage1Signals[4], stage1Signals[3], stage2Signals[0]);
    OrAndInvert M21 (stage7Signals[1], stage1Signals[8], stage1Signals[7], stage3Signals[0]);
    OrAndInvert M22 (stage7Signals[2], stage1Signals[12], stage1Signals[11], stage6Signals[0]);
    OrAndInvert M23 (stage7Signals[3], stage1Signals[14], stage1Signals[13], stage4Signal);
    OrAndInvert M24 (stage7Signals[4], stage1Signals[10], stage1Signals[9], stage6Signals[1]);
    OrAndInvert M25 (stage7Signals[5], stage1Signals[14], stage1Signals[13], stage5Signal);
    OrAndInvert M26 (stage7Signals[6], stage1Signals[12], stage1Signals[11], stage6Signals[2]);

    // Stage 8: Final carry calculations
    OrAndInvert M27 (stage8Signals[0], generateSignals[2], propagateSignals[2], stage1Signals[0]);
    OrAndInvert M28 (stage8Signals[1], generateSignals[4], propagateSignals[4], stage2Signals[0]);
    OrAndInvert M29 (stage8Signals[2], generateSignals[6], propagateSignals[6], stage7Signals[0]);
    OrAndInvert M30 (stage8Signals[3], generateSignals[8], propagateSignals[8], stage3Signals[0]);
    OrAndInvert M31 (stage8Signals[4], generateSignals[10], propagateSignals[10], stage7Signals[1]);
    OrAndInvert M32 (stage8Signals[5], generateSignals[12], propagateSignals[12], stage6Signals[0]);
    OrAndInvert M33 (stage8Signals[6], generateSignals[14], propagateSignals[14], stage7Signals[2]);

    // Final carry calculations
    assign intermediateWires[0] = propagateSignals[0] & carryIn;
    assign carrySignals[0] = generateSignals[0] | intermediateWires[0];

    assign intermediateWires[1] = intermediateWires[0] & propagateSignals[1];
    assign carrySignals[1] = stage1Signals[0] | intermediateWires[1];

    assign intermediateWires[2] = intermediateWires[1] & propagateSignals[2];
    assign carrySignals[2] = stage8Signals[0] | intermediateWires[2];

    assign intermediateWires[3] = intermediateWires[2] & propagateSignals[3];
    assign carrySignals[3] = stage2Signals[0] | intermediateWires[3];

    assign intermediateWires[4] = intermediateWires[3] & propagateSignals[4];
    assign carrySignals[4] = stage8Signals[1] | intermediateWires[4];

    assign intermediateWires[5] = intermediateWires[4] & propagateSignals[5];
    assign carrySignals[5] = stage7Signals[0] | intermediateWires[5];

    assign intermediateWires[6] = intermediateWires[5] & propagateSignals[6];
    assign carrySignals[6] = stage8Signals[2] | intermediateWires[6];

    assign intermediateWires[7] = intermediateWires[6] & propagateSignals[7];
    assign carrySignals[7] = stage3Signals[0] | intermediateWires[7];

    assign intermediateWires[8] = intermediateWires[7] & propagateSignals[8];
    assign carrySignals[8] = stage8Signals[3] | intermediateWires[8];

    assign intermediateWires[9] = intermediateWires[8] & propagateSignals[9];
    assign carrySignals[9] = stage7Signals[1] | intermediateWires[9];

    assign intermediateWires[10] = intermediateWires[9] & propagateSignals[10];
    assign carrySignals[10] = stage8Signals[4] | intermediateWires[10];

    assign intermediateWires[11] = intermediateWires[10] & propagateSignals[11];
    assign carrySignals[11] = stage6Signals[0] | intermediateWires[11];

    assign intermediateWires[12] = intermediateWires[11] & propagateSignals[12];
    assign carrySignals[12] = stage8Signals[5] | intermediateWires[12];

    assign intermediateWires[13] = intermediateWires[12] & propagateSignals[13];
    assign carrySignals[13] = stage7Signals[2] | intermediateWires[13];

    assign intermediateWires[14] = intermediateWires[13] & propagateSignals[14];
    assign carrySignals[14] = stage8Signals[6] | intermediateWires[14];

    assign intermediateWires[15] = intermediateWires[14] & propagateSignals[15];
    assign carrySignals[15] = stage5Signal | intermediateWires[15];

    assign out[15:0] = in1 ^ in2 ^ {carrySignals[14:0], carryIn};
    assign out[16] = carrySignals[15];
endmodule
