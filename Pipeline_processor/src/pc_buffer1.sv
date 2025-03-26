module pc_buffer1
(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] pc_out, // Input from the main PC
    output logic [31:0] pcbuffer1_out // Output to Decode stage
);
    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            pcbuffer1_out <= 32'b0;
        else
            pcbuffer1_out <= pc_out; // Pass PC to Decode stage
    end
endmodule