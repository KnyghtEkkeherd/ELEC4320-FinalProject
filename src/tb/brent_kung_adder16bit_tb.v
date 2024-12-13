`timescale 1ns / 1ps

module testbench;

  reg [15:0] in1, in2;
  reg carryIn;
  wire [16:0] out;

  // Instantiate the Brent-Kung Adder
  brent_kung_adder16bit uut (
    .out(out),
    .in1(in1),
    .in2(in2),
    .carryIn(carryIn)
  );

  initial begin
    carryIn = 1'b0; // Set carryIn to 0 for all test cases

    // Test case 1
    in1 = 16'h0001; 
    in2 = 16'h0001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 0002, CarryOut: 0)", in1, in2, out[15:0], out[16]);

    // Test case 2
    in1 = 16'hFFFF; 
    in2 = 16'h0001; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 0000, CarryOut: 1)", in1, in2, out[15:0], out[16]);

    // Test case 3
    in1 = 16'h0A0A; 
    in2 = 16'h0B0B; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 1515, CarryOut: 0)", in1, in2, out[15:0], out[16]);

    // Test case 4
    in1 = 16'h1234; 
    in2 = 16'h5678; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: 68AC, CarryOut: 0)", in1, in2, out[15:0], out[16]);

    // Test case 5
    in1 = 16'hAAAA; 
    in2 = 16'h5555; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: FFFF, CarryOut: 0)", in1, in2, out[15:0], out[16]);

    // Test case 6
    in1 = 16'hFFFF; 
    in2 = 16'hFFFF; 
    #10;
    $display("A: %h, B: %h => Sum: %h, CarryOut: %b (Expected: Sum: FFFE, CarryOut: 1)", in1, in2, out[15:0], out[16]);

    // End simulation
    $finish;
  end

endmodule
