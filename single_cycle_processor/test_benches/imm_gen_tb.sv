class baz;
    rand bit [31:0] a;
endclass

module imm_gen_tb;
    var logic unsigned [31:0] instruction;
    var logic unsigned [31:0] imm_val;

    imm_gen DUT (.*);

    task test_imm_gen;
        baz x;
        x            = new();
        x.randomize();
        instruction  = x.a;
    endtask

    initial begin
        
        for (int i = 0; i < 5; i++) begin
        test_imm_gen();
        #10;
        end
    end

endmodule