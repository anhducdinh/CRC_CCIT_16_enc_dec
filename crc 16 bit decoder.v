module crc16_decoder (
  input clk,
  input reset,
  input [15:0] data_in,
  input valid_in,
  input [15:0] crc_in,
  output reg [15:0] crc_out,
  output reg valid_out
);

reg [15:0] crc;
reg [15:0] polynomial = 16'h8005;

always @(posedge clk or negedge reset) begin
  if (!reset) begin
    crc <= 16'h0000;
    crc_out <= 16'h0000;
    valid_out <= 1'b0;
  end else if (valid_in) begin
    crc <= crc_in;
    for (int i = 0; i < 16; i = i + 1) begin
      if (crc[15] == 1) begin
        crc = {crc[14:0], 1'b0} ^ polynomial;
      end else begin
        crc = {crc[14:0], 1'b0};
      end
    end
    crc_out <= crc;
    valid_out <= 1'b1;
  end
end

endmodule

//cach viet thu 2
module crc_decoder_16bit (
    input wire [15:0] data_in,   // Input data to be decoded
    input wire [15:0] crc_in,    // Input CRC value to be checked
    output wire valid            // Output indicating if the CRC is valid
);

    wire [15:0] crc;             // CRC value calculated during decoding

    // CRC-16 generator polynomial: x^16 + x^12 + x^5 + 1
    // Binary representation: 10001000000100001
    // Bit order: MSB first

    always_ff @(posedge clk or posedge rst_n) begin
        if (!rst_n)
            crc <= 16'b0;       // Reset the CRC value
        else begin
            crc[15] <= crc_in[15] ^ data_in[15];
            crc[14] <= crc[15] ^ crc_in[14] ^ data_in[14];
            crc[13] <= crc[14] ^ crc_in[13] ^ data_in[13];
            crc[12] <= crc_in[12] ^ data_in[12];
            crc[11] <= crc[12] ^ crc_in[11] ^ data_in[11];
            crc[10] <= crc[11] ^ crc_in[10] ^ data_in[10];
            crc[9]  <= crc[10] ^ crc_in[9]  ^ data_in[9];
            crc[8]  <= crc_in[8]  ^ data_in[8];
            crc[7]  <= crc[8]  ^ crc_in[7]  ^ data_in[7];
            crc[6]  <= crc[7]  ^ crc_in[6]  ^ data_in[6];
            crc[5]  <= crc[6]  ^ crc_in[5]  ^ data_in[5];
            crc[4]  <= crc[5]  ^ crc_in[4]  ^ data_in[4];
            crc[3]  <= crc[4]  ^ crc_in[3]  ^ data_in[3];
            crc[2]  <= crc[3]  ^ crc_in[2]  ^ data_in[2];
            crc[1]  <= crc[2]  ^ crc_in[1]  ^ data_in[1];
            crc[0]  <= crc[1]  ^ crc_in[0]  ^ data_in[0];
        end
    end

    assign valid = (crc == 16'b0);    // Output is valid when CRC is 0

endmodule