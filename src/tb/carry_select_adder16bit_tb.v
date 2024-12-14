//////////////////////////////////////////////////////////////////////////////////
// Name: Armaan Dayal
// Email: adayal@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module carry_select_adder16bit_tb;

  reg [15:0] a, b;
  wire [15:0] sum;
  wire cout;

  // Instantiate the Carry Select Adder
  carrySelect16bit uut (
    .sum(sum),
    .cout(cout),
    .a(a),
    .b(b)
  );

  initial begin
    // Test case 1
    a = 16'h0001; 
    b = 16'h0001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 0002, Cout: 0)", a, b, sum, cout);

    // Test case 2
    a = 16'hFFFF; 
    b = 16'h0001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 0000, Cout: 1)", a, b, sum, cout);

    // Test case 3
    a = 16'h0A0A; 
    b = 16'h0B0B; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 1515, Cout: 0)", a, b, sum, cout);

    // Test case 4
    a = 16'h1234; 
    b = 16'h5678; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 68AC, Cout: 0)", a, b, sum, cout);

    // Test case 5
    a = 16'hAAAA; 
    b = 16'h5555; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FFFF, Cout: 0)", a, b, sum, cout);

    // Test case 6
    a = 16'hFFFF; 
    b = 16'hFFFF; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FFFE, Cout: 1)", a, b, sum, cout);

    // End simulation
    $finish;
  end

endmodule