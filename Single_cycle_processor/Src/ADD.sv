module ADD(
    input var logic [31:0] operand1,
    input var logic [31:0] operand2,
    output var logic [31:0] sum
);
    always @(*) begin 
           sum = operand1 + operand2;  // ADD
    end
endmodule

