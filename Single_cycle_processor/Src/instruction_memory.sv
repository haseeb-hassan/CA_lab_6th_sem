module instruction_memory (
    input var logic [31:0] address,
    output var logic [31:0] instruction
);
    
    var logic [31:0] memory [0:255]; // 256-word memory
    
    initial begin
memory[0]  = 32'h00500093;  // addi x1, x0, 5        # x1 = 5
memory[1]  = 32'h00A00113;  // addi x2, x0, 10       # x2 = 10
memory[2]  = 32'h00F00193;  // addi x3, x0, 15       # x3 = 15
memory[3]  = 32'h01400213;  // addi x4, x0, 20       # x4 = 20
memory[4]  = 32'hFF800293;  // addi x5, x0, -8       # x5 = -8 (sign-extended)
memory[5]  = 32'h00C28313;  // addi x6, x5, 12       # x6 = x5 + 12
memory[6]  = 32'hFFD30393;  // addi x7, x6, -3       # x7 = x6 - 3
memory[7]  = 32'h00718413;  // addi x8, x3, 7        # x8 = x3 + 7
memory[8]  = 32'h00040493;  // addi x9, x8, 0        # x9 = x8 (copy)
memory[9]  = 32'h00148513;  // addi x10, x9, 1       # x10 = x9 + 1

memory[10] = 32'h0000A583;  // lw x11, 0(x1)         # Load from address in x1
memory[11] = 32'h00412603;  // lw x12, 4(x2)         # Load from x2 + 4
memory[12] = 32'h0081A683;  // lw x13, 8(x3)         # Load from x3 + 8
memory[13] = 32'hFFC22703;  // lw x14, -4(x4)        # Load from x4 - 4
memory[14] = 32'h00C2A783;  // lw x15, 12(x5)        # Load from x5 + 12
memory[15] = 32'h00032803;  // lw x16, 0(x6)         # Load from x6
memory[16] = 32'h0103A883;  // lw x17, 16(x7)        # Load from x7 + 16
memory[17] = 32'h01442903;  // lw x18, 20(x8)        # Load from x8 + 20
memory[18] = 32'hFF84A983;  // lw x19, -8(x9)        # Load from x9 - 8
memory[19] = 32'h01852A03;  // lw x20, 24(x10)       # Load from x10 + 24


//STORE  S TYPE 

memory[20] = 32'h0062A023;  // sw x6, 0(x5)   -> Store word from x6 at address (x5 + 0)
memory[21] = 32'h0072A223;  // sw x7, 4(x5)   -> Store word from x7 at address (x5 + 4)
memory[22] = 32'h0082A423;  // sw x8, 8(x5)   -> Store word from x8 at address (x5 + 8)
memory[23] = 32'hFE92AE23;  // sw x9, -4(x5)  -> Store word from x9 at address (x5 - 4)
memory[24] = 32'hFE62AC23;  // sw x6, -8(x5)  -> Store word from x6 at address (x5 - 8)

    end
    
    always_comb begin
        instruction = memory[address[31:2]]; // Word-aligned access
    end
    
endmodule