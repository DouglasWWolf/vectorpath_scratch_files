// ------------------------------------------------------------------
//High level wrapper module of flashin_led_vp_demo 
//    outputs a flashing LED pattern to show customers a sanity check of the VectorPath card being functional
//    
// ------------------------------------------------------------------


module project_top
( 
    input wire i_clk,

    input wire i_reg_clk,
    input wire i_eth_ts_clk,
    input wire pll_ddr_lock,
    input wire pll_eth_sys_ne_0_lock,
    input wire pll_gddr_SE_lock,
    input wire pll_gddr_SW_lock,
    input wire pll_noc_ne_1_lock,
    input wire pll_pcie_lock,

    `include "vectorpath_rev1_port_list.svh"
);

    // logic clk;
    logic rst_n;
    wire [13:0] counter_signal_14bit;
    logic en_13bitcounter, en_4bitcounter;
    wire [12:0] counter_signal_13bit;
    wire [3:0] counter_signal_4bit;
    logic [7:0] decoder4b_8b, led_output;

    assign rst_n = 1'b1;   //sets active low reset high 
    assign led_l_oe = 8'hff;  //output enable signals
    assign led_oe_l = 1'b0;
    assign led_oe_l_oe =  1'b1;   

    counter i_counter_14b(.i_clk(i_clk), .i_rst_n(rst_n), .i_en(1'b1), .o_count_output(counter_signal_14bit));    //14-bit counter

    always_comb begin    //enable 13-bit counter when 14-bit counter reaches its maximum value   
        if (counter_signal_14bit == 14'b11111111111111)
            en_13bitcounter = 1'b1;
        else
            en_13bitcounter = 1'b0;
    end

    counter #(.BIT_WIDTH(13)) i_counter_13b(.i_clk(i_clk), .i_rst_n(rst_n), .i_en(en_13bitcounter), .o_count_output(counter_signal_13bit));    //13-bit counter
    
    always_comb begin    //enable 4-bit counter when 13-bit counter reaches its maximum value   
        if ((counter_signal_13bit == 13'b1111111111111) && (counter_signal_14bit == 14'b11111111111111))
            en_4bitcounter = 1'b1;
        else
            en_4bitcounter = 1'b0;
    end

    counter_maxparam #(.BIT_WIDTH(4)) i_counter_4b(.i_clk(i_clk), .i_rst_n(rst_n), .i_en(en_4bitcounter), .o_count_output(counter_signal_4bit));    //4-bit counter max value 12

    always_comb begin    //decode 4-bit counter output to 8-bit output then invert to LED active-low output
        case(counter_signal_4bit)
            4'b0000: decoder4b_8b = 8'b00000000;    //no LEDs illuminate             
            4'b0001: decoder4b_8b = 8'b00000001;    //D3 turns orange
            4'b0010: decoder4b_8b = 8'b00000011;    //D3 and D4 turn orange             
            4'b0011: decoder4b_8b = 8'b00000111;    //D3, D4, and D5 turn orange
            4'b0100: decoder4b_8b = 8'b00001111;    //D3, D4, D5, and D6 turn orange             
            4'b0101: decoder4b_8b = 8'b00010000;    //D3 turns green
            4'b0110: decoder4b_8b = 8'b00110000;    //D3 and D4 turn green           
            4'b0111: decoder4b_8b = 8'b01110000;    //D3, D4, and D5 turn green
            4'b1000: decoder4b_8b = 8'b11110000;    //D3, D4, D5, and D6 turn green            
            4'b1001: decoder4b_8b = 8'b00010001;    //D3 turns yellow
            4'b1010: decoder4b_8b = 8'b00110011;    //D3 and D4 turn yellow             
            4'b1011: decoder4b_8b = 8'b01110111;    //D3, D4, and D5 turn yellow
            4'b1100: decoder4b_8b = 8'b11111111;    //D3, D4, D5, and D6 turn yellow             
            default: decoder4b_8b = 8'b00000000;    //if 4-bit counter is anything else, do not activate any LEDs
        endcase
        led_output = ~decoder4b_8b;    //invert all bits because the LEDs are active-low outputs              
    end // end always_comb for decode and invert block   

    assign led_l = led_output;
      

endmodule
