`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2022 22:49:14
// Design Name: 
// Module Name: decoupling
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoupling(
    input enable,
    input [15:0] led,
    input clk,
    input rstn,
    
    output [15:0] ledd,
    output clkd,
    output rstnd    
    );
    
    reg en;
    
    always @ (posedge clk) begin
        if (enable) begin
            en <= 1;
        end else begin
            en <= 0;
        end
    end
    
    assign ledd = en ? led : 0;
    assign clkd = en ? clk : 0;
    assign rstnd = en ? rstn : 0;
    
endmodule
