module uart_tx_top (
    input logic clk, rst,             // Clock and reset
    input logic [7:0] input_data,      // Input data
    input logic [15:0] baud_div,       // Baud rate divisor
    input logic write_en, read_en,     // FIFO control signals
    output logic data_out, Done        // Serial data output and Done flag
);
    logic [7:0] data_reg_out;
    logic [7:0] fifo_out;
    logic FIFO_full, FIFO_empty;
    logic baud_clk_16;

    uart_baud_gen baud_gen (.clk(clk), .rst(rst), .baud_div(baud_div), .baud_clk_16(baud_clk_16));
    uart_tx_data_reg data_reg (.input_data(input_data), .clk(clk), .rst(rst), .TxFF(FIFO_full), .output_data(data_reg_out));
    uart_tx_fifo fifo (.fifo_data_in(data_reg_out), .clk(clk), .rst(rst), .write_en(write_en), .read_en(read_en), .fifo_data_out(fifo_out), .FIFO_full(FIFO_full), .FIFO_empty(FIFO_empty));
    uart_tx_shift_reg shift_reg (.clk(clk), .rst(rst), .baud_clk_16(baud_clk_16), .data_in(fifo_out), .load(!FIFO_empty), .data_out(data_out), .Done(Done));
endmodule
 