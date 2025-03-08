module CPU (
    input logic clock,
    input logic reset,
    output logic [31:0] instruction,
    output logic [31:0] ALU_result,
    output logic zero
);
    
    logic [31:0] pc_out;
    logic [31:0] pc_next;
    logic [31:0] pc_next_mux;
     logic [31:0]  mux_out;
    logic [31:0]  imm_to_bin;
    logic [31:0]  data_write_back_to_reg;
    logic [31:0] read_data_1, read_data_2;
    logic [31:0] read_data_to_bin;
    logic [3:0] ALU_control;
    logic register_write_enable;
    logic br_taken_mux_sel;
    logic [2:0] br_type_wire;
    logic [31:0]  mux_rs1_pc_to_operand1;
    logic [2:0] imm_sel;
    logic op_sel_rs1_pc;
    logic [31:0] J_adder_input_mux3x1;
    logic [1:0] mem_to_reg_wire;
    
    // Instantiate the PC module
    PC program_counter (
        .pc_in(pc_next_mux),
        .reset(reset),
        .clock(clock),
        .pc_out(pc_out)
    );
    

    PC_Adder pc_adder (
        .operand1(pc_out),
        .sum(pc_next)
    );
    
    // Instantiate the Instruction Memory module
    instruction_memory inst_mem (
        .address(pc_out),
        .instruction(instruction)
    );
    
    // Instantiate the Controller module
    controller ctrl (
        .instruction(instruction),
        .ALU_control(ALU_control),
        .register_write_enable(register_write_enable),
        . opsel(opsel),
        . immsrc(imm_sel),
        .mem_to_reg(mem_to_reg_wire),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .br_type(br_type_wire),
        .opsel2(op_sel_rs1_pc)
    );
    
    // Instantiate the Register File module
    register_file reg_file (
        .read_register_1(instruction[19:15]),
        .read_register_2(instruction[24:20]),
        .clock(clock),
        .write_register(instruction[11:7]),
        .data_write( data_write_back_to_reg),
        .reset(reset),
        .write_en(register_write_enable),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );
      mux2x1 mux_rs2_imm (
        .a_in(read_data_2), 
        .b_in(imm_to_bin),    
        .sel(opsel),      
        .z_out(mux_out)    
    );
   ALU alu (
        .operand1( mux_rs1_pc_to_operand1),
        .operand2(mux_out),  
        .ALUoperation(ALU_control),
        .result(ALU_result),
        .zero(zero)
    );
    imm_generator imm_generator_inst(
        .instr(instruction),
        . imm_src(imm_sel),
        .imm_out(imm_to_bin)
    );
    Data_memory Data_memory_inst(
        .Add(ALU_result),
        .write_data(read_data_2),
        .clock(clock),
        .reset(reset),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(read_data_to_bin)
    );

        PC_Adder pc_adder_for_Jump (
        .operand1(pc_out),
        .sum(J_adder_input_mux3x1)
    ); 


    mux3x1 mux_writeback(
        .in1(J_adder_input_mux3x1),
        .in2(ALU_result),
        .in3(read_data_to_bin),
        .sel(mem_to_reg_wire),
        .out( data_write_back_to_reg)
    );
    mux2x1 mux_Programcounter(
        .a_in(pc_next),
        .b_in(ALU_result),
        .sel(br_taken_mux_sel),
        .z_out(pc_next_mux)
    );
    branch_condition branch_condition_inst(
        .rg1(read_data_1),
        .rg2(read_data_2),
        .br_type(br_type_wire),
        .op( instruction[6:0]),
        .br_taken(br_taken_mux_sel)
    );
    mux2x1 mux_rs1_pc (
        .a_in(pc_out), 
        .b_in(read_data_1),    
        .sel(op_sel_rs1_pc),      
        .z_out( mux_rs1_pc_to_operand1)    
    );
endmodule
