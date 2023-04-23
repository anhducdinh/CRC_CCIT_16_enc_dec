module crc_encoder(
    input logic [15:0] data_in,
    output logic [31:0] crc_out
);

    logic [15:0] crc_reg;
    logic [15:0] polynomial = 16'h8005; // Đa thức CRC-16 (0x8005)

    always_ff @(posedge clk) begin
        // Đẩy dữ liệu vào thanh ghi CRC
        crc_reg <= data_in ^ crc_reg;
        
        // Thực hiện phép xoáy tròn bit
        for (int i = 0; i < 16; i++) begin
            if (crc_reg[0]) begin
                crc_reg = {crc_reg[14:0], 1'b0} ^ polynomial;
            end else begin
                crc_reg = {crc_reg[14:0], 1'b0};
            end
        end
    end

    assign crc_out = crc_reg;

endmodule