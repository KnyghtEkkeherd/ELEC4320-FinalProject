module OrAndInvert (output out, input in1, in2, in3);
    assign out = in1 | (in2 & in3);
endmodule

module AndOrInvert (output [1:0] out, input in1, in2, in3, in4);
    assign out[0] = in2 & in4;
    assign out[1] = in1 | (in2 & in3);
endmodule

module brent_kung_adder8bit (output [8:0] out, input [7:0] in1, in2, input carryIn);
    wire [7:0] generateSignals, propagateSignals;
    wire [6:0] stage1Signals;
    wire [2:0] stage2Signals;
    wire [1:0] stage3Signals;
    wire stage4Signal;
    wire [1:0] stage5Signals;
    wire [3:0] stage6Signals;
    wire [6:0] intermediateWires;
    wire [7:0] carrySignals;

    assign generateSignals  = in1 & in2;
    assign propagateSignals = in1 | in2;

    // Stage 1: Generate first level signals
    OrAndInvert M1 (stage1Signals[0], generateSignals[1], propagateSignals[1], generateSignals[0]);
    AndOrInvert M2 (stage1Signals[2:1], generateSignals[3], propagateSignals[3], generateSignals[2], propagateSignals[2]);
    AndOrInvert M3 (stage1Signals[4:3], generateSignals[5], propagateSignals[5], generateSignals[4], propagateSignals[4]);
    AndOrInvert M4 (stage1Signals[6:5], generateSignals[7], propagateSignals[7], generateSignals[6], propagateSignals[6]);

    // Stage 2: Combine signals for the next level
    OrAndInvert M5 (stage2Signals[0], stage1Signals[2], stage1Signals[1], stage1Signals[0]);
    AndOrInvert M6 (stage2Signals[2:1], stage1Signals[6], stage1Signals[5], stage1Signals[4], stage1Signals[3]);

    // Stage 3: Further combine signals
    OrAndInvert M7 (stage3Signals[0], stage2Signals[2], stage2Signals[1], stage2Signals[0]);
    OrAndInvert M8 (stage3Signals[1], stage2Signals[2], stage2Signals[1], stage3Signals[0]);

    // Stage 4: Final combination
    OrAndInvert M9 (stage4Signal, stage3Signals[1], stage3Signals[0], stage2Signals[0]);

    // Stage 5: Additional logic
    OrAndInvert M10 (stage5Signals[0], stage1Signals[4], stage1Signals[3], stage2Signals[0]);
    OrAndInvert M11 (stage5Signals[1], stage1Signals[6], stage1Signals[5], stage3Signals[0]);

    // Stage 6: More signal combinations
    OrAndInvert M12 (stage6Signals[0], generateSignals[2], propagateSignals[2], stage1Signals[0]);
    OrAndInvert M13 (stage6Signals[1], generateSignals[4], propagateSignals[4], stage2Signals[0]);
    OrAndInvert M14 (stage6Signals[2], generateSignals[6], propagateSignals[6], stage5Signals[0]);
    OrAndInvert M15 (stage6Signals[3], generateSignals[7], propagateSignals[7], stage5Signals[1]);

    // Final carry calculations
    assign intermediateWires[0] = propagateSignals[0] & carryIn;
    assign carrySignals[0] = generateSignals[0] | intermediateWires[0];

    assign intermediateWires[1] = intermediateWires[0] & propagateSignals[1];
    assign carrySignals[1] = stage1Signals[0] | intermediateWires[1];

    assign intermediateWires[2] = intermediateWires[1] & propagateSignals[2];
    assign carrySignals[2] = stage6Signals[0] | intermediateWires[2];

    assign intermediateWires[3] = intermediateWires[2] & propagateSignals[3];
    assign carrySignals[3] = stage2Signals[0] | intermediateWires[3];

    assign intermediateWires[4] = intermediateWires[3] & propagateSignals[4];
    assign carrySignals[4] = stage6Signals[1] | intermediateWires[4];

    assign intermediateWires[5] = intermediateWires[4] & propagateSignals[5];
    assign carrySignals[5] = stage5Signals[0] | intermediateWires[5];

    assign intermediateWires[6] = intermediateWires[5] & propagateSignals[6];
    assign carrySignals[6] = stage6Signals[2] | intermediateWires[6];

    assign carrySignals[7] = stage6Signals[3] | (intermediateWires[6] & propagateSignals[7]);

    assign out[7:0] = in1 ^ in2 ^ {carrySignals[6:0], carryIn};
    assign out[8] = carrySignals[7];
endmodule
