module icap_sm #(parameter BUS_WIDTH = 8)(
  input clk, // system clock
//  input ila_clk,
  input rstn,
  input write_req, // Select reading wr
  input read_req,
  input [BUS_WIDTH-1:0] icap_in, // configuration data input bus
  output data_ready,
  output busy,
  output [BUS_WIDTH-1:0] icap_out // configuration data output bus
);
    reg rdwrb;
    reg csib;
    wire [31:0] o;
    wire [31:0] i = icap_in;
    reg [1:0] cnt;
    reg dready;
    reg CFGERR_B;
    reg DALIGN;
    reg RIP;
    reg IN_ABORT_B;
    reg readback;
    
    assign data_ready = dready;
    assign busy = readback;
    assign icap_out = o;
    always @ (*) begin
        if (o[31:8] & o[1:0]) begin
            CFGERR_B = o[7];
            DALIGN = o[6];
            RIP = o[5];
            IN_ABORT_B = o[4];
            readback = 0;
        end else begin
            readback = 1;
        end
    end

    always @ (posedge clk) begin
        if (!rstn) begin
            cnt <= 0;
        end
        if (busy) begin
            if (cnt == 1) begin
                dready <= 1; 
            end else begin
                cnt <= cnt + 1;
            end
        end else begin
            cnt <= 0;
            dready <= 0;
        end
    end
    
    always @ (negedge clk) begin
        if (write_req) begin
            csib <= 0;
            rdwrb <= 0;
        end else if (read_req) begin
            csib <= 0;
            rdwrb <= 1;
        end else begin
            csib <= 1;
            rdwrb <= rdwrb;
        end
    end		



// Clock gating
//wire gated_clk;
//reg enable_reg;
//always @(posedge  clk)
//    enable_reg <= enable;
//assign gated_clk = clk & enable_reg;
//reg enable_reg, gated_clk_reg;

//always @(negedge clk)
//    gated_clk_reg <= enable;

//assign gated_clk = ~clk & gated_clk_reg;


//   BUFGCE    : In order to incorporate this function into the design,
//   Verilog   : the following instance declaration needs to be placed
//  instance   : in the body of the design code.  The instance name
// declaration : (BUFGCE_inst) and/or the port declarations within the
//    code     : parenthesis may be changed to properly reference and
//             : connect this function to the design.  All inputs
//             : and outputs must be connected.

//  <-----Cut code below this line---->

   // BUFGCE: Global Clock Buffer with Clock Enable
   //         Artix-7
   // Xilinx HDL Language Template, version 2021.2

//   BUFGCE BUFGCE_inst (
//      .O(gated_clk),   // 1-bit output: Clock output
//      .CE(enable), // 1-bit input: Clock enable input for I0
//      .I(clk)    // 1-bit input: Primary clock
//   );

   // End of BUFGCE_inst instantiation

  // Instantiate the ICAP interface
  ICAPE2 #(
      .DEVICE_ID(32'h03631093), // Specifies the pre-programmed Device ID value to be used for simulation purposes.
      .ICAP_WIDTH("X8"), // Specifies the input and output data width.
      .SIM_CFG_FILE_NAME("None") // Specifies the Raw Bitstream (RBT) file to be parsed by the simulation model. D:/Sciebo/Elektrotechnik/Bachelorarbeit/Vivado/icap_controller/icap_controller.runs/impl_1/bridge_wrapper.rbt
  )
  ICAPE2_inst (
      .O(o), // 32-bit output: Configuration data output bus
      .CLK(clk), // 1-bit input: Clock Input
      .CSIB(csib), // 1-bit input: Active-Low ICAP Enable
      .I(i), // 32-bit input: Configuration data input bus
      .RDWRB(rdwrb) // 1-bit input: Read/Write Select input
  );
    
  ila_0 ila(
    .clk(clk),
    .probe0(csib),
    .probe1(rdwrb),
    .probe2(i),
    .probe3(o),
    .probe4(dready),
    .probe5(readback)
  );

endmodule
