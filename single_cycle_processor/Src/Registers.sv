module Registers (
	output var logic unsigned [31:0] Read_data1,
 	output var logic unsigned [31:0] Read_data2,
	input  var logic unsigned [ 4:0] Read_reg1,
	input  var logic unsigned [ 4:0] Read_reg2,
	input  var logic unsigned [ 4:0] Write_reg,
	input  var logic unsigned [31:0] Write_data,
	input  var logic unsigned 		 RegWrite,
	input  var logic unsigned 		 clk
);

	var logic unsigned [31:0] Registers [15:0];
	always_comb begin
		case(Read_reg1)
			5'd0  : Read_data1 = Registers[0];
			5'd1  : Read_data1 = Registers[1];
			5'd2  : Read_data1 = Registers[2];
			5'd3  : Read_data1 = Registers[3];
			5'd4  : Read_data1 = Registers[4];
			5'd5  : Read_data1 = Registers[5];
			5'd6  : Read_data1 = Registers[6];
			5'd7  : Read_data1 = Registers[7];
			5'd8  : Read_data1 = Registers[8];
			5'd9  : Read_data1 = Registers[9];
			5'd10 : Read_data1 = Registers[10];
			5'd11 : Read_data1 = Registers[11];
			5'd12 : Read_data1 = Registers[12];
			5'd13 : Read_data1 = Registers[13];
			5'd14 : Read_data1 = Registers[14];
			5'd15 : Read_data1 = Registers[15];
		endcase
	end

	always_comb begin
		case(Read_reg2)
			5'd0  : Read_data2 = Registers[0];
			5'd1  : Read_data2 = Registers[1];
			5'd2  : Read_data2 = Registers[2];
			5'd3  : Read_data2 = Registers[3];
			5'd4  : Read_data2 = Registers[4];
			5'd5  : Read_data2 = Registers[5];
			5'd6  : Read_data2 = Registers[6];
			5'd7  : Read_data2 = Registers[7];
			5'd8  : Read_data2 = Registers[8];
			5'd9  : Read_data2 = Registers[9];
			5'd10 : Read_data2 = Registers[10];
			5'd11 : Read_data2 = Registers[11];
			5'd12 : Read_data2 = Registers[12];
			5'd13 : Read_data2 = Registers[13];
			5'd14 : Read_data2 = Registers[14];
			5'd15 : Read_data2 = Registers[15];
		endcase
	end

	always_ff @(posedge clk) begin
		if (RegWrite) begin
			case(Write_reg)
				5'd0  : Registers[0]  <= Write_data;
				5'd1  : Registers[1]  <= Write_data;
				5'd2  : Registers[2]  <= Write_data;
				5'd3  : Registers[3]  <= Write_data;
				5'd4  : Registers[4]  <= Write_data;
				5'd5  : Registers[5]  <= Write_data;
				5'd6  : Registers[6]  <= Write_data;
				5'd7  : Registers[7]  <= Write_data;
				5'd8  : Registers[8]  <= Write_data;
				5'd9  : Registers[9]  <= Write_data;
				5'd10 : Registers[10] <= Write_data;
				5'd11 : Registers[11] <= Write_data;
				5'd12 : Registers[12] <= Write_data;
				5'd13 : Registers[13] <= Write_data;
				5'd14 : Registers[14] <= Write_data;
				5'd15 : Registers[15] <= Write_data;
			endcase
		end
	end

endmodule