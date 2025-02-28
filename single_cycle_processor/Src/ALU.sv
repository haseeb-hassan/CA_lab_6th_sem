module ALU (
    output var logic unsigned        zero,
    output var logic unsigned [31:0] ALUresult,
    input  var logic unsigned [31:0] operand1,
    input  var logic unsigned [31:0] operand2,
    input  var logic unsigned [ 3:0] ALUoperation
);
    
    always_comb begin
        case(ALUoperation)
            4'b0000 : ALUresult = operand1 & operand2;
            4'b0001 : ALUresult = operand1 | operand2;
            4'b0010 : ALUresult = operand1 + operand2;
            4'b0110 : ALUresult = operand1 - operand2;
        endcase

        if ((ALUoperation == 4'b0110) & (ALUresult == 32'd0)) begin
            zero = 1'b1;
        end
        else begin
            zero = 1'b0;
        end
    end

endmodule