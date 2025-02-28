module InstructionMemory (
	output var logic [31:0] Instruction,
	input  var logic [31:0] Instruction_address
);

	var logic [31:0] memory [9:0];
	var logic [31:0] memory_address;
	
	always_comb begin
		memory_address = Instruction_address / 4;
		Instruction    = memory[memory_address];
	end
	
endmodule