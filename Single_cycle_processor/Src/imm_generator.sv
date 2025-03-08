module imm_generator (
    input logic [31:0] instr,    
    input logic [2:0] imm_src,    
    output var logic [31:0] imm_out
);

    always_comb begin
        case (imm_src)
            3'b000: imm_out = {{20{instr[31]}}, instr[31:20]}; // I-Type Immediate
            3'b001: imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-Type Immediate
            3'b010: imm_out = {{19{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // B-Type Immediate
            3'b011: imm_out = {{11{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; // J-Type Immediate
            3'b100: imm_out = {instr[31:12], 12'b0}; // U-Type Immediate (Load Upper Immediate)
            default: imm_out = 32'b0; // Default case
        endcase
    end
endmodule
