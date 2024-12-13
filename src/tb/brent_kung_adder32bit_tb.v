`timescale 1ns / 1ps

module testbench;

  reg [31:0] a, b;
  reg carryIn; // Add carryIn signal
  wire [32:0] sum; // Updated to match BrentKungAdder32Bit output width

  // Instantiate the Brent-Kung Adder
  BrentKungAdder32Bit uut (
    .out(sum),
    .in1(a),
    .in2(b),
    .carryIn(carryIn)
  );

  initial begin
    // Set carryIn to 0 for all test cases
    carryIn = 0;

    // Test case 1
    a = 32'h00000001; 
    b = 32'h00000001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 00000002, Cout: 0)", a, b, sum[31:0], sum[32]);

    // Test case 2
    a = 32'hFFFFFFFF; 
    b = 32'h00000001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 00000000, Cout: 1)", a, b, sum[31:0], sum[32]);

    // Test case 3
    a = 32'h0A0A0A0A; 
    b = 32'h0B0B0B0B; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 15151515, Cout: 0)", a, b, sum[31:0], sum[32]);

    // Test case 4
    a = 32'h12345678; 
    b = 32'h87654321; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 99999999, Cout: 0)", a, b, sum[31:0], sum[32]);

    // Test case 5
    a = 32'hAAAAAAAA; 
    b = 32'h55555555; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FFFFFFFF, Cout: 0)", a, b, sum[31:0], sum[32]);

    // Test case 6
    a = 32'hFFFFFFFF; 
    b = 32'hFFFFFFFF; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FFFFFFFE, Cout: 1)", a, b, sum[31:0], sum[32]);

    // End simulation
    $finish;
  end

endmodule
