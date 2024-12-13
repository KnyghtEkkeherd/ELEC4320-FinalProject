`timescale 1ns / 1ps

module testbench;

  reg [31:0] a, b;
  wire [31:0] sum;
  wire cout;

  // Instantiate the Carry Select Adder
  carrySelect32bit uut (
    .sum(sum),
    .cout(cout),
    .a(a),
    .b(b)
  );

  initial begin
    // Test case 1
    a = 32'h00000001; 
    b = 32'h00000001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 00000002, Cout: 0)", a, b, sum, cout);

    // Test case 2
    a = 32'hFFFFFFFF; 
    b = 32'h00000001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 00000000, Cout: 1)", a, b, sum, cout);

    // Test case 3
    a = 32'h0A0A0A0A; 
    b = 32'h0B0B0B0B; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 15151515, Cout: 0)", a, b, sum, cout);

    // Test case 4
    a = 32'h12345678; 
    b = 32'h87654321; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 99999999, Cout: 0)", a, b, sum, cout);

    // Test case 5
    a = 32'hAAAAAAAA; 
    b = 32'h55555555; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FFFFFFFF, Cout: 0)", a, b, sum, cout);

    // Test case 6
    a = 32'hFFFFFFFF; 
    b = 32'hFFFFFFFF; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FFFFFFFE, Cout: 1)", a, b, sum, cout);

    // End simulation
    $finish;
  end

endmodule