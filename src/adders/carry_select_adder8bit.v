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

module carrySelect8bit(output [7:0] sum, output cout, input [7:0] a, b);

  wire [3:0] sum0[0:1], sum1[0:1];
  wire cout0[0:1], cout1[0:1];
  wire c1;

  // First 4 bits
  rippleCarry rippleCarry0_0(sum0[0], cout0[0], a[3:0], b[3:0], 1'b0);
  rippleCarry rippleCarry0_1(sum1[0], cout1[0], a[3:0], b[3:0], 1'b1);
  muxWidthFour mux0_sum(sum[3:0], sum0[0], sum1[0], 1'b0);
  muxWidthOne mux0_cout(c1, cout0[0], cout1[0], 1'b0);

  // Next 4 bits
  rippleCarry rippleCarry1_0(sum0[1], cout0[1], a[7:4], b[7:4], c1);
  rippleCarry rippleCarry1_1(sum1[1], cout1[1], a[7:4], b[7:4], c1);
  muxWidthFour mux1_sum(sum[7:4], sum0[1], sum1[1], c1);
  muxWidthOne mux1_cout(cout, cout0[1], cout1[1], c1);

endmodule