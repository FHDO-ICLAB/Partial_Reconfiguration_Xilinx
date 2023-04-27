`timescale 1ns / 1ps

//Shift left

module shift_led_left(
    input sys_clk,
    output [15:0] led
    );
  
    integer cnt = 0;
    reg clk = 0;
    reg [15:0] led_r = {15'b0,1'b1};

    always @ (posedge sys_clk) begin
        cnt = cnt+1;
        if (cnt == 5_000_000)
            clk = 1'b1;
        else if (cnt == 10_000_000)
            cnt = 0;
        else
            clk = 1'b0;
    
    end
    
    always @ (posedge clk) begin 
        
        if (led_r[15])
            led_r = {15'b0,1'b1};
        else        
            led_r = led_r << 1;
    end
	
	assign led = led_r;
	
endmodule