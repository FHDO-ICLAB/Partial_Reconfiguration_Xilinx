module fifo_module (
    input wire clk,
    input wire reset,
    input wire en,
    input wire [7:0] data_in,
    input uart_busy,
    output wire [7:0] data_out,
    output wire output_ready
);

localparam WIDTH = 8; // data width
localparam DEPTH = 8; // depth of the FIFO

reg [WIDTH-1:0] mem [0:DEPTH-1]; // fifo
reg [6:0] wr_ptr; // write pointer
reg [6:0] rd_ptr; // read pointer
reg [5:0] count; // FIFO occupancy count
reg [7:0] data_out_reg;
reg output_ready_reg;

assign empty = (count == 6'h00);
assign full = (count == 6'h40);
assign output_ready = output_ready_reg;

always @(posedge clk) begin
    if (reset) begin
        wr_ptr <= 7'h00;
        rd_ptr <= 7'h00;
        count <= 6'h00;
    end else if (en) begin
        if (full) begin
            // do not write
        end else begin
            output_ready_reg <= 0;
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
            count <= count + 1;
        end
    end else begin
        output_ready_reg <= 0;
        if (empty) begin
            // FIFO is empty, do not read
        end else if (!uart_busy) begin
            data_out_reg <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            count <= count - 1;
            output_ready_reg <= 1;
        end
    end
end

assign data_out = data_out_reg;

endmodule
