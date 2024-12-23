//////////////////////////////////////////////////////////////////////////////////
// Name: Armaan Dayal
// Email: adayal@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module carry_select_adder8bit_tb;

  reg [7:0] a, b;
  wire [7:0] sum;
  wire cout;

  // Instantiate the Carry Select Adder
  carrySelect8bit uut (
    .sum(sum),
    .cout(cout),
    .a(a),
    .b(b)
  );

  initial begin
    // Test case 1
    a = 8'h01; 
    b = 8'h01; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 02, Cout: 0)", a, b, sum, cout);

    // Test case 2
    a = 8'hFF; 
    b = 8'h01; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 00, Cout: 1)", a, b, sum, cout);

    // Test case 3
    a = 8'h0A; 
    b = 8'h0B; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 15, Cout: 0)", a, b, sum, cout);

    // Test case 4
    a = 8'h12; 
    b = 8'h34; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 46, Cout: 0)", a, b, sum, cout);

    // Test case 5
    a = 8'hAA; 
    b = 8'h55; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FF, Cout: 0)", a, b, sum, cout);

    // Test case 6
    a = 8'hFF; 
    b = 8'hFF; 
    #10;
    $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FE, Cout: 1)", a, b, sum, cout);

    // End simulation
    $finish;
  end

endmodule