`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2021 21:15:52
// Design Name: 
// Module Name: uart_interface
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


module uart_interface(
    input clk,
    input rstn,
    input uart_txd_in,
    input new_data_tx, //Ready for transmission
    input [7:0] data_tx, //Data for transmission

    output uart_rxd_out,
    output busy,
    output new_data_rx, //Data received
    output [7:0] data_rx //Received data 
);
    //8 data bits, 1 stop bit, no parity, 115200 baud, sampling @ 100 clk cycles
    parameter clk_per_bit = 100;
    parameter ctr_size = 7; //8 bit data size
    
    wire rst;
    
    assign rst = !rstn; 

    // Receive serial data
    serial_rx #(.CLK_PER_BIT(clk_per_bit), .CTR_SIZE(ctr_size)) serial_rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(uart_txd_in),
        .new_data(new_data_rx), //Data received
        .data(data_rx) //Received data
    );

    // Transmit serial data
    serial_tx #(.CLK_PER_BIT(clk_per_bit), .CTR_SIZE(ctr_size)) serial_tx_inst (
        .clk(clk),
        .rst(rst),
        .tx(uart_rxd_out),
        .tx_block(0), //Unused
        .busy(busy),
        .new_data(new_data_tx), //Ready for transmission
        .data(data_tx) //Data for transmission
    );
    



endmodule
