class baz;
    rand bit [31:0] c;
endclass

module Add2_tb;
    var logic unsigned [31:0] operand1;
    var logic unsigned [31:0] Sum;
        
    Add2 DUT (.*);

    task test_Add2;
        baz x;
        x            = new();
        x.randomize();
        operand1     = x.c;
        #1
        assert(Sum == operand1 + 32'd4);
    endtask

    initial begin
        
        for (int i = 0; i < 5; i++) begin
        test_Add2();
        #10;
        end

    end

endmodule