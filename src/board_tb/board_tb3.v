`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Wiktor Kowalczyk
// Student ID: 20814029
// Email: wmkowalczyk@connect.ust.hk
// Description: Testbench to test the Brent-Kung implementation on the board
//////////////////////////////////////////////////////////////////////////////////

module tb_top;

    // Testbench signals
    reg CLK100MHZ;  // Clock signal
    reg btnU, btnL, btnR, btnD, btnC;  // Button inputs
    reg [15:0] sw;  // Switch inputs
    wire [0:6] seg;  // 7-segment display segment pattern
    wire [3:0] an;  // 7-segment display anodes
    wire [1:0] LED;  // LEDs to specify the current display mode
    wire dp;  // Display dot point

    // Instantiate the top module
    top uut (
        .CLK100MHZ(CLK100MHZ),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .btnC(btnC),
        .sw(sw),
        .seg(seg),
        .an(an),
        .LED(LED),
        .dp(dp)
    );

    // Clock generation
    initial begin
        CLK100MHZ = 0;
        forever #5 CLK100MHZ = ~CLK100MHZ;  // 100MHz clock
    end

    // Stimulus process
    initial begin
        // Initialize inputs
        btnU = 0;
        btnL = 0;
        btnR = 0;
        btnD = 0;
        btnC = 0;
        sw   = 16'b0000000000000000;  // Reset switches

        // Wait for global reset
        #1_000_000;

        // Test case 1: choose Brent-Kung
        btnU = 1;  // Choose Brent-Kung
        #1_000_000;  // Wait for a clock cycle
        btnU = 0;

        // Set the first value
        sw   = 16'b0000000000001111;  // Set first switch to 15
        #1_000_000;  // Wait for a clock cycle

        // Choose operand A
        btnD = 1;
        #2_000_000;  // Increased delay
        btnD = 0;

        #10_000_000;  // Wait for processing

        // Set the second value
        sw = 16'b0000000000000001;  // Set second switch to 1
        #1_000_000;

        // Choose operand B
        btnL = 1;
        #2_000_000;  // Increased delay
        btnL = 0;

        btnR = 1;  // Finish input
        #2_000_000;  // Increased delay
        btnR = 0;

        #10_000_000;  // Wait for output

        // Clear display for next test case
        btnC = 1;
        #1_000_000;
        btnC = 0;
        #10_000_000;

        // Test case 2: Brent-Kung with inputs (5, 10)
        btnU = 1;  // Choose Brent-Kung
        #1_000_000;
        btnU = 0;

        sw   = 16'b0000000000000101;  // Set first switch to 5
        #1_000_000;

        btnD = 1;  // Choose operand A
        #2_000_000;  // Increased delay
        btnD = 0;

        #10_000_000;  // Wait for processing

        sw = 16'b0000000000001010;  // Set second switch to 10
        #1_000_000;

        btnL = 1;  // Choose operand B
        #2_000_000;  // Increased delay
        btnL = 0;

        btnR = 1;  // Finish input
        #2_000_000;  // Increased delay
        btnR = 0;

        #10_000_000;  // Wait for output

        // Clear display for next test case
        btnC = 1;
        #1_000_000;
        btnC = 0;
        #10_000_000;

        // Test case 3: Brent-Kung with inputs (7, 2)
        btnU = 1;  // Choose Brent-Kung
        #1_000_000;
        btnU = 0;

        sw   = 16'b0000000000000111;  // Set first switch to 7
        #1_000_000;

        btnD = 1;  // Choose operand A
        #2_000_000;  // Increased delay
        btnD = 0;

        #10_000_000;  // Wait for processing

        sw = 16'b0000000000000010;  // Set second switch to 2
        #1_000_000;

        btnL = 1;  // Choose operand B
        #2_000_000;  // Increased delay
        btnL = 0;

        btnR = 1;  // Finish input
        #2_000_000;  // Increased delay
        btnR = 0;

        #10_000_000;  // Wait for output

        // Clear display for next test case
        btnC = 1;
        #1_000_000;
        btnC = 0;
        #10_000_000;

        // Test case 4: Brent-Kung with inputs (12, 3)
        btnU = 1;  // Choose Brent-Kung
        #1_000_000;
        btnU = 0;

        sw   = 16'b0000000000001100;  // Set first switch to 12
        #1_000_000;

        btnD = 1;  // Choose operand A
        #2_000_000;  // Increased delay
        btnD = 0;

        #10_000_000;  // Wait for processing

        sw = 16'b0000000000000011;  // Set second switch to 3
        #1_000_000;

        btnL = 1;  // Choose operand B
        #2_000_000;  // Increased delay
        btnL = 0;

        btnR = 1;  // Finish input
        #2_000_000;  // Increased delay
        btnR = 0;

        #10_000_000;  // Wait for output

        // Finish the simulation
        #20_000_000;
        $finish;

    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | seg: %b | an: %b | LED: %b | dp: %b", $time, seg, an, LED, dp);
    end

endmodule
