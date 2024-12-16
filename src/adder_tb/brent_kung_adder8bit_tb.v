//////////////////////////////////////////////////////////////////////////////////
// Name: Armaan Dayal
// Email: adayal@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module brent_kung_adder8bit_tb;

  reg [7:0] in1, in2;
  reg carryIn;
  wire [8:0] out;  // 8 bits for sum + 1 bit for carry out

  // Instantiate the Brent-Kung Adder
  brent_kung_adder8bit uut (
    .out(out),
    .in1(in1),
    .in2(in2),
    .carryIn(carryIn)
  );

  initial begin
    carryIn = 1'b0; // Set carryIn to 0 for all test cases

    // Test case 1
    in1 = 8'h01; 
    in2 = 8'h01; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 02, CarryOut: 0)", in1, in2, out[7:0], out[8]);

    // Test case 2
    in1 = 8'hFF; 
    in2 = 8'h01; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 00, CarryOut: 1)", in1, in2, out[7:0], out[8]);

    // Test case 3
    in1 = 8'h0A; 
    in2 = 8'h0B; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 15, CarryOut: 0)", in1, in2, out[7:0], out[8]);

    // Test case 4
    in1 = 8'h12; 
    in2 = 8'h34; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 46, CarryOut: 0)", in1, in2, out[7:0], out[8]);

    // Test case 5
    in1 = 8'hAA; 
    in2 = 8'h55; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: FF, CarryOut: 0)", in1, in2, out[7:0], out[8]);

    // Test case 6
    in1 = 8'hFF; 
    in2 = 8'hFF; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: FE, CarryOut: 1)", in1, in2, out[7:0], out[8]);

    // End simulation
    $finish;
  end

endmodule