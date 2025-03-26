module fwd_unit (
    input logic [31:0] irbuffer1_out,
    input logic [31:0] irbuffer2_out,
    output logic fwd_sela,
    output logic fwd_selb   
);

   // Assign the opcode1 fields
    assign opcode1 = irbuffer1_out[6 : 0];

    // Determine if the instruction is which type(R,I,ILOAD,S,LUI,AUIPC)
    assign is_R_type = (opcode1 == 7'b0110011); 
    assign is_I_type = (opcode1 == 7'b0010011); 
    assign is_Iload_type = (opcode1 == 7'b0000011); 
    assign is_S_type = (opcode1 == 7'b0100011); 
    assign is_LUI = (opcode1 == 7'b0110111); 
    assign is_AUIPC = (opcode1 == 7'b0010111); 
    assign is_B_type = (opcode1 == 7'b1100011); 
    assign is_JAL = (opcode1 == 7'b1101111);   
    assign is_JALR = (opcode1 == 7'b1100111);

    assign rs1    = (is_R_type || is_I_type || is_Iload_type || is_B_type || is_JALR || is_S_type) ? irbuffer1_out[19:15] : 5'b0;
    assign rs2    = (is_R_type || is_S_type || is_B_type) ? irbuffer1_out[24:20] : 5'b0;

    assign opcode2 = irbuffer2_out[6 : 0];

    assign is_R_type1 = (opcode2 == 7'b0110011); 
    assign is_I_type1 = (opcode2 == 7'b0010011); 
    assign is_Iload_type1 = (opcode2 == 7'b0000011); 
    assign is_S_type1 = (opcode2 == 7'b0100011); 
    assign is_LUI1 = (opcode2 == 7'b0110111); 
    assign is_AUIPC1 = (opcode2 == 7'b0010111); 
    assign is_B_type1 = (opcode2 == 7'b1100011); 
    assign is_JAL1 = (opcode2 == 7'b1101111);   
    assign is_JALR1 = (opcode2 == 7'b1100111);

    assign rd     = (is_R_type1 || is_I_type1 || is_Iload_type1 || is_LUI1 || is_AUIPC1 || is_JAL1 || is_JALR1) ? irbuffer2_out[11:7] : 5'b0;

    always_comb begin
        fwd_sela = 1'b0;
        fwd_selb = 1'b0;
        if (rd != 5'b0 &&  rd == rs1) 
            fwd_sela = 1'b1;
        else if (rd != 5'b0 && rd == rs2) begin
            fwd_selb = 1'b1;
        end
    end

endmodule