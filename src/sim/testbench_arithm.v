`timescale 1ns / 1ps

module top_tb;

    // Inputs
    reg CLK100MHZ;
    reg btnU;
    reg btnL;
    reg btnR;
    reg btnD;
    reg btnC;
    reg [15:0] sw;

    // Outputs
    wire [6:0] seg;
    wire [3:0] an;
    wire [1:0] LED;

    // Instantiate the Unit Under Test (UUT)
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
        .LED(LED)
    );

    // Clock generation
    initial begin
        CLK100MHZ = 0;
        forever #5 CLK100MHZ = ~CLK100MHZ;  // 100MHz clock
    end

    // Stimulus process
    initial begin
        // Initialize Inputs
        btnU = 0;
        btnL = 0;
        btnR = 0;
        btnD = 0;
        btnC = 0;
        sw   = 0;

        // Wait for global reset
        #100;

        // Add stimulus here
        sw[0] = 1;  // Reset
        #10;
        sw[0] = 0;  // Release reset
        #10;

        // Simulate button presses and switch toggles

        // input number 999 for A
        repeat (3) begin
            repeat (9) begin
                btnU = 1;
                #1_000_000;
                btnU = 0;
                #1_000_000;
            end

            btnL = 1;
            #1_000_000;
            btnL = 0;
            #1_000_000;
        end

        btnC = 1;
        #1_000_000;
        btnC = 0;
        #1_000_000;

        // Input number 999 for B
        repeat (3) begin
            repeat (9) begin
                btnU = 1;
                #1_000_000;
                btnU = 0;
                #1_000_000;
            end

            btnL = 1;
            #1_000_000;
            btnL = 0;
            #1_000_000;
        end

        btnC = 1;
        #1_000_000;
        btnC = 0;
        #1_000_000;

        // Choose operation: addition: switch[15]
        sw[15:5] = 11'b10000000000;
        #1_000_000;

        btnC = 1;
        #1_000_000;
        btnC = 0;
        #1_000_000;

        // test adding after clear
        // input number 555 for A
        repeat (3) begin
            repeat (5) begin
                btnU = 1;
                #1_000_000;
                btnU = 0;
                #1_000_000;
            end

            btnL = 1;
            #1_000_000;
            btnL = 0;
            #1_000_000;
        end

        btnC = 1;
        #1_000_000;
        btnC = 0;
        #1_000_000;

        // Input number 555 for B
        repeat (3) begin
            repeat (5) begin
                btnU = 1;
                #1_000_000;
                btnU = 0;
                #1_000_000;
            end

            btnL = 1;
            #1_000_000;
            btnL = 0;
            #1_000_000;
        end

        btnC = 1;
        #1_000_000;
        btnC = 0;
        #1_000_000;

        // Choose operation: big number display
        sw[15:5] = 11'b00100000000;
        #10_000_000;

        //test display advancing
        btnU = 1;
        #1_000_000;
        btnU = 0;
        #1_000_000;

        btnU = 1;
        #1_000_000;
        btnU = 0;

        #1_000_000_000;

        // Continue adding more stimulus as needed
    end

endmodule
