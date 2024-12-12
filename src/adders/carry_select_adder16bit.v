// Full Adder Module
module FA(output sum, cout, input a, b, cin);
  // Sum is the result of XORing inputs and carry-in
  assign sum = a ^ b ^ cin;
  // Carry-out is generated if any two of the three inputs are high
  assign cout = (a & b) | (cin & (a ^ b));
endmodule

// Ripple Carry Adder - 4 bits
module RCA4(output [3:0] sum, output cout, input [3:0] a, b, input cin);
  wire c1, c2, c3; // Internal carry wires for connecting FA outputs

  // Instantiate four full adders for 4-bit addition
  FA fa0(sum[0], c1, a[0], b[0], cin);  // First bit addition with carry-in
  FA fa1(sum[1], c2, a[1], b[1], c1);  // Second bit addition with carry-out from first
  FA fa2(sum[2], c3, a[2], b[2], c2);  // Third bit addition with carry-out from second
  FA fa3(sum[3], cout, a[3], b[3], c3); // Fourth bit addition with carry-out from third
endmodule

// 2-to-1 Multiplexer for 1-bit input
module MUX2to1_w1(output y, input i0, i1, input s);
  // Output y is selected from i0 or i1 based on selector s
  assign y = s ? i1 : i0;
endmodule

// 2-to-1 Multiplexer for 4-bit input
module MUX2to1_w4(output [3:0] y, input [3:0] i0, i1, input s);
  // Output y is selected from i0 or i1 based on selector s for 4 bits
  assign y = s ? i1 : i0;
endmodule

// Carry Select Adder - 16 bits
module CSelA16(output [15:0] sum, output cout, input [15:0] a, b);
  wire [3:0] sum0[0:3], sum1[0:3]; // Arrays for storing sums for carry-in 0 and 1
  wire cout0[0:3], cout1[0:3]; // Arrays for storing carry-outs for carry-in 0 and 1
  wire c1, c2, c3; // Internal carry wires for multiplexers

  // First 4-bit adder with carry-in = 0
  RCA4 rca0_0(sum0[0], cout0[0], a[3:0], b[3:0], 1'b0);
  // First 4-bit adder with carry-in = 1
  RCA4 rca0_1(sum1[0], cout1[0], a[3:0], b[3:0], 1'b1);
  // Multiplex sum and carry-out based on the first carry-in (assumed 0)
  MUX2to1_w4 mux0_sum(sum[3:0], sum0[0], sum1[0], 1'b0);
  MUX2to1_w1 mux0_cout(c1, cout0[0], cout1[0], 1'b0);

  // Second 4-bit adder for the next 4 bits
  RCA4 rca1_0(sum0[1], cout0[1], a[7:4], b[7:4], 1'b0);
  RCA4 rca1_1(sum1[1], cout1[1], a[7:4], b[7:4], 1'b1);
  // Select the appropriate sum and carry-out for the second 4 bits
  MUX2to1_w4 mux1_sum(sum[7:4], sum0[1], sum1[1], c1);
  MUX2to1_w1 mux1_cout(c2, cout0[1], cout1[1], c1);

  // Third 4-bit adder for the next 4 bits
  RCA4 rca2_0(sum0[2], cout0[2], a[11:8], b[11:8], 1'b0);
  RCA4 rca2_1(sum1[2], cout1[2], a[11:8], b[11:8], 1'b1);
  // Select the appropriate sum and carry-out for the third 4 bits
  MUX2to1_w4 mux2_sum(sum[11:8], sum0[2], sum1[2], c2);
  MUX2to1_w1 mux2_cout(c3, cout0[2], cout1[2], c2);

  // Fourth 4-bit adder for the last 4 bits
  RCA4 rca3_0(sum0[3], cout0[3], a[15:12], b[15:12], 1'b0);
  RCA4 rca3_1(sum1[3], cout1[3], a[15:12], b[15:12], 1'b1);
  // Select the final sum and carry-out
  MUX2to1_w4 mux3_sum(sum[15:12], sum0[3], sum1[3], c3);
  MUX2to1_w1 mux3_cout(cout, cout0[3], cout1[3], c3);
endmodule

// === TESTBENCH ===

// `timescale 1ns / 1ps

// module testbench;

//   reg [15:0] a, b;
//   reg cin;
//   wire [15:0] sum;
//   wire cout;

//   // Instantiate the Carry Select Adder
//   CSelA16 uut (
//     .sum(sum),
//     .cout(cout),
//     .a(a),
//     .b(b)
//   );

//   initial begin
//     // Test case 1
//     a = 16'h0001; 
//     b = 16'h0001; 
//     cin = 0;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: 0002, Cout: 0)", a, b, cin, sum, cout);

//     // Test case 2
//     a = 16'hFFFF; 
//     b = 16'h0001; 
//     cin = 0;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: 0000, Cout: 1)", a, b, cin, sum, cout);

//     // Test case 3
//     a = 16'h0A0A; 
//     b = 16'h0B0B; 
//     cin = 0;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: 1515, Cout: 0)", a, b, cin, sum, cout);

//     // Test case 4
//     a = 16'h1234; 
//     b = 16'h5678; 
//     cin = 1;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: 68AC, Cout: 0)", a, b, cin, sum, cout);

//     // Test case 5
//     a = 16'hAAAA; 
//     b = 16'h5555; 
//     cin = 0;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: FFFF, Cout: 0)", a, b, cin, sum, cout);

//     // Test case 6
//     a = 16'hFFFF; 
//     b = 16'hFFFF; 
//     cin = 1;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: FFFE, Cout: 1)", a, b, cin, sum, cout);

//     // End simulation
//     $finish;
//   end

// endmodule