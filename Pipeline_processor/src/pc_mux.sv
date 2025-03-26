module pc_mux
(
    input  logic [31:0] pc_out,        
    input  logic [31:0] opr_res,    
    input  logic [1:0] br_taken,     
    output logic [31:0] pc_in 
);

    always_comb
    begin
        case (br_taken)
            2'b00: pc_in = pc_out + 32'd4;
            2'b01: pc_in = opr_res;
            2'b10: pc_in = (opr_res & ~32'b1); //JALR Alignment
        endcase
    end

endmodule
