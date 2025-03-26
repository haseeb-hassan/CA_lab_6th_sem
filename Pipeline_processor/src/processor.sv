module processor
(
    input  logic clk,
    input  logic rst
);

    logic [31:0] pc_out;
    logic [31:0] pc_in;
    logic [31:0] inst;

    logic [ 6:0] opcode;
    logic [ 2:0] func3;
    logic [ 6:0] func7;
    logic [ 4:0] rs1;
    logic [ 4:0] rs2;
    logic [ 4:0] rd;
    logic [31:0] imm;

    logic [31:0] rdata1;
    logic [31:0] rdata2;
    logic [31:0] wdata;
    logic reg_wr;

    logic [31:0] mux_out_a;
    logic [31:0] mux_out_b;
    logic [31:0] opr_res;
    logic sel_A;
    logic sel_B;
    logic [3:0] aluop;

    logic [1:0] br_taken;
    logic [2:0] br_type;

    logic [31:0] rdata;
    logic rd_en, wr_en;
    logic [1:0] wb_sel;

    //PC buffers
    logic [31:0] pcbuffer1_out;
    logic [31:0] pcbuffer2_out;

    //IR_Buffers
    logic [31:0] irbuffer1_out;
    logic [31:0] irbuffer2_out;
    logic  [4:0] rd_out;

    //ALU Buffer
    logic [31:0] alubuffer_out;

    //WD Buffer
    logic [31:0] wdbuffer_out;

    //Forwarding
    logic fwd_sela;
    logic fwd_selb;
    logic [31:0] fwdmuxa_out;
    logic [31:0] fwdmuxb_out;

    //Controller Buffer 2
    logic rd_en1;  
    logic wr_en1;   
    logic [1:0] wb_sel1;
    logic reg_wr1;

    //Instance for Program Counter MUX
    pc_mux pc_mux
    (
        .pc_out   (pc_out),
        .opr_res  (alubuffer_out),
        .br_taken (br_taken),
        .pc_in (pc_in)
    );

    //Instance for Program Counter
    pc pc_inst
    (
        .clk   (clk),
        .rst   (rst),
        .pc_in (pc_in),
        .pc_out (pc_out)
    );

    //PC Buffer after Fetch phase
    pc_buffer1 pc_buffer1
    (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out),
        .pcbuffer1_out(pcbuffer1_out)
    );

    //Instance for Instruction Memory
    inst_mem imem
    (
        .addr(pc_out),
        .data(inst)
    );

    //IR Buffer 1 --After Fetch phase
    ir_buffer1 ir_buffer1
    (
        .clk(clk),
        .rst(rst),
        .inst(inst),
        .irbuffer1_out(irbuffer1_out)
    );

    //Instance for Instruction Decoder, Note that the module of Immediate generator is combined with the decoder
    inst_dec inst_instance
    (
        .inst    (irbuffer1_out),
        .rs1     (rs1),
        .rs2     (rs2),
        .rd      (rd),
        .opcode  (opcode),
        .func3   (func3),
        .imm     (imm),
        .func7   (func7)
    );

    //Instance for Register File
    reg_file reg_file_inst
    (
        .raddr1(rs1),
        .raddr2(rs2),
        .waddr(rd_out),
        .reg_wr(reg_wr1),
        .clk(clk),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .wdata(wdata)
    );

    //Forward Mux A
    fwd_mux_a fwd_mux_a
    (
        .rdata1(rdata1),
        .wdata(wdata),
        .fwd_sela(fwd_sela),
        .out(fwdmuxa_out)
    );

    //Instance for ALU MUX A
    alu_mux_a alu_mux_a
    (
        .rdata1(fwdmuxa_out),
        .pc_out(pcbuffer1_out),
        .sel_A(sel_A),
        .mux_out_a(mux_out_a)
    );

    //Forward Mux B
    fwd_mux_b fwd_mux_b
    (
        .rdata2(rdata2),
        .wdata(wdata),
        .fwd_selb(fwd_selb),
        .out(fwdmuxb_out)
    );

    //Instance for ALU MUX B
    alu_mux_b alu_mux_b
    (
        .rdata2(fwdmuxb_out),
        .imm(imm),
        .sel_B(sel_B),
        .mux_out_b(mux_out_b)
    );

    //Instance for ALU
    alu alu_inst
    (
        .opr_a(mux_out_a),
        .opr_b(mux_out_b),
        .aluop(aluop),
        .opr_res(opr_res)
    );

    //ALU Buffer
    alu_buffer alu_buffer
    (
        .clk(clk),
        .rst(rst),
        .opr_res(opr_res),
        .alubuffer_out(alubuffer_out)
    );

    //IR Buffer 2
    ir_buffer2 ir_buffer2
    (
        .clk(clk),
        .rst(rst),
        .irbuffer1_out(irbuffer1_out),
        .rd_in(rd),
        .irbuffer2_out(irbuffer2_out),
        .rd_out(rd_out)
    );

    //PC Buffer 2 --After Execute phase
    pc_buffer2 pc_buffer2
    (
        .clk(clk),
        .rst(rst),
        .pcbuffer1_out(pcbuffer1_out),
        .pcbuffer2_out(pcbuffer2_out)
    );

    //Buffer for wdata
    wd_buffer wd_buffer
    (
        .clk(clk),
        .rst(rst),
        .fwd_mux_out(fwdmuxb_out),
        .wdbuffer_out(wdbuffer_out)
    );

    branch_condition br_cndtn
    (
        .rdata1(fwdmuxa_out),
        .rdata2(fwdmuxb_out),
        .br_type(br_type),
        .br_taken(br_taken)
    );

    //Instance for Data Memory
    data_mem data_mem_inst (
        .clk(clk),
        .rd_en(rd_en1),
        .wr_en(wr_en1),
        .addr(alubuffer_out),
        .wdata(wdbuffer_out),
        .rdata(rdata),
        .func3(func3) 
    );

    //Instance for Write Back MUX
    wb_mux wb_mux (
        .opr_res(alubuffer_out),
        .rdata(rdata),
        .wb_sel(wb_sel1),
        .wdata(wdata),
        .pc_out(pcbuffer2_out)
    );

    //Forward Unit
    fwd_unit fwd_unit
    (
        .irbuffer1_out(irbuffer1_out),
        .irbuffer2_out(irbuffer2_out),
        .fwd_sela(fwd_sela),
        .fwd_selb(fwd_selb)
    );

    //Instance for Controller
    controller contr_inst
    (
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .reg_wr(reg_wr),
        .aluop(aluop),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .sel_A(sel_A),
        .sel_B(sel_B),
        .wb_sel(wb_sel),
        .br_type(br_type)
    );

    //Controller Buffer
    controller_buffer2 controller_buffer2
    (
        .clk(clk),
        .rst(rst),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .wb_sel(wb_sel),
        .reg_wr(reg_wr),
        .rd_en1(rd_en1),
        .wr_en1(wr_en1),
        .wb_sel1(wb_sel1),
        .reg_wr1(reg_wr1)
    );
endmodule