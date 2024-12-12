// Full Adder
module FA(output sum, cout, input a, b, cin);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (cin & (a ^ b));
endmodule

// Ripple Carry Adder with cin - 4 bits
module RCA4(output [3:0] sum, output cout, input [3:0] a, b, input cin);
  wire c1, c2, c3;

  FA fa0(sum[0], c1, a[0], b[0], cin);
  FA fa1(sum[1], c2, a[1], b[1], c1);
  FA fa2(sum[2], c3, a[2], b[2], c2);
  FA fa3(sum[3], cout, a[3], b[3], c3);
endmodule

module MUX2to1_w1(output y, input i0, i1, input s);
  assign y = s ? i1 : i0;
endmodule

module MUX2to1_w4(output [3:0] y, input [3:0] i0, i1, input s);
  assign y = s ? i1 : i0;
endmodule

// Carry Select Adder - 32 bits
module CSelA32(output [31:0] sum, output cout, input [31:0] a, b);

  wire [3:0] sum0[0:7], sum1[0:7];
  wire cout0[0:7], cout1[0:7];
  wire c1, c2, c3, c4;

  // First 4 bits
  RCA4 rca0_0(sum0[0], cout0[0], a[3:0], b[3:0], 1'b0);
  RCA4 rca0_1(sum1[0], cout1[0], a[3:0], b[3:0], 1'b1);
  MUX2to1_w4 mux0_sum(sum[3:0], sum0[0], sum1[0], 1'b0);
  MUX2to1_w1 mux0_cout(c1, cout0[0], cout1[0], 1'b0);

  // Next 4 bits
  RCA4 rca1_0(sum0[1], cout0[1], a[7:4], b[7:4], 1'b0);
  RCA4 rca1_1(sum1[1], cout1[1], a[7:4], b[7:4], 1'b1);
  MUX2to1_w4 mux1_sum(sum[7:4], sum0[1], sum1[1], c1);
  MUX2to1_w1 mux1_cout(c2, cout0[1], cout1[1], c1);

  // Next 4 bits
  RCA4 rca2_0(sum0[2], cout0[2], a[11:8], b[11:8], 1'b0);
  RCA4 rca2_1(sum1[2], cout1[2], a[11:8], b[11:8], 1'b1);
  MUX2to1_w4 mux2_sum(sum[11:8], sum0[2], sum1[2], c2);
  MUX2to1_w1 mux2_cout(c3, cout0[2], cout1[2], c2);

  // Next 4 bits
  RCA4 rca3_0(sum0[3], cout0[3], a[15:12], b[15:12], 1'b0);
  RCA4 rca3_1(sum1[3], cout1[3], a[15:12], b[15:12], 1'b1);
  MUX2to1_w4 mux3_sum(sum[15:12], sum0[3], sum1[3], c3);
  MUX2to1_w1 mux3_cout(c4, cout0[3], cout1[3], c3);

  // Next 4 bits
  RCA4 rca4_0(sum0[4], cout0[4], a[19:16], b[19:16], 1'b0);
  RCA4 rca4_1(sum1[4], cout1[4], a[19:16], b[19:16], 1'b1);
  MUX2to1_w4 mux4_sum(sum[19:16], sum0[4], sum1[4], c4);
  MUX2to1_w1 mux4_cout(c5, cout0[4], cout1[4], c4);

  // Next 4 bits
  RCA4 rca5_0(sum0[5], cout0[5], a[23:20], b[23:20], 1'b0);
  RCA4 rca5_1(sum1[5], cout1[5], a[23:20], b[23:20], 1'b1);
  MUX2to1_w4 mux5_sum(sum[23:20], sum0[5], sum1[5], c5);
  MUX2to1_w1 mux5_cout(c6, cout0[5], cout1[5], c5);

  // Next 4 bits
  RCA4 rca6_0(sum0[6], cout0[6], a[27:24], b[27:24], 1'b0);
  RCA4 rca6_1(sum1[6], cout1[6], a[27:24], b[27:24], 1'b1);
  MUX2to1_w4 mux6_sum(sum[27:24], sum0[6], sum1[6], c6);
  MUX2to1_w1 mux6_cout(c7, cout0[6], cout1[6], c6);

  // Last 4 bits
  RCA4 rca7_0(sum0[7], cout0[7], a[31:28], b[31:28], 1'b0);
  RCA4 rca7_1(sum1[7], cout1[7], a[31:28], b[31:28], 1'b1);
  MUX2to1_w4 mux7_sum(sum[31:28], sum0[7], sum1[7], c7);
  MUX2to1_w1 mux7_cout(cout, cout0[7], cout1[7], c7);

endmodule

// === TESTBENCH === 

// `timescale 1ns / 1ps

// module testbench;

//   reg [31:0] a, b;
//   reg cin;
//   wire [31:0] sum;
//   wire cout;

//   // Instantiate the Carry Select Adder
//   CSelA32 uut (
//     .sum(sum),
//     .cout(cout),
//     .a(a),
//     .b(b)
//   );

//   initial begin
//     // Test case 1
//     a = 32'h00000001; 
//     b = 32'h00000001; 
//     cin = 0;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: 00000002, Cout: 0)", a, b, cin, sum, cout);

//     // Test case 2
//     a = 32'hFFFFFFFF; 
//     b = 32'h00000001; 
//     cin = 0;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: 00000000, Cout: 1)", a, b, cin, sum, cout);

//     // Test case 3
//     a = 32'h0A0A0A0A; 
//     b = 32'h0B0B0B0B; 
//     cin = 0;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: 15151515, Cout: 0)", a, b, cin, sum, cout);

//     // Test case 4
//     a = 32'h12345678; 
//     b = 32'h87654321; 
//     cin = 1;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: 9ABCDEF9, Cout: 0)", a, b, cin, sum, cout);

//     // Test case 5
//     a = 32'hAAAA5555; 
//     b = 32'h5555AAAA; 
//     cin = 0;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: FFFFFFFF, Cout: 0)", a, b, cin, sum, cout);

//     // Test case 6
//     a = 32'hFFFFFFFF; 
//     b = 32'hFFFFFFFF; 
//     cin = 1;
//     #10;
//     $display("A: %h, B: %h, Cin: %b => Sum: %h, Cout: %b (Expected: Sum: FFFFFFFE, Cout: 1)", a, b, cin, sum, cout);

//     // End simulation
//     $finish;
//   end

// endmodule