module alu_buffer
(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] opr_res,
    output logic [31:0] alubuffer_out
);
    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            alubuffer_out <= 32'b0;
        else
            alubuffer_out <= opr_res;
    end
endmodule