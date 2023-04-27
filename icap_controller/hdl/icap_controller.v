//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
//Date        : Sat Mar 18 10:07:58 2023
//Host        : DESKTOP-BFDSFP2 running 64-bit major release  (build 9200)
//Command     : generate_target icap_controller.bd
//Design      : icap_controller
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bridge_imp_I0M37J
   (clk,
    rstn,
    uart_rxd_out,
    uart_txd_in);
  input clk;
  input rstn;
  output uart_rxd_out;
  input uart_txd_in;

  wire clk_1;
  wire rstn_1;
  wire uart_interface_0_uart_rxd_out;
  wire uart_txd_in_1;

  assign clk_1 = clk;
  assign rstn_1 = rstn;
  assign uart_rxd_out = uart_interface_0_uart_rxd_out;
  assign uart_txd_in_1 = uart_txd_in;
  icap_controller_uart_interface_0_0 uart_interface_0
       (.clk(clk_1),
        .data_tx({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .new_data_tx(1'b0),
        .rstn(rstn_1),
        .uart_rxd_out(uart_interface_0_uart_rxd_out),
        .uart_txd_in(uart_txd_in_1));
endmodule

(* CORE_GENERATION_INFO = "icap_controller,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=icap_controller,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=1,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "icap_controller.hwdef" *) 
module icap_controller
   (rstn,
    sysclk,
    uart_rxd_out,
    uart_txd_in);
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RSTN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RSTN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rstn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYSCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYSCLK, CLK_DOMAIN icap_controller_sysclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input sysclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.UART_RXD_OUT DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.UART_RXD_OUT, LAYERED_METADATA undef" *) output uart_rxd_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.UART_TXD_IN DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.UART_TXD_IN, LAYERED_METADATA undef" *) input uart_txd_in;

  wire bridge_uart_rxd_out;
  wire clk_wiz_0_clk;
  wire rstn_1;
  wire sysclk_1;
  wire uart_txd_in_1;

  assign rstn_1 = rstn;
  assign sysclk_1 = sysclk;
  assign uart_rxd_out = bridge_uart_rxd_out;
  assign uart_txd_in_1 = uart_txd_in;
  bridge_imp_I0M37J bridge
       (.clk(clk_wiz_0_clk),
        .rstn(rstn_1),
        .uart_rxd_out(bridge_uart_rxd_out),
        .uart_txd_in(uart_txd_in_1));
  icap_controller_clk_wiz_0_0 clk_wiz_0
       (.clk(clk_wiz_0_clk),
        .clk_in1(sysclk_1));
endmodule
