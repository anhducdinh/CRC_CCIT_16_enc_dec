`timescale 1ns / 1ps  // Set the timescale for simulation

module tb_crc_decoder_16bit;

    // Inputs and outputs
    reg [15:0] data_in;
    reg [15:0] crc_in;
    wire valid;

    // Clock and reset signals
    reg clk;
    reg rst_n;

    // Instantiate the CRC decoder module
    crc_decoder_16bit dut (
        .data_in(data_in),
        .crc_in(crc_in),
        .valid(valid)
    );

    // Clock generation
    always #5 clk = ~clk;  // Generate a clock with a period of 10ns

    // Reset generation
    initial begin
        rst_n = 0;   // Assert reset
        #50;         // Hold reset for 20ns
        rst_n = 1;   // De-assert reset
    end

    // Test data and CRC values
    initial begin
        data_in = 16'hABCD;   // Set input data
        crc_in = 16'hFFFF;    // Set CRC value

        // Wait for valid output
        @(posedge clk)
        repeat(20) begin
            if (valid)    // valid ==1??
                $display("CRC is valid");              //check test right
            else
                $display("CRC is invalid");               // check test fail
            #10;                                      // Wait for 10ns
        end

        $finish;                                     // End simulation
    end 

endmodule