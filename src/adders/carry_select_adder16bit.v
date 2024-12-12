module fullAdder(output sum, cout, input a, b, cin);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (cin & (a ^ b));
endmodule

module rippleCarry(output [3:0] sum, output cout, input [3:0] a, b, input cin);
  wire c1, c2, c3;

  fullAdder fullAdder0(sum[0], c1, a[0], b[0], cin);
  fullAdder fullAdder1(sum[1], c2, a[1], b[1], c1);
  fullAdder fullAdder2(sum[2], c3, a[2], b[2], c2);
  fullAdder fullAdder3(sum[3], cout, a[3], b[3], c3);
endmodule

module muxWidthOne(output y, input i0, i1, input s);
  assign y = s ? i1 : i0;
endmodule

module muxWidthFour(output [3:0] y, input [3:0] i0, i1, input s);
  assign y = s ? i1 : i0;
endmodule

module carrySelect16bit(output [15:0] sum, output cout, input [15:0] a, b);

  wire [3:0] sum0[0:3], sum1[0:3];
  wire cout0[0:3], cout1[0:3];
  wire c1, c2, c3;

  rippleCarry rippleCarry0_0(sum0[0], cout0[0], a[3:0], b[3:0], 1'b0);
  rippleCarry rippleCarry0_1(sum1[0], cout1[0], a[3:0], b[3:0], 1'b1);
  muxWidthFour mux0_sum(sum[3:0], sum0[0], sum1[0], 1'b0);
  muxWidthOne mux0_cout(c1, cout0[0], cout1[0], 1'b0);

  rippleCarry rippleCarry1_0(sum0[1], cout0[1], a[7:4], b[7:4], 1'b0);
  rippleCarry rippleCarry1_1(sum1[1], cout1[1], a[7:4], b[7:4], 1'b1);
  muxWidthFour mux1_sum(sum[7:4], sum0[1], sum1[1], c1);
  muxWidthOne mux1_cout(c2, cout0[1], cout1[1], c1);

  rippleCarry rippleCarry2_0(sum0[2], cout0[2], a[11:8], b[11:8], 1'b0);
  rippleCarry rippleCarry2_1(sum1[2], cout1[2], a[11:8], b[11:8], 1'b1);
  muxWidthFour mux2_sum(sum[11:8], sum0[2], sum1[2], c2);
  muxWidthOne mux2_cout(c3, cout0[2], cout1[2], c2);

  rippleCarry rippleCarry3_0(sum0[3], cout0[3], a[15:12], b[15:12], 1'b0);
  rippleCarry rippleCarry3_1(sum1[3], cout1[3], a[15:12], b[15:12], 1'b1);
  muxWidthFour mux3_sum(sum[15:12], sum0[3], sum1[3], c3);
  muxWidthOne mux3_cout(cout, cout0[3], cout1[3], c3);

endmodule

// === TESTBENCH ===

// `timescale 1ns / 1ps

// module testbench;

//   reg [15:0] a, b;
//   reg cin;
//   wire [15:0] sum;
//   wire cout;

//   // Instantiate the Carry Select Adder
//   carrySelect16bit uut (
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