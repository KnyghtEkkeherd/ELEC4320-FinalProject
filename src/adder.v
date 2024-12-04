`timescale 1ns / 1ps

module full_adder (
    input  A,
    input  B,
    input  Carry_in,
    output Carry_out,
    output Sum
);
    assign Carry_out = (A & B) | (Carry_in & (A ^ B));
    assign Sum = Carry_in ^ (A ^ B);
endmodule

// 32-bit ripple carry adder
module ripple_carry_adder #(
    parameter NUM_BITS = 32
) (
    input [NUM_BITS-1:0] A,
    input [NUM_BITS-1:0] B,
    output [NUM_BITS-1:0] Sum,
    output C_out,
    output ready
);

    wire [NUM_BITS-1:0] carry_wire;
    genvar i;
    generate
        for (i = 0; i < NUM_BITS; i = i + 1) begin
            if (i == 0) begin
                full_adder fa (
                    .A(A[i]),
                    .B(B[i]),
                    .Carry_in(1'b0),
                    .Carry_out(carry_wire[i]),
                    .Sum(Sum[i])
                );
            end else if (i == NUM_BITS - 1) begin
                full_adder fa (
                    .A(A[i]),
                    .B(B[i]),
                    .Carry_in(carry_wire[i-1]),
                    .Carry_out(C_out),
                    .Sum(Sum[i])
                );
            end else begin
                full_adder fa (
                    .A(A[i]),
                    .B(B[i]),
                    .Carry_in(carry_wire[i-1]),
                    .Carry_out(carry_wire[i]),
                    .Sum(Sum[i])
                );
            end
        end
    endgenerate

    assign ready = 1'b1;
endmodule
