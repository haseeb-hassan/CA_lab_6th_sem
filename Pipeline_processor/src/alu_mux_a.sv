module alu_mux_a(
    input logic [31:0] rdata1,
    input logic [31:0] pc_out,
    input logic sel_A, 
    output logic [31:0] mux_out_a 
);
    always_comb
    begin
        case (sel_A)
            1'b0: mux_out_a = pc_out;
            1'b1: mux_out_a = rdata1;
        endcase
    end
endmodule