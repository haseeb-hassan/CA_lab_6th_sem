module DataReg (
    input  logic clk,
    input  logic rst,
    input  logic en_D,
    input  logic [8:0] data_in,
    output logic [8:0] data_out
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= 0;
        end else if (en_D) begin
            data_out <= data_in;
        end
    end
endmodule