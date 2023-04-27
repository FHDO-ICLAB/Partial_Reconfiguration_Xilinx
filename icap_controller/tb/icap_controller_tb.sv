`timescale 1ns / 1ps

//`include "message_frame_gen.sv"
//import message_frame_gen::*;

module icap_controller_tb;
  logic clk, read, write;
  reg [31:0] in;
  reg rstn;
  wire [31:0] out;
  logic uart_tx;
  int test;
  
  bridge_wrapper dut (
    .sysclk(clk),
    .rstn(rstn),
    .uart_txd_in(uart_tx),
    .uart_rxd_out()
  );

  task automatic generate_uart_bitstream(
    input byte data[$]
    );
    
    // Baud rate and Baud time ticks
    parameter real BAUD_RATE = 115200;
    parameter real BAUD_TICKS = $ceil((1 / BAUD_RATE)*1e9);  
    for (int i = 0; i < data.size(); i++) begin
//    foreach (data[i][j]) begin
        $display("frame = %h", data[i]);
        // Start bit
        uart_tx = 0; 
        #BAUD_TICKS;
        for (int j = 0; j < 8; j++ ) begin
            // Data bit
            uart_tx = data[i][j];
            #BAUD_TICKS;
        end
        // Stop bit
        uart_tx = 1;
        #BAUD_TICKS;
    end
  endtask
  
task assemble_message(
  input byte addr,
  input byte data[$]
  );
    parameter byte flag = 8'h7E;
     // Calculate data length
    automatic byte data_len = data.size();
    // Concatenate data to form frame
    automatic byte frame[$] = {flag, addr, data_len, data, flag};
    generate_uart_bitstream(frame);
endtask

// 11.52MHz
real clk_freq = 100e6;
real clk_period = (1/clk_freq)*1e9;

initial forever #(clk_period/2.0) clk = ~clk;

initial begin
    clk = 0;
    read = 0;
    write = 0;
    in = 0;
    #10;
    $display("Starting testbench...");
    rstn = 0;
    #10;
    rstn = 1;
//    assemble_message(.addr(8'h00), .data({8'h01, 8'h7E, 8'h02, 8'h7E, 8'h7E}));
//    assemble_message(.addr(8'h00), .data({8'hBB, 8'hCC, 8'hDD}));
    assemble_message(.addr(8'h00), .data({8'hAA, 8'h99, 8'h55, 8'h66}));
    assemble_message(.addr(8'h01), .data({8'h01}));
    assemble_message(.addr(8'h00), .data({8'hff})); 
    //assemble_message(.addr(8'h01), .data({8'h04}));
    //assemble_message(.addr(8'h00), .data({8'h01, 8'h7E, 8'h02, 8'h7E, 8'h7E}));
    #1000;

    $display("Finished testbench.");
    $finish();
 end
 
endmodule

