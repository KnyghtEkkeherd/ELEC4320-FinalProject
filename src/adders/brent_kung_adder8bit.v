// THIS DOES NOT WORK

module OrAndInvert (out, in1, in2, in3);
    output out;
    input in1, in2, in3;
    assign out = in1 | (in2 & in3);
endmodule

module AndOrInvert (out, in1, in2, in3, in4);
    output [1:0] out;
    input in1, in2, in3, in4;
    assign out[0] = in2 & in4;
    assign out[1] = in1 | (in2 & in3);
endmodule

module brent_kung_adder8bit (out, outputFinal, carryOutFinal, in1, in2, carryIn);
    output [8:0] out;
    output [7:0] outputFinal;
    output carryOutFinal;
    input [7:0] in1, in2;
    input carryIn;

    wire [7:0] generateSignals, propagateSignals;
    wire [6:0] stage1Signals;
    wire [2:0] stage2Signals;
    wire stage3Signal;
    wire [7:0] intermediateWires;
    wire [7:0] carrySignals;

    assign generateSignals = in1 & in2;
    assign propagateSignals = in1 | in2;

    // Stage 1: Generate first level signals
    OrAndInvert M1(stage1Signals[0], generateSignals[1], propagateSignals[1], generateSignals[0]);
    AndOrInvert M2(stage1Signals[2:1], generateSignals[3], propagateSignals[3], generateSignals[2], propagateSignals[2]);
    AndOrInvert M3(stage1Signals[4:3], generateSignals[5], propagateSignals[5], generateSignals[4], propagateSignals[4]);
    AndOrInvert M4(stage1Signals[6:5], generateSignals[7], propagateSignals[7], generateSignals[6], propagateSignals[6]);

    // Stage 2: Combine signals for the next level
    OrAndInvert M5(stage2Signals[0], stage1Signals[2], stage1Signals[1], stage1Signals[0]);
    AndOrInvert M6(stage2Signals[2:1], stage1Signals[6], stage1Signals[5], stage1Signals[4], stage1Signals[3]);

    // Stage 3: Final combinations
    OrAndInvert M7(stage3Signal, stage2Signals[2], stage2Signals[1], stage2Signals[0]);

    // Final carry calculations
    assign intermediateWires[0] = propagateSignals[0] & carryIn;
    assign carrySignals[0] = generateSignals[0] | intermediateWires[0];

    assign intermediateWires[1] = intermediateWires[0] & propagateSignals[1];
    assign carrySignals[1] = stage1Signals[0] | intermediateWires[1];

    assign intermediateWires[2] = intermediateWires[1] & propagateSignals[2];
    assign carrySignals[2] = stage2Signals[0] | intermediateWires[2];

    assign intermediateWires[3] = intermediateWires[2] & propagateSignals[3];
    assign carrySignals[3] = stage1Signals[1] | intermediateWires[3];

    assign intermediateWires[4] = intermediateWires[3] & propagateSignals[4];
    assign carrySignals[4] = stage2Signals[1] | intermediateWires[4];

    assign intermediateWires[5] = intermediateWires[4] & propagateSignals[5];
    assign carrySignals[5] = stage1Signals[3] | intermediateWires[5];

    assign intermediateWires[6] = intermediateWires[5] & propagateSignals[6];
    assign carrySignals[6] = stage3Signal | intermediateWires[6];

    assign intermediateWires[7] = intermediateWires[6] & propagateSignals[7];
    assign carrySignals[7] = stage1Signals[5] | intermediateWires[7];

    assign out[7:0] = in1 ^ in2 ^ {carrySignals[6:0], carryIn};
    assign out[8] = carrySignals[7];

    assign outputFinal = out[7:0];
    assign carryOutFinal = out[8];
endmodule
