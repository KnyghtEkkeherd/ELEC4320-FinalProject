`timescale 1ns / 1ps

module testbench;

  reg [7:0] a, b;
  reg carryIn;
  wire [8:0] sum;

  // Instantiate the Brent-Kung Adder
  BrentKungAdder8Bit uut (
    .out(sum),
    .in1(a),
    .in2(b),
    .carryIn(carryIn)
  );

  initial begin
    carryIn = 1'b0; // Set carryIn to 0 for all test cases

    // Test case 1
    a = 8'h01; 
    b = 8'h01; 
    #10;
    $display("A: %h, B: %h, CarryIn: %b => Sum: %h, Cout: %b (Expected: Sum: 02, Cout: 0)", a, b, carryIn, sum[7:0], sum[8]);

    // Test case 2
    a = 8'hFF; 
    b = 8'h01; 
    #10;
    $display("A: %h, B: %h, CarryIn: %b => Sum: %h, Cout: %b (Expected: Sum: 00, Cout: 1)", a, b, carryIn, sum[7:0], sum[8]);

    // Test case 3
    a = 8'h0A; 
    b = 8'h0B; 
    #10;
    $display("A: %h, B: %h, CarryIn: %b => Sum: %h, Cout: %b (Expected: Sum: 15, Cout: 0)", a, b, carryIn, sum[7:0], sum[8]);

    // Test case 4
    a = 8'h12; 
    b = 8'h34; 
    #10;
    $display("A: %h, B: %h, CarryIn: %b => Sum: %h, Cout: %b (Expected: Sum: 46, Cout: 0)", a, b, carryIn, sum[7:0], sum[8]);

    // Test case 5
    a = 8'hAA; 
    b = 8'h55; 
    #10;
    $display("A: %h, B: %h, CarryIn: %b => Sum: %h, Cout: %b (Expected: Sum: FF, Cout: 0)", a, b, carryIn, sum[7:0], sum[8]);

    // Test case 6
    a = 8'hFF; 
    b = 8'hFF; 
    #10;
    $display("A: %h, B: %h, CarryIn: %b => Sum: %h, Cout: %b (Expected: Sum: FE, Cout: 1)", a, b, carryIn, sum[7:0], sum[8]);

    // End simulation
    $finish;
  end

endmodule
