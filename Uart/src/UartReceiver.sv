module UartReceiver (
    input  logic start,
    input  logic clk,
    input  logic rst,
    input  logic rx,
    output logic [8:0] data_out
);
logic baud_clk;
logic [7:0] shift_reg_out;
logic en;
logic shift_en;
logic read_en;
logic en_D;
logic overrun_err;
logic fifo_full;
logic [8:0] fifo_out;

BaudRateGen Baud_gen(
    .clk(clk),
    .rst(rst),
    .baud_clk(baud_clk)
);
FSM receiver_fsm(
    .clk(baud_clk),
    .rst(rst),
    .start(start),
    .shift_en(shift_en),
    .read_en(read_en),
    .en_D(en_D)
);

ShiftReg shift_reg(
    .clk(baud_clk),
    .rst(rst),
    .shift_en(shift_en),
    .rx(rx),
    .en(en),
    .data_out(shift_reg_out)
);
Fifo receiver_fifo(
    .clk(baud_clk),
    .rst(rst),
    .en(en),
    .read_en(read_en),
    .overrun_err(overrun_err),
    .data_in(shift_reg_out),
    .full(fifo_full),
    .data_out(fifo_out)
);
ErrorHandler error_handler(
    .clk(baud_clk),
    .rst(rst),
    .fifo_full(fifo_full),
    .overrun_error(overrun_err)
);
DataReg data_reg(
    .clk(baud_clk),
    .rst(rst),
    .en_D(en_D),
    .data_in(fifo_out),
    .data_out(data_out)
);
endmodule
