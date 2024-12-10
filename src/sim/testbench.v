`timescale 1ns / 1ps `timescale 1ns / 1ps

module tb_top;

    // Testbench signals
    reg CLK100MHZ;  // Clock signal
    reg btnU, btnL, btnR, btnD, btnC;  // Button inputs
    reg  [15:0] sw;  // Switch inputs
    wire [ 0:6] seg;  // 7-segment display segment pattern
    wire [ 3:0] an;  // 7-segment display anodes
    wire [ 1:0] LED;  // LEDs to specify the current display mode
    wire        dp;  // Display dot point

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
        btnU = 1;
        #1_000_000;  // Wait for a clock cycle
        btnU = 0;

        // Test case 2: Set switch values
        sw   = 16'b1100000000000110;  // Set first switch
        #1_000_000;  // Wait for a clock cycle

        // Test case 3: Choose operand A
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;

        #10_000_000;

        // Test case 5: Set another switch
        sw = 16'b0000001100000010;  // Set second switch
        #1_000_000;

        // Test case 6: choose operand B
        btnL = 1;
        #1_000_000;
        btnL = 0;
        #1_000_000;

        // Test case 7: finish the input
        btnR = 1;
        #1_000_000;
        btnR = 0;
        #1_000_000;

    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | seg: %b | an: %b | LED: %b | dp: %b", $time, seg, an, LED, dp);
    end

endmodule
