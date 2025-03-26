module ir_buffer1
(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] inst,// Input from the main IR
    output logic [31:0] irbuffer1_out// Output to Decode stage
);
    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            irbuffer1_out <= 32'h13;
        else
            irbuffer1_out <= inst;// Pass IR to Decode stage
    end
endmodule