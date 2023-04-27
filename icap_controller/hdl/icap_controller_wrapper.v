//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
//Date        : Sat Mar 18 10:07:58 2023
//Host        : DESKTOP-BFDSFP2 running 64-bit major release  (build 9200)
//Command     : generate_target icap_controller_wrapper.bd
//Design      : icap_controller_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module icap_controller_wrapper
   (rstn,
    sysclk,
    uart_rxd_out,
    uart_txd_in);
  input rstn;
  input sysclk;
  output uart_rxd_out;
  input uart_txd_in;

  wire rstn;
  wire sysclk;
  wire uart_rxd_out;
  wire uart_txd_in;

  icap_controller icap_controller_i
       (.rstn(rstn),
        .sysclk(sysclk),
        .uart_rxd_out(uart_rxd_out),
        .uart_txd_in(uart_txd_in));
endmodule
