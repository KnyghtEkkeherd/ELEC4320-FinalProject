
`timescale 1ns / 1ps

module bcd (
    input         CLK100MHz,
    input         en,
    input  [31:0] bin_d_in,
    output [39:0] bcd_d_out,
    output        conversion_ready
);
    // 72 bits in total: [71 - 32] [31-0]
    //                   digits     input

    //State variables
    parameter IDLE = 3'b000;
    parameter SETUP = 3'b001;
    parameter ADD = 3'b010;
    parameter SHIFT = 3'b011;
    parameter DONE = 3'b100;

    //reg [11:0]  bin_data    = 0;
    reg [71:0] bcd_data = 0;
    reg [ 2:0] state = 0;
    reg        busy = 0;
    reg [ 4:0] sh_counter = 0;
    reg [ 3:0] add_counter = 0;
    reg        result_rdy = 0;


    always @(posedge CLK100MHz) begin
        if (en) begin
            if (~busy) begin
                bcd_data <= {40'b0, bin_d_in};
                state    <= SETUP;
            end
        end

        case (state)

            IDLE: begin
                result_rdy <= 0;
                busy       <= 0;
            end

            SETUP: begin
                busy  <= 1;
                state <= ADD;
            end

            ADD: begin

                case (add_counter)
                    0: begin
                        if (bcd_data[35:32] > 4) begin
                            bcd_data[71:32] <= bcd_data[71:32] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    1: begin
                        if (bcd_data[39:36] > 4) begin
                            bcd_data[71:36] <= bcd_data[71:36] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    2: begin
                        if (bcd_data[43:40] > 4) begin
                            bcd_data[71:40] <= bcd_data[71:40] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    3: begin
                        if (bcd_data[47:44] > 4) begin
                            bcd_data[71:44] <= bcd_data[71:44] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    4: begin
                        if (bcd_data[51:48] > 4) begin
                            bcd_data[71:48] <= bcd_data[71:48] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    5: begin
                        if (bcd_data[55:52] > 4) begin
                            bcd_data[71:52] <= bcd_data[71:52] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    6: begin
                        if (bcd_data[59:56] > 4) begin
                            bcd_data[71:56] <= bcd_data[71:56] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    7: begin
                        if (bcd_data[63:60] > 4) begin
                            bcd_data[71:60] <= bcd_data[71:60] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    8: begin
                        if (bcd_data[67:64] > 4) begin
                            bcd_data[71:64] <= bcd_data[71:64] + 3;
                        end
                        add_counter <= add_counter + 1;
                    end

                    9: begin
                        if (bcd_data[71:68] > 4) begin
                            bcd_data[71:68] <= bcd_data[71:68] + 3;
                        end
                        add_counter <= 0;
                        state <= SHIFT;
                    end
                endcase
            end

            SHIFT: begin
                sh_counter <= sh_counter + 1;
                bcd_data   <= bcd_data << 1;

                if (sh_counter == 31) begin
                    sh_counter <= 0;
                    state      <= DONE;
                end else begin
                    state <= ADD;
                end

            end


            DONE: begin
                result_rdy <= 1;
                state      <= IDLE;
            end
            default: begin
                state <= IDLE;
            end

        endcase

    end
    assign bcd_d_out        = bcd_data[71:32];
    assign conversion_ready = result_rdy;
endmodule
