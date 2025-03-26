module controller(
    input  logic [ 6:0] opcode,
    input  logic [ 2:0] func3,
    input  logic [ 6:0] func7,
    output logic rd_en,
    output logic wr_en,
    output logic sel_A,
    output logic sel_B,
    output logic [1:0] wb_sel,
    output logic reg_wr,
    output logic [2:0] br_type,
    output logic [3:0] aluop
);
    always_comb begin
        case(opcode)
            7'b0110111: //LUI
            begin
                reg_wr = 1'b1;
                wb_sel = 2'b00;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_A = 1'b1;
                sel_B = 1'b1;
                br_type = 3'b010;
                aluop = 4'b0000;
            end
            7'b0010111: //AUIPC
            begin
                reg_wr = 1'b1;
                wb_sel = 2'b00;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_A = 1'b0;
                sel_B = 1'b1;
                br_type = 3'b010;
                aluop = 4'b0000;
            end
            7'b1101111: //JAL
            begin
                reg_wr = 1'b1;
                wb_sel = 2'b01;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_A = 1'b0;
                sel_B = 1'b1;
                br_type = 3'b011;
                aluop = 4'b0000;
            end
            7'b1100111: //JALR
            begin
                reg_wr = 1'b1;
                wb_sel = 2'b01;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_A = 1'b0;
                sel_B = 1'b1;
                br_type = 3'b011;
                aluop = 4'b0000;
            end
            7'b1100011: //BEQ, BNE, BLT, BGE, BLTU, BGEU
            begin
                reg_wr = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_A = 1'b0;
                sel_B = 1'b1;
                aluop = 4'b0000;
                case (func3)
                    3'b000: br_type = 3'b000; // BEQ
                    3'b001: br_type = 3'b001; // BNE
                    3'b100: br_type = 3'b100; // BLT
                    3'b101: br_type = 3'b101; // BGE
                    3'b110: br_type = 3'b110; // BLTU
                    3'b111: br_type = 3'b111; // BGEU
                endcase
            end
            7'b0000011: //LB, LH, LW, LBU, LHU
            begin
                reg_wr = 1'b1;
                wb_sel = 2'b10;
                rd_en = 1'b1;
                wr_en = 1'b0;
                sel_A = 1'b1;
                sel_B = 1'b1;
                br_type = 3'b010;
                aluop = 4'b0000;
            end
            7'b0100011: //SB, SH, SW
            begin
                reg_wr = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b1;
                sel_A = 1'b1;
                sel_B = 1'b1;
                br_type = 3'b010;
                aluop = 4'b0000;
            end
            7'b0010011: //ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
            begin
                reg_wr = 1'b1;
                wb_sel = 2'b00;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_A = 1'b1;
                sel_B = 1'b1;
                br_type = 3'b010;
                case (func3)
                    3'b000: aluop = 4'b0000; // ADDI
                    3'b010: aluop = 4'b0011; // SLTI
                    3'b011: aluop = 4'b0100; // SLTIU
                    3'b100: aluop = 4'b0101; // XORI
                    3'b110: aluop = 4'b1000; // ORI
                    3'b111: aluop = 4'b1001; // ANDI
                    3'b001: aluop = 4'b0010; // SLLI
                    3'b101:
                    begin
                        if (func7 == 7'b0000000) aluop = 4'b0110; // SRLI
                        else if (func7 == 7'b0100000) aluop = 4'b0111; // SRAI
                    end
                endcase
            end
            7'b0110011: //ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
            begin
                reg_wr = 1'b1;
                wb_sel = 2'b00;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_A = 1'b1;
                sel_B = 1'b0;
                case (func7)
                    7'b0000000:
                    begin
                        case (func3)
                            3'b000: aluop = 4'b0000; //ADD
                            3'b001: aluop = 4'b0010; //SLL
                            3'b010: aluop = 4'b0011; //SLT
                            3'b011: aluop = 4'b0100; //SLTU
                            3'b100: aluop = 4'b0101; //XOR
                            3'b101: aluop = 4'b0110; //SRL
                            3'b110: aluop = 4'b1000; //OR
                            3'b111: aluop = 4'b1001; //AND
                        endcase
                    end
                    7'b0100000:
                    begin
                        case (func3)
                            3'b000: aluop = 4'b0001;
                            3'b101: aluop = 4'b0111;
                        endcase
                    end    
                endcase

            end
        endcase
    end
endmodule