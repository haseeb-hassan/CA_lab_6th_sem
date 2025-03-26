module Uart (
    input logic clk,
    input logic rst,
    input logic [15:0] baud_div,
    input logic write_en, read_en,
    input logic start,
    input logic [7:0] data_in,
    output logic [8:0] data_out
);
logic trans_bit;

uart_tx_top transmitter (
    .clk(clk),
    .rst(rst),
    .baud_div(baud_div),
    .write_en(write_en),
    .read_en(read_en),
    .input_data(data_in),
    .data_out(trans_bit)

);
UartReceiver receiver(
    .clk(clk),
    .rst(rst),
    .start(start),
    .rx(trans_bit),
    .data_out(data_out)
);
endmodule
