//////////////////////////////////////////////////////////////////////////////////
// Name: Armaan Dayal
// Email: adayal@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

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

module carrySelect32bit(output [31:0] sum, output cout, input [31:0] a, b);

  wire [3:0] sum0[0:7], sum1[0:7];
  wire cout0[0:7], cout1[0:7];
  wire c1, c2, c3, c4;

  // First 4 bits
  rippleCarry rippleCarry0_0(sum0[0], cout0[0], a[3:0], b[3:0], 1'b0);
  rippleCarry rippleCarry0_1(sum1[0], cout1[0], a[3:0], b[3:0], 1'b1);
  muxWidthFour mux0_sum(sum[3:0], sum0[0], sum1[0], 1'b0);
  muxWidthOne mux0_cout(c1, cout0[0], cout1[0], 1'b0);

  // Next 4 bits
  rippleCarry rippleCarry1_0(sum0[1], cout0[1], a[7:4], b[7:4], 1'b0);
  rippleCarry rippleCarry1_1(sum1[1], cout1[1], a[7:4], b[7:4], 1'b1);
  muxWidthFour mux1_sum(sum[7:4], sum0[1], sum1[1], c1);
  muxWidthOne mux1_cout(c2, cout0[1], cout1[1], c1);

  // Next 4 bits
  rippleCarry rippleCarry2_0(sum0[2], cout0[2], a[11:8], b[11:8], 1'b0);
  rippleCarry rippleCarry2_1(sum1[2], cout1[2], a[11:8], b[11:8], 1'b1);
  muxWidthFour mux2_sum(sum[11:8], sum0[2], sum1[2], c2);
  muxWidthOne mux2_cout(c3, cout0[2], cout1[2], c2);

  // Next 4 bits
  rippleCarry rippleCarry3_0(sum0[3], cout0[3], a[15:12], b[15:12], 1'b0);
  rippleCarry rippleCarry3_1(sum1[3], cout1[3], a[15:12], b[15:12], 1'b1);
  muxWidthFour mux3_sum(sum[15:12], sum0[3], sum1[3], c3);
  muxWidthOne mux3_cout(c4, cout0[3], cout1[3], c3);

  // Next 4 bits
  rippleCarry rippleCarry4_0(sum0[4], cout0[4], a[19:16], b[19:16], 1'b0);
  rippleCarry rippleCarry4_1(sum1[4], cout1[4], a[19:16], b[19:16], 1'b1);
  muxWidthFour mux4_sum(sum[19:16], sum0[4], sum1[4], c4);
  muxWidthOne mux4_cout(c5, cout0[4], cout1[4], c4);

  // Next 4 bits
  rippleCarry rippleCarry5_0(sum0[5], cout0[5], a[23:20], b[23:20], 1'b0);
  rippleCarry rippleCarry5_1(sum1[5], cout1[5], a[23:20], b[23:20], 1'b1);
  muxWidthFour mux5_sum(sum[23:20], sum0[5], sum1[5], c5);
  muxWidthOne mux5_cout(c6, cout0[5], cout1[5], c5);

  // Next 4 bits
  rippleCarry rippleCarry6_0(sum0[6], cout0[6], a[27:24], b[27:24], 1'b0);
  rippleCarry rippleCarry6_1(sum1[6], cout1[6], a[27:24], b[27:24], 1'b1);
  muxWidthFour mux6_sum(sum[27:24], sum0[6], sum1[6], c6);
  muxWidthOne mux6_cout(c7, cout0[6], cout1[6], c6);

  // Last 4 bits
  rippleCarry rippleCarry7_0(sum0[7], cout0[7], a[31:28], b[31:28], 1'b0);
  rippleCarry rippleCarry7_1(sum1[7], cout1[7], a[31:28], b[31:28], 1'b1);
  muxWidthFour mux7_sum(sum[31:28], sum0[7], sum1[7], c7);
  muxWidthOne mux7_cout(cout, cout0[7], cout1[7], c7);

endmodule