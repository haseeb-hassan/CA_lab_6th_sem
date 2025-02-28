class baz;
    rand bit [31:0] c;
    rand bit [31:0] d;
endclass

module Add_tb;
    var logic unsigned [31:0] Sum;
    var logic unsigned [31:0] operand1;
    var logic unsigned [31:0] operand2;
        
    Add DUT (.*);

    task test_Add;
        baz x;
        x            = new();
        x.randomize();
        operand1     = x.c;
        operand2     = x.d;
        #1;
        assert(Sum == operand1 + operand2);
    endtask

    initial begin
        
        for (int i = 0; i < 5; i++) begin
        test_Add();
        #10;
        end

    end

endmodule