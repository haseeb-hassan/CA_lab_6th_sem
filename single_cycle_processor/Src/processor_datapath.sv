module processor_datapath(
    input  var logic       clk,
    input  var logic       rst,
    input  var logic       sel,
    input  var logic       sel2,
    input  var logic       regw,
    input  var logic       alu_src,
    input  var logic       memw,
    input  var logic       memr,
    input  var logic [3:0] alu_op,
    output var logic [6:0] inst_control,
    output var logic [9:0] inst_alu,
    output var logic       zero_flag

);

wire logic [31:0] out_add, in_add;
wire logic [31:0] inst, imm;
wire logic [31:0] n1, n2;
wire logic [31:0] rd1, rd2;
wire logic [31:0] a1, a2;
wire logic [31:0] alu_out, data_out;

always_comb begin
    inst_control = inst[6:0];
    inst_alu     = {inst[31:25], inst[14:12]};
end

PC                PC       (.clk                 (clk),
                            .rst                 (rst),
                            .in_address          (in_add),
                            .out_address         (out_add)
                           );
      
InstructionMemory Inst_Mem (.Instruction_address (out_add),
                            .Instruction         (inst)
                           );

Add2              Add2     (.operand111          (out_add),
                            .Sum1                (n1)
                           );

imm_gen           imm_gen  (.instruction         (inst),
                            .imm_val           (imm)
                           );

Add               Add      (.operand11           (out_add),
                            .operand22           (imm),
                            .Sum                 (n2)
                           ); 

Mux               m1       (.in1                 (n1),
                            .in2                 (n2),
                            .out                 (in_add),
                            .MemtoReg            (sel)
                           );  

Registers        Reg_file  (.Read_reg1           (inst[19:15]),
                            .Read_reg2           (inst[24:20]),
                            .Write_reg           (inst[11:7]),
                            .Write_data          (a1),
                            .Read_data1          (rd1),
                            .Read_data2          (rd2),
                            .clk                 (clk),
                            .RegWrite            (regw)
                           ); 

Mux               m2       (.in1                 (rd2),
                            .in2                 (imm),
                            .out                 (a2),
                            .MemtoReg            (alu_src)
                           );        

ALU              alu       (.operand1            (rd1),
                            .operand2            (a2),
                            .ALUresult           (alu_out),
                            .ALUoperation       (alu_op),
                            .zero                (zero_flag)

                           );    

DataMemory       Data_Mem  (.clk                 (clk),
                            .MemWrite            (memw),
                            .MemRead             (memr),
                            .address             (alu_out),
                            .writeData           (rd2),
                            .readData            (data_out) 
                           );

Mux               m3       (.in1                 (alu_out),
                            .in2                 (data_out),
                            .out                 (a1),
                            .MemtoReg            (sel2)
                           );  
endmodule