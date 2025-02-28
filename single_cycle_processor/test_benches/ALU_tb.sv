class baz;
    rand bit [31:0] c;
    rand bit [31:0] d;
    rand bit [ 3:0] e;

    constraint e_constraint {
        e inside {4'b0000, 4'b0001, 4'b0010, 4'b0110};
    }
endclass

module ALU_tb;
    var logic unsigned        zero;
    var logic unsigned [31:0] ALUresult;
    var logic unsigned [31:0] operand1;
    var logic unsigned [31:0] operand2;
    var logic unsigned [ 3:0] ALUoperation;
        
    ALU DUT (.*);

    task test_ALU;
        baz x;
        x            = new();
        x.randomize();
        operand1     = x.c;
        operand2     = x.d;
        ALUoperation = x.e;
        #1;
        case(ALUoperation)
            4'b0000 : assert (ALUresult == operand1 & operand2);
            4'b0001 : assert (ALUresult == operand1 | operand2);
            4'b0010 : assert (ALUresult == operand1 + operand2);
            4'b0110 : assert (ALUresult == operand1 - operand2);
        endcase

        if ((ALUoperation == 4'b0110) & (ALUresult == 32'd0)) begin
            assert (zero == 1'b1);
        end
        else begin
            assert (zero == 1'b0);
        end
    endtask

    task test_ALU1;
        baz y;
        y            = new();
        y.randomize();
        operand1     = y.c;
        operand2     = operand1;
        ALUoperation = 4'b0110;
        #1;
        assert (ALUresult == operand1 - operand2);
        assert (zero == 1'b1);
    endtask

    initial begin
        
        test_ALU1();
        #10;
        for (int i = 0; i < 5; i++) begin
        test_ALU();
        #10;
        end

    end

endmodule