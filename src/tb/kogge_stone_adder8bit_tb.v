//////////////////////////////////////////////////////////////////////////////////
// Name: Armaan Dayal
// Email: adayal@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module tb_kogge_stone_adder8bit;

    reg [7:0] a;            // Input A
    reg [7:0] b;            // Input B
    reg carryIn;           // Carry input
    wire [7:0] sum;        // Sum output
    wire carryOut;         // Carry output

    // Instantiate the Kogge-Stone adder
    kogge_stone_adder8bit uut (
        .A(a),
        .B(b),
        .Cin(carryIn),
        .S(sum),
        .Cout(carryOut)
    );

    initial begin
        // Set carryIn to 0 for all test cases
        carryIn = 0;

        // Test case 1: 01 + 01
        a = 8'h01; 
        b = 8'h01; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 02, Cout: 0)", a, b, sum, carryOut);

        // Test case 2: FF + 01
        a = 8'hFF; 
        b = 8'h01; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 00, Cout: 1)", a, b, sum, carryOut);

        // Test case 3: 0A + 0B
        a = 8'h0A; 
        b = 8'h0B; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 15, Cout: 0)", a, b, sum, carryOut);

        // Test case 4: 12 + 34
        a = 8'h12; 
        b = 8'h34; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 46, Cout: 0)", a, b, sum, carryOut);

        // Test case 5: AA + 55
        a = 8'hAA; 
        b = 8'h55; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FF, Cout: 0)", a, b, sum, carryOut);

        // Test case 6: FF + FF
        a = 8'hFF; 
        b = 8'hFF; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FE, Cout: 1)", a, b, sum, carryOut);

        // End simulation
        $finish;
    end
endmodule