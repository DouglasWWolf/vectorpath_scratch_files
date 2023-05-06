//-----------------------------------------------------------------------------------------------------
// project_top - top level module
//-----------------------------------------------------------------------------------------------------
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

    //-----------------------------------------------------------------------------------------------------
    // This block holds resetn low for a few cycles, then drives it high
    //-----------------------------------------------------------------------------------------------------
    logic resetn = 0;
    logic reset_counter[4] = 4'b1111;
    //-----------------------------------------------------------------------------------------------------
    always @(posedge i_clk) begin
        if (reset_counter)
            reset_counter <= reset_counter - 1;
        else
            resetn <= 1;
    end
    //-----------------------------------------------------------------------------------------------------


    // Turn on the output-enables for each LED
    assign led_l_oe = 8'hff; 

    // Turn on the output-enable for the pin that drives the LED level-shifter
    assign led_oe_l_oe = 1'b1;   
    
    // That level shifter is active-low.  Active = "drives current to the LEDs"
    assign led_oe_l = 1'b0;

    // A lightshow object does all the work of driving the LEDs
    lightshow lightshow0
    (
        .clk(i_clk),
        .resetn(resetn),
        .led(led_l)
    );

endmodule
