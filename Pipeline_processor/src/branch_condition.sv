module branch_condition
(
    input  logic [31:0] rdata1,     
    input  logic [31:0] rdata2,     
    input  logic [2:0]  br_type,  // Branch operation code
    output logic [1:0]  br_taken // Output: whether the branch condition is met
);

    always_comb
    begin
        case (br_type)
            3'b000: br_taken = (rdata1 == rdata2) ? 2'b01 : 2'b00;  // BEQ
            3'b001: br_taken = (rdata1 != rdata2) ? 2'b01 : 2'b00;  // BNE
            3'b100: br_taken = ($signed(rdata1) < $signed(rdata2)) ? 2'b01 : 2'b00; // BLT
            3'b101: br_taken = ($signed(rdata1) >= $signed(rdata2)) ? 2'b01 : 2'b00; // BGE
            3'b110: br_taken = (rdata1 < rdata2) ? 2'b01 : 2'b00;   // BLTU
            3'b111: br_taken = (rdata1 >= rdata2) ? 2'b01 : 2'b00;  // BGEU
            3'b011: br_taken = 2'b10;  //JAL, JALR
            3'b010: br_taken = 2'b00;  
            default: br_taken = 2'b00; // Default: No branch taken
        endcase
    end

endmodule
