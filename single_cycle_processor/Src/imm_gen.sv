module imm_gen (
    output var logic unsigned [31:0] imm_val,
    input  var logic unsigned [31:0] instruction
);

logic unsigned [11:0] immediate;

    always_comb begin
        if      (instruction[6] == 1'b0) begin                                // Data transfer instruction
            if      (instruction[5] == 1'b0) begin                            // Load instruction
                immediate = instruction[31:20];
            end 
			
			else if (instruction[5] == 1'b1) begin                            // Store instruction
                immediate = {instruction[31:25], instruction[11:7]};
            end
        end 
		
		else if (instruction[6] == 1'b1) begin                                // Conditional Branch instruction
                immediate = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
        end 
		
		else begin
                immediate = 12'b0;                                            // Default if no match
        end

        imm_val = {20'b0 , immediate};
    end
endmodule
