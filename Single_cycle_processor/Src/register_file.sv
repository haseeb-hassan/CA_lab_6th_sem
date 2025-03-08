module register_file (
    input var logic [4:0] read_register_1,
    input var logic [4:0] read_register_2,
    input var logic clock,
    input var logic [4:0] write_register,
    input var logic [31:0] data_write,
    input var logic reset,
    input var logic write_en,
    output var logic [31:0] read_data_1,
    output var logic [31:0] read_data_2
);
    
     logic [31:0] registers [31:0]; 
 initial begin
        registers[0] = 32'h00000000;
        registers[1] = 32'h00000001;
        registers[2] = 32'h00000002;
        registers[3] = 32'h00000003;
        registers[4] = 32'h00000004;
        registers[5] = 32'h00000005;
        registers[6] = 32'h00000006;
        registers[7] = 32'h00000007;
        registers[8] = 32'h00000008;
        registers[9] = 32'h00000009;
        registers[10] = 32'h00000010;
        registers[11] = 32'h00000011;
        registers[12] = 32'h00000012;
        registers[13] = 32'h00000013;
        registers[14] = 32'h00000014;
        registers[15] = 32'h00000015;
        registers[16] = 32'h00000016;
        registers[17] = 32'h00000017;
        registers[18] = 32'h00000018;
        registers[19] = 32'h00000019;
        registers[20] = 32'h00000020;
        registers[21] = 32'h00000021;
        registers[22] = 32'h00000022;
        registers[23] = 32'h00000023;
        registers[24] = 32'h00000024;
        registers[25] = 32'h00000025;
        registers[26] = 32'h00000026;
        registers[27] = 32'h00000027;
        registers[28] = 32'h00000028;
        registers[29] = 32'h00000029;
        registers[30] = 32'h00000030;
        registers[31] = 32'h00000031;
    end

    // Reset or Write Operations in always_ff
    always@(posedge clock  or negedge reset) begin
        if (reset) begin
            for (int i = 0; i < 32; i++) begin
                registers[i] <= 32'h00000000;  // Clear all registers
            end
        end else if (write_en) begin
            registers[write_register] <= data_write; // Write operation
        end
    end

    // Read Operations in always_comb
    always_comb begin
        read_data_1 = registers[read_register_1];
        read_data_2 = registers[read_register_2];
    end

endmodule
