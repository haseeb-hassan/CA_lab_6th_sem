module Add (
    output var logic unsigned [31:0] Sum,
    input  var logic unsigned [31:0] operand11,
    input  var logic unsigned [31:0] operand22
);

    always_comb begin
        Sum = operand11 + operand22;
    end
    
endmodule