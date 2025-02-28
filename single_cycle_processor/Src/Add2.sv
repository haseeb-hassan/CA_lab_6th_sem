module Add2 (
    output var logic unsigned [31:0] Sum1,
    input  var logic unsigned [31:0] operand111
);

    always_comb begin
        Sum1 = operand111 + 32'd4;
    end
    
endmodule