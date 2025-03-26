module alu_mux_b(
    input logic [31:0] rdata2,
    input logic [31:0] imm,
    input logic sel_B, 
    output logic [31:0] mux_out_b
);
    always_comb
    begin
        case (sel_B)
            1'b0: mux_out_b = rdata2;
            1'b1: mux_out_b = imm;
        endcase
    end
endmodule