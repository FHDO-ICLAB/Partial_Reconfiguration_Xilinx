`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.12.2022 02:15:49
// Design Name: 
// Module Name: startupe2_primitve
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


module startupe2_primitve(
    output EOS
    );
    
    
//  STARTUPE2  : In order to incorporate this function into the design,
//   Verilog   : the following instance declaration needs to be placed
//  instance   : in the body of the design code.  The instance name
// declaration : (STARTUPE2_inst) and/or the port declarations within the
//    code     : parenthesis may be changed to properly reference and
//             : connect this function to the design.  All inputs
//             : and outputs must be connected.

//  <-----Cut code below this line---->

   // STARTUPE2: STARTUP Block
   //            Artix-7
   // Xilinx HDL Language Template, version 2021.2

   STARTUPE2 #(
      .PROG_USR("FALSE"),  // Activate program event security feature. Requires encrypted bitstreams.
      .SIM_CCLK_FREQ(0.0)  // Set the Configuration Clock Frequency(ns) for simulation.
   )
   STARTUPE2_inst (
      .CFGCLK(),       // 1-bit output: Configuration main clock output
      .CFGMCLK(),     // 1-bit output: Configuration internal oscillator clock output
      .EOS(EOS),             // 1-bit output: Active high output signal indicating the End Of Startup.
      .PREQ(),           // 1-bit output: PROGRAM request to fabric output
      .CLK(),             // 1-bit input: User start-up clock input
      .GSR(),             // 1-bit input: Global Set/Reset input (GSR cannot be used for the port name)
      .GTS(),             // 1-bit input: Global 3-state input (GTS cannot be used for the port name)
      .KEYCLEARB(), // 1-bit input: Clear AES Decrypter Key input from Battery-Backed RAM (BBRAM)
      .PACK(),           // 1-bit input: PROGRAM acknowledge input
      .USRCCLKO(),   // 1-bit input: User CCLK input
                             // For Zynq-7000 devices, this input must be tied to GND
      .USRCCLKTS(), // 1-bit input: User CCLK 3-state enable input
                             // For Zynq-7000 devices, this input must be tied to VCC
      .USRDONEO(),   // 1-bit input: User DONE pin output control
      .USRDONETS()  // 1-bit input: User DONE 3-state enable output
   );

   // End of STARTUPE2_inst instantiation
				
			
    
    
    
endmodule
