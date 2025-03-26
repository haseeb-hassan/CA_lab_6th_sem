module uart_tx_shift_reg (
    input logic clk,            // Clock signal
    input logic rst,            // Reset signal
    input logic baud_clk_16,    // Baud clock signal
    input logic [7:0] data_in,  // Input data from FIFO
    input logic load,           // Load signal
    output logic data_out,      // Serial data output
    output logic Done           // Transmission complete signal
);
    logic [7:0] shift_reg;
    logic [3:0] bit_count;

    always_ff @(posedge baud_clk_16 or posedge rst) begin
        if (rst) begin
            shift_reg <= 8'b0;
            bit_count <= 4'b0;
            data_out <= 1'b1; // Idle state
        end else if (load) begin
            shift_reg <= data_in;
            bit_count <= 4'b0;
        end else if (bit_count < 8) begin
            data_out <= shift_reg[0];
            shift_reg <= shift_reg >> 1;
            bit_count <= bit_count + 1;
        end else begin
            Done <= 1'b1;
        end
    end
endmodule