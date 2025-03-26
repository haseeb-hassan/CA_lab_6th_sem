module ir_buffer2
(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] irbuffer1_out,
    input  logic  [4:0] rd_in,
    output logic [31:0] irbuffer2_out,
    output logic  [4:0] rd_out
);
    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            irbuffer2_out <= 32'b0;
        else
            irbuffer2_out <= irbuffer1_out;
            rd_out <= rd_in;
    end
endmodule