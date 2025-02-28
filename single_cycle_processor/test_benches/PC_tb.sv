class baz;
    rand bit [31:0] c;
endclass

module PC_tb;
    var logic unsigned [31:0] out_address;
	var logic unsigned [31:0] in_address;
 	var logic unsigned 		 clk;
        
    PC DUT (.*);

    task test_PC;
        baz x;
        x            = new();
        x.randomize();
        in_address   = x.c;
        #5;
        assert(in_address == out_address);
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        
        for (int i = 0; i < 5; i++) begin
        test_PC();
        #10;
        end

    end

endmodule