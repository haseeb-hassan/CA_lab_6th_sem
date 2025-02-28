class controller_Inputs;
    rand bit [6:0] instruction;
    //constraint valid_instructions {
        //instruction inside {7'b0110011, 
                            //7'b0000011,  
                            //7'b0100011,  
                            //7'b1100011}; 
   // }
endclass

module controller_tb;

    logic unsigned [6:0] instruction;
    logic unsigned Branch, MemRead, MemtoReg;
    logic unsigned [1:0] ALUOp;
    logic unsigned MemWrite, ALUSrc, RegWrite;

    controller DUT (.*);

    task test_controller;
        controller_Inputs x;
        x = new();
        x.randomize(); 
        instruction = x.instruction;
        $display("Instruction = %b", instruction);
    endtask

    initial begin
        for (int i = 0; i < 20; i++) begin
            test_controller();
            #5;
            $display("Instruction = %b, Branch = %b, MemRead = %b, MemtoReg = %b, ALUOp = %b, MemWrite = %b, ALUSrc = %b, RegWrite = %b", 
                    instruction, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);      
        end
    end

endmodule
