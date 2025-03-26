module pc_buffer2
(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] pcbuffer1_out,
    output logic [31:0] pcbuffer2_out
);
    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            pcbuffer2_out <= 32'b0;
        else
            pcbuffer2_out <= pcbuffer1_out;
    end
endmodule