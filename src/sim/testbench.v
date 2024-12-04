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
        .reset(reset),
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
        btnU  = 0;
        btnL  = 0;
        btnR  = 0;
        btnD  = 0;
        btnC  = 0;
        reset = 1;

        // Wait for some time
        #10;

        // Release reset
        reset = 0;
        #10;

        // test ones
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;

        // test tens
        btnL = 1;
        #1_000_000;
        btnL = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;

        // test hundreds
        #1_000_000;
        btnL = 1;
        #1_000_000;
        btnL = 0;
        #1_000_000;

        // Test UP Button
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;

        // test DOWN Button
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000;
        btnD = 1;
        #1_000_000;
        btnD = 0;
        #1_000_000_000;

        // Finish simulation
        $stop;
    end

endmodule
