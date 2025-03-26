`timescale 1ns/1ps

module uart_tx_tb;
    // Testbench Signals
    logic clk, rst;
    logic [7:0] input_data;
    logic write_en, read_en;
    logic data_out, Done;

    // Clock Generation
    always #5 clk = ~clk; // 10ns period (100MHz)

    // DUT Instantiation
    uart_tx_top dut (
        .clk(clk),
        .rst(rst),
        .input_data(input_data),
        .write_en(write_en),
        .read_en(read_en),
        .data_out(data_out),
        .Done(Done)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        input_data = 8'h00;
        write_en = 0;
        read_en = 0;
        
        #20 rst = 0; // Release reset
        
        // Send test data
        input_data = 8'hA5; // Example data
        write_en = 1;
        #10 write_en = 0;
        
        #50 read_en = 1; // Read from FIFO
        #10 read_en = 0;
        
        // Wait for transmission to complete
        wait (Done);
        
        #50 $stop;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | Data=%h | Write=%b | Read=%b | Out=%b | Done=%b", $time, input_data, write_en, read_en, data_out, Done);
    end
endmodule
