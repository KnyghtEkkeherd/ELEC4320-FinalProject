`timescale 1ns / 1ps

module testbench;

  reg [15:0] a, b;
  reg carryIn;
  wire [15:0] outputFinal;
  wire carryOutFinal;

  // Instantiate the Brent-Kung Adder
  brent_kung_adder16bit uut (
    .outputFinal(outputFinal),
    .carryOutFinal(carryOutFinal),
    .out(), // unused
    .in1(a),
    .in2(b),
    .carryIn(carryIn)
  );

  initial begin
    carryIn = 1'b0; // Set carryIn to 0 for all test cases

    // Test case 1
    a = 16'h0001; 
    b = 16'h0001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 0002, CarryOut: 0)", a, b, outputFinal, carryOutFinal);

    // Test case 2
    a = 16'hFFFF; 
    b = 16'h0001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 0000, CarryOut: 1)", a, b, outputFinal, carryOutFinal);

    // Test case 3
    a = 16'h0A0A; 
    b = 16'h0B0B; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 1515, CarryOut: 0)", a, b, outputFinal, carryOutFinal);

    // Test case 4
    a = 16'h1234; 
    b = 16'h5678; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 68AC, CarryOut: 0)", a, b, outputFinal, carryOutFinal);

    // Test case 5
    a = 16'hAAAA; 
    b = 16'h5555; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: FFFF, CarryOut: 0)", a, b, outputFinal, carryOutFinal);

    // Test case 6
    a = 16'hFFFF; 
    b = 16'hFFFF; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: FFFE, CarryOut: 1)", a, b, outputFinal, carryOutFinal);

    // End simulation
    $finish;
  end

endmodule
