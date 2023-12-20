# Partial Reconfiguration (DFX) via ICAP

This Repository contains a Test Design for partially reconfiguring a Xilinx 7-Series FPGA via the ICAP Interface over UART from a PC. For using the DFX functionality of Xilinx FPGAs, it is recommended using Vivado Version greater than 2021.2. 
While this test design is applicable to any Xilinx 7 series FPGA, it was designed to run on the [Digilent Nexys 4 DDR Board](https://digilent.com/reference/programmable-logic/nexys-4-ddr/start) (Xilinx Artix-7 XC7A100T-1CSG324C).

The whole Setup is split up in three parts:
1. The Verilog Design running on the FPGA containing the UART Transceiver and ICAP Controller: [icap_controller](../main/icap_controller)
2. The Python GUI for writing partial Bitstreams: [icap_gui](../main/icap_gui)
   - The necessary Python Packages are listed in [requirements.txt](../main/icap_gui/requirements.txt)
3. The Test Bitstreams suitable for the Nexys 4 DDR: [Bitstreams](../main/Bitstreams)
   - The partial Bitstreams [shift_left](../main/Bitstreams/shift_left)/[shift_right](../main/Bitstreams/shift_right) are supplied in the .bit and .bin format
   - The Bitstream bridge_wrapper_full.bit in [shift_left](../main/Bitstreams/shift_left)/[shift_right](../main/Bitstreams/shift_right) configures the static as well as the reconfigurable portion of the Design
  
Detailed Information about the ICAP Interface as well as the Test Design and setting up DFX can be found in [Chapter 2](https://opus.bsz-bw.de/fhdo/frontdoor/deliver/index/docId/3393/file/Bachelorthesis_Schreiter_Lucas.pdf#chapter.2) and [Appendix A1](https://opus.bsz-bw.de/fhdo/frontdoor/deliver/index/docId/3393/file/Bachelorthesis_Schreiter_Lucas.pdf#section.A.1) 
