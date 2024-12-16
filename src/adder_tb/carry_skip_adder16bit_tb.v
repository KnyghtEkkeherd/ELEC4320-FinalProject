//////////////////////////////////////////////////////////////////////////////////
// Name: Armaan Dayal
// Email: adayal@connect.ust.hk
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module carry_skip_adder16bit_tb;

    reg [15:0] a, b;  // Declare input registers
    reg carryIn;      // Carry input
    wire [15:0] sum;  // Sum output
    wire carryOut;    // Carry output

    // Instantiate the 16-bit Carry Skip Adder
    carry_skip_adder16bit uut (
        .A(a),
        .B(b),
        .Cin(carryIn),
        .Sum(sum),
        .Cout(carryOut)
    );

    initial begin
        // Set carryIn to 0 for all test cases
        carryIn = 0;

        // Test case 1: 0x0001 + 0x0001
        a = 16'h0001; 
        b = 16'h0001; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 0002, Cout: 0)", a, b, sum, carryOut);

        // Test case 2: 0xFFFF + 0x0001
        a = 16'hFFFF; 
        b = 16'h0001; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 0000, Cout: 1)", a, b, sum, carryOut);

        // Test case 3: 0x0A0A + 0x0B0B
        a = 16'h0A0A; 
        b = 16'h0B0B; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 1515, Cout: 0)", a, b, sum, carryOut);

        // Test case 4: 0x1234 + 0x5678
        a = 16'h1234; 
        b = 16'h5678; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: 68AC, Cout: 0)", a, b, sum, carryOut);

        // Test case 5: 0xAAAA + 0x5555
        a = 16'hAAAA; 
        b = 16'h5555; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FFFF, Cout: 0)", a, b, sum, carryOut);

        // Test case 6: 0xFFFF + 0xFFFF
        a = 16'hFFFF; 
        b = 16'hFFFF; 
        #10;
        $display("A: %h, B: %h => Sum: %h, Cout: %b (Expected: Sum: FFFE, Cout: 1)", a, b, sum, carryOut);

        // End simulation
        $finish;
    end

endmodule