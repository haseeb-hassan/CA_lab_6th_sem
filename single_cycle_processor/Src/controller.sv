module controller (
    input  var logic [6:0] instruction,
    output var logic       Branch, MemRead, MemtoReg,
    output var logic [1:0] ALUOp,
    output var logic       MemWrite, ALUSrc, RegWrite
);

    always_comb begin
        case (instruction)
            7'b0110011: begin
                Branch   = 1'b0;
                MemRead  = 1'b0;
                MemtoReg = 1'b0;
                ALUOp    = 2'b10;
                MemWrite = 1'b0;
                ALUSrc   = 1'b0;
                RegWrite = 1'b1;
            end
            
            7'b0000011: begin
                Branch   = 1'b0;
                MemRead  = 1'b1;
                MemtoReg = 1'b1;
                ALUOp    = 2'b00;
                MemWrite = 1'b0;
                ALUSrc   = 1'b1;
                RegWrite = 1'b1;
            end

            7'b0100011: begin
                Branch   = 1'b0;
                MemRead  = 1'b0;
                MemtoReg = 1'b0;
                ALUOp    = 2'b00;
                MemWrite = 1'b1;
                ALUSrc   = 1'b1;
                RegWrite = 1'b0;
            end

            7'b1100011: begin
                Branch   = 1'b1;
                MemRead  = 1'b0;
                MemtoReg = 1'b0;
                ALUOp    = 2'b01;
                MemWrite = 1'b0;
                ALUSrc   = 1'b0;
                RegWrite = 1'b0;
            end

            default: begin
                Branch   = 1'b0;
                MemRead  = 1'b0;
                MemtoReg = 1'b0;
                ALUOp    = 2'b00;
                MemWrite = 1'b0;
                ALUSrc   = 1'b0;
                RegWrite = 1'b0;
            end
        endcase
    end

endmodule