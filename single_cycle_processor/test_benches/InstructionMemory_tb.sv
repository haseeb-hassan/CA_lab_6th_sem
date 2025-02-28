class baz;
    rand bit [31:0] a;
endclass

module InstructionMemory_tb;
	var logic [31:0] Instruction;
	var logic [31:0] Instruction_address;
    var logic [31:0] temp [9:0];

    InstructionMemory DUT (.*);

    task writemem(int i);
        baz x;
        x            = new();
        x.randomize();
        temp[i]  = x.a;
    endtask

    task test_InstructionMemory;
        for (int i = 0; i < 10; i++) begin
            writemem(i);
        end
        $writememh("InstructionMemory.txt",temp);
        $readmemh("InstructionMemory.txt",DUT.memory);
        for (int i = 0; i < 10; i++) begin
            Instruction_address = i * 4;
            #10;
            $display("Address: %0d | Expected: %h | Read: %h", i, temp[i], Instruction);
        end
    endtask

    initial begin
        test_InstructionMemory();
    end

endmodule