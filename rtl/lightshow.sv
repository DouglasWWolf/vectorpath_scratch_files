//=========================================================================================================
// lightshow - Drives a rotating pattern out to the 8 LEDs
//=========================================================================================================
module lightshow
(
    input reg clk, resetn,
    output wire[7:0] led
);

// We're assuming the clock speed is 100 Mhz
localparam CLOCK_HZ = 100000000;

// This counter serves as a countdown timer
logic[31:0] counter;

// The LEDs are active low.   Bits in led_bits are active high
logic[7:0] led_bits;
assign led = ~led_bits;


always @(posedge clk) begin
    
    if (resetn == 0) begin
        counter  <= 0;
        led_bits <= 0;
    
    end else if (counter)
        counter <= counter - 1;
    
    else begin
        counter <= CLOCK_HZ / 5;
        if (led_bits == 0)
            led_bits <= 1;
        else
            led_bits <= led_bits << 1;
    end

end
    

endmodule




