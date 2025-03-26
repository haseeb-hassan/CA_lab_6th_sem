module wd_buffer
(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] fwd_mux_out, // from forwarding mux
    output logic [31:0] wdbuffer_out // to memory stage
);
    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            wdbuffer_out <= 32'b0;        
        else
            wdbuffer_out <= fwd_mux_out;
    end
endmodule