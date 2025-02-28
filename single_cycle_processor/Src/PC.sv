module PC (
    output var logic unsigned [31:0] out_address,
	input  var logic unsigned [31:0] in_address,
 	input  var logic unsigned 		 clk,
	input  var logic unsigned 		 rst
);

	always_ff @(posedge clk) begin
		out_address <= in_address;
	end

endmodule