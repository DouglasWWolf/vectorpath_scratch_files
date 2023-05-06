// ------------------------------------------------------------------
//
// Copyright (c) 2022 Achronix Semiconductor Corp.
// All Rights Reserved.
//
// This Software constitutes an unpublished work and contains
// valuable proprietary information and trade secrets belonging
// to Achronix Semiconductor Corp.
//
// Permission is hereby granted to use this Software including
// without limitation the right to copy, modify, merge or distribute
// copies of the software subject to the following condition:
//
// The above copyright notice and this permission notice shall
// be included in in all copies of the Software.
//
// The Software is provided “as is” without warranty of any kind
// expressed or implied, including  but not limited to the warranties
// of merchantability fitness for a particular purpose and non-infringement.
// In no event shall the copyright holder be liable for any claim,
// damages, or other liability for any damages or other liability,
// whether an action of contract, tort or otherwise, arising from, 
// out of, or in connection with the Software
//
// ------------------------------------------------------------------
//Counter used for flashing_led_vp_demo_top design
//    Has 2 parameters: BIT_WIDTH to specify bit width of counter output value and MAX_VALUE to specify maximum value
//    Will make design increment count value at a slow enough rate so that users can see LED patterns change slowly enough
// ------------------------------------------------------------------


module counter_maxparam(i_clk, i_rst_n, i_en, o_count_output);

    parameter BIT_WIDTH = 4;    //width of counter output
    parameter MAX_VALUE = 12;    //maximum value explicit declaration

    input wire i_clk, i_rst_n, i_en;
    output reg [BIT_WIDTH - 1:0] o_count_output;    //declaring counter output

    always @ (posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n)    //active low reset
            o_count_output <= 0;
        else 
            if(i_en == 0)    //do not increment if en is low 
                o_count_output <= o_count_output;
            else
                if (o_count_output == MAX_VALUE)    //rollover the counter if maximum value is reached
                    o_count_output <= 0;
                else
                    o_count_output <= o_count_output + 1;    //increment counter if en is high and output is less than maximum value
    end    //always @ (posedge clk or negedge rst_n)

endmodule

 
