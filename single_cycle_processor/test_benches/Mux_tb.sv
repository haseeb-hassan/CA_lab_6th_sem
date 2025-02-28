class baz;
    rand bit [31:0] c;
    rand bit [31:0] d;
    rand bit        e;
endclass

module Mux_tb;
    var logic unsigned [31:0] out;
    var logic unsigned [31:0] in1;
    var logic unsigned [31:0] in2;
    var logic unsigned        MemtoReg;
        
    Mux DUT (.*);

    task test_Mux;
        baz x;
        x            = new();
        x.randomize();
        in1          = x.c;
        in2          = x.d;
        MemtoReg     = x.e;
        #1;
        case(MemtoReg)
            1'b0 : assert (out == in2);
            1'b1 : assert (out == in1);
        endcase
    endtask

    initial begin
        
        for (int i = 0; i < 5; i++) begin
        test_Mux();
        #10;
        end

    end

endmodule