module uart_tx_fifo (
    input logic [7:0] fifo_data_in, // 8-bit input data from data register
    input logic clk,                // Clock signal
    input logic rst,                // Reset signal
    input logic write_en,           // Write enable
    input logic read_en,            // Read enable
    output logic [7:0] fifo_data_out, // 8-bit output data
    output logic FIFO_full,         // FIFO full flag
    output logic FIFO_empty         // FIFO empty flag
);
    localparam FIFO_DEPTH = 16;
    logic [7:0] fifo_mem [FIFO_DEPTH-1:0];
    logic [3:0] wr_ptr, rd_ptr, count;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
        end else begin
            if (write_en && !FIFO_full) begin
                fifo_mem[wr_ptr] <= fifo_data_in;
                wr_ptr <= wr_ptr + 1;
                count  <= count + 1;
            end
            if (read_en && !FIFO_empty) begin
                fifo_data_out <= fifo_mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count  <= count - 1;
            end
        end
    end
    assign FIFO_full  = (count == FIFO_DEPTH);
    assign FIFO_empty = (count == 0);
endmodule