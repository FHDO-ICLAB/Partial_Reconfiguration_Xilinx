module decapsulation #(parameter flag_byte = 8'h7E)(
    input clk,
    input rstn,
    input [7:0] data_rx,
    input new_data_rx,
    output [7:0] address,
    output [7:0] data,
    output data_received
    );

    localparam START_OF_FIELD = 3'd0;
    localparam ADDRESS_FIELD = 3'd1;
    localparam DATA_LENGHT_CODE = 3'd2;
    localparam DATA_FIELD = 3'd3;
    localparam END_OF_FIELD = 3'd4;

    reg [2:0] state;
    reg [2:0] next_state;
    reg [7:0] address_reg;
    reg [7:0] data_reg;
    reg [7:0] dlc_reg;
    reg drec;

    always @ (posedge clk or negedge rstn) begin
        if (!rstn) begin
            state <= START_OF_FIELD;
            drec <= 0;
        end else begin
            state <= next_state;
            drec <= 0;
            if (new_data_rx) begin
                case (state)
                    ADDRESS_FIELD: begin
                        address_reg <= data_rx;
                    end
                    DATA_LENGHT_CODE: begin
                        dlc_reg <= data_rx;
                    end
                    DATA_FIELD: begin
                        if (dlc_reg > 0) begin
                            data_reg <= data_rx;
                            dlc_reg <= dlc_reg - 1;
                            drec <= 1;
                        end
                    end
                endcase
            end
        end
    end

    always @ (*) begin
        next_state = state;
        case (state)
            START_OF_FIELD: begin
                if (data_rx == flag_byte && new_data_rx)
                    next_state = ADDRESS_FIELD;
            end
            ADDRESS_FIELD: begin
                if (new_data_rx)
                    next_state = DATA_LENGHT_CODE;
            end
            DATA_LENGHT_CODE: begin
                if (new_data_rx)
                    if (data_rx == 0)
                        next_state = END_OF_FIELD;
                    else
                        next_state = DATA_FIELD;
            end
            DATA_FIELD: begin
                if (dlc_reg > 0) begin
                    next_state = DATA_FIELD;
                end else begin
                    next_state = END_OF_FIELD;
                end
            end
            END_OF_FIELD: begin
                if (data_rx == flag_byte && dlc_reg == 0)
                    next_state = START_OF_FIELD;
            end
        endcase
    end

    assign data_received = drec;
    assign address = address_reg;
    assign data = data_reg;
endmodule
