module inst_dec
(
    input  logic [31:0] inst,
    output logic [ 6:0] opcode,
    output logic [ 2:0] func3,
    output logic [ 6:0] func7,
    output logic [ 4:0] rs1,
    output logic [ 4:0] rs2,
    output logic [31:0] imm,
    output logic [ 4:0] rd
);
    // Assign the opcode fields
    assign opcode = inst[6 : 0];
    always_comb begin
        case (opcode)
            7'b0110111: //LUI
            begin
                assign rs1 = 5'b0;
                assign rd = inst[11:7];
                assign imm = {inst[31:12], 12'b0};
            end
            7'b0010111: //AUIPC
            begin
                assign rd = inst[11:7];
                assign imm = {inst[31:12], 12'b0};
            end
            7'b1101111: //JAL
            begin
                assign rd = inst[11:7];
                assign imm = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
            end
            7'b1100111: //JALR
            begin
                assign rd = inst[11:7];
                assign func3 = inst[14:12];
                assign rs1 = inst[19:15];
                assign imm = {{20{inst[31]}}, inst[31:20]};
            end
            7'b1100011: //BEQ, BNE, BLT, BGE, BLTU, BGEU
            begin
                assign func3 = inst[14:12];
                assign rs1 = inst[19:15];
                assign rs2 = inst[24:20];
                assign imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            end
            7'b0000011: //LB, LH, LW, LBU, LHU
            begin
                assign rd = inst[11:7];
                assign func3 = inst[14:12];
                assign rs1 = inst[19:15];
                assign imm = {{20{inst[31]}}, inst[31:20]};
            end
            7'b0100011: //SB, SH, SW
            begin
                assign func3 = inst[14:12];
                assign rs1 = inst[19:15];
                assign rs2 = inst[24:20];
                assign imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
            end
            7'b0010011: //ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
            begin
                assign rd = inst[11:7];
                assign func3 = inst[14:12];
                assign rs1 = inst[19:15];
                assign imm = {{20{inst[31]}}, inst[31:20]};
                assign func7 = inst[31:25];

            end
            7'b0110011: //ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, MUL, MULH, MULSU, MULU, DIV, DIVU, REM, REMU
            begin
                assign rd = inst[11:7];
                assign func3 = inst[14:12];
                assign rs1 = inst[19:15];
                assign rs2 = inst[24:20];
                assign func7 = inst[31:25];
            end
        endcase
    end
endmodule
