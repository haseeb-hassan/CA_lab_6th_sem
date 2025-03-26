module Fifo #(
    parameter DEPTH = 8,       // Number of entries in FIFO
    parameter WIDTH = 9        // Data width (8 bits for UART)
)(
    input  logic clk,
    input  logic rst,
    input  logic en,
    input  logic read_en,
    input  logic overrun_err, 
    input  logic [7:0] data_in,
    output logic [WIDTH-1:0] data_out,
    output logic full
    
);
    logic empty;
    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [$clog2(DEPTH):0] wr_ptr, rd_ptr;  
    logic [WIDTH-1:0] data_in_errs;
    assign data_in_errs = {overrun_err, data_in[7:0]};
    

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            for (int i = 0; i < DEPTH; i++) mem[i] <= 0;
        end 
        else begin
            if (en && !full) begin
                
                mem[wr_ptr[$clog2(DEPTH)-1:0]] <= data_in_errs;
                wr_ptr <= wr_ptr + 1;
            end
            if (read_en && !empty) begin
                data_out <= mem[rd_ptr[$clog2(DEPTH)-1:0]];
                rd_ptr <= rd_ptr + 1;
            end
        end
    end
    always_comb begin
        if (wr_ptr == rd_ptr + DEPTH) begin
            full = 1'b1;
        end
        else begin
            full = 1'b0;

        end
        if (wr_ptr == rd_ptr) begin
            empty = 1'b1;
        end
        else begin
            empty = 1'b0;
        end
    end
   
endmodule