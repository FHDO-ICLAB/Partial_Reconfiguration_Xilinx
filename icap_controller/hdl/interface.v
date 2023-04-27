module interface #(parameter BUS_WIDTH = 8)(
  // Interface
  input clk, // System clk
  input rstn, // Reset low
  input wready,
  input [7:0] address, // Address
  input [BUS_WIDTH-1:0] wrdata, // Write data
  
  // ICAP
  input icap_busy,
  output write_req,
  output read_req,
  output [BUS_WIDTH-1:0] icap_wrdata
  );

// 0x0 data register
reg [BUS_WIDTH-1:0] data_register;

reg write_request;
reg read_request;

always @ (posedge clk, negedge rstn) begin
    if (!rstn) begin
        data_register <= 0;
        write_request <= 0;
        read_request <= 0;
    end else begin
        read_request <= 0;
        write_request <= 0;
        if (wready & !icap_busy) begin
            case (address)
                8'h00: begin
                        write_request <= 1;
                        data_register <= wrdata;
                end
                8'h01: begin
                    if (wrdata != 0)
                        read_request <= 1;
                        data_register <= {BUS_WIDTH{1'b1}}; 
                end
            endcase
        end              
    end
end

assign read_req = read_request;
assign write_req = write_request;
assign icap_wrdata = data_register;

endmodule
