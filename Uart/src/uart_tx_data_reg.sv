module uart_tx_data_reg (
    input logic [7:0] input_data, // 8-bit input data
    input logic clk,              // Clock signal
    input logic rst,              // Reset signal
    input logic FIFO_full,             // FIFO full signal (wait signal)
    output logic [7:0] output_data // 8-bit output data
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            output_data <= 8'b0; // Reset data register to 0
        else if (!FIFO_full) // Only write if FIFO is not full
            output_data <= input_data;
    end
endmodule