`timescale 1ns / 1ps

module tb_top;

    // Testbench signals
    reg CLK100MHZ;
    reg btnU;
    reg btnL;
    reg btnR;
    reg btnD;
    reg btnC;
    reg reset;
    wire [0:6] seg;
    wire [3:0] an;

    // Instantiate the top module
    top uut (
        .CLK100MHZ(CLK100MHZ),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .btnC(btnC),
        .seg(seg),
        .an(an)
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

        // Wait for some time
        #10;

        // Release reset
        reset = 0;
        #10;

        // Test button presses
        btnL = 1;  // Press center button
        #1_000_000;
        btnL = 0;  // Release center button
        #1_000_000_000;

        // Finish simulation
        $stop;
    end

endmodule
