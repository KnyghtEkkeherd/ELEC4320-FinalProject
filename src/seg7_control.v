`timescale 1ns / 1ps

`timescale 1ns / 1ps
    
module seg7_control(
    input clock,
    input reset,
    input [3:0] ones,       // Input for ones digit
    input [3:0] tens,       // Input for tens digit
    input [3:0] hundreds,   // Input for hundreds digit
    input [3:0] thousands,   // Input for thousands digit
    output reg [3:0] anode_activation,
    output reg [6:0] LED_segment // corresponds to one of the 7-segments of the display
);

    reg [19:0] refresh_counter;
    wire [1:0] LED_activating_counter;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            refresh_counter <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
        end
    end 

    assign LED_activating_counter = refresh_counter[19:18];

    always @(*) begin
        case(LED_activating_counter)
        2'b00: begin
            anode_activation = 4'b0111; 
            LED_segment = decode_segment(thousands); // Display thousands
        end
        2'b01: begin
            anode_activation = 4'b1011; 
            LED_segment = decode_segment(hundreds); // Display hundreds
        end
        2'b10: begin
            anode_activation = 4'b1101; 
            LED_segment = decode_segment(tens); // Display tens
        end
        2'b11: begin
            anode_activation = 4'b1110; 
            LED_segment = decode_segment(ones); // Display ones
        end
        endcase
    end

    function [6:0] decode_segment(input [3:0] value);
        begin
            case(value)
            4'b0000: decode_segment = 7'b0000001; // "0"     
            4'b0001: decode_segment = 7'b1001111; // "1" 
            4'b0010: decode_segment = 7'b0010010; // "2" 
            4'b0011: decode_segment = 7'b0000110; // "3" 
            4'b0100: decode_segment = 7'b1001100; // "4" 
            4'b0101: decode_segment = 7'b0100100; // "5" 
            4'b0110: decode_segment = 7'b0100000; // "6" 
            4'b0111: decode_segment = 7'b0001111; // "7" 
            4'b1000: decode_segment = 7'b0000000; // "8"     
            4'b1001: decode_segment = 7'b0000100; // "9" 
            4'b1010: decode_segment = 7'b1111110; // "-" 
            default: decode_segment = 7'b0000001; // "0"
            endcase
        end
    endfunction

endmodule