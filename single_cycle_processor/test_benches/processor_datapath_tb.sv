class baz;
    rand bit sel;
    rand bit sel2;
    rand bit regw;
    rand bit alu_src;
    rand bit memw;
    rand bit memr;
    rand bit [3:0] alu_op;
endclass

module processor_datapath_tb;
    logic rst;
    logic clk;

    logic sel;
    logic sel2;
    logic regw;
    logic alu_src;
    logic memw;
    logic memr;
    logic [3:0] alu_op;
    logic [6:0] inst_control;
    logic [9:0] inst_alu;
    logic zero_flag;

    processor_datapath DUT (
        .clk(clk),
        .rst(rst),
        .sel(sel),
        .sel2(sel2),
        .regw(regw),
        .alu_src(alu_src),
        .memw(memw),
        .memr(memr),
        .alu_op(alu_op),
        .inst_control(inst_control),
        .inst_alu(inst_alu),
        .zero_flag(zero_flag)
    );

    task test_processor_datapath;
        baz x;
        x = new();
        x.randomize();
        sel = x.sel;
        sel2 = x.sel2;
        regw = x.regw;
        alu_src = x.alu_src;
        memw = x.memw;
        memr = x.memr;
        alu_op = x.alu_op;
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #5;
        rst = 0;
        for (int i = 0; i < 5; i++) begin
            test_processor_datapath();
            #10;
            $display("sel = %b, sel2 = %b, regw = %b, alu_src = %b, memw = %b, memr = %b, alu_op = %b, inst_control = %b, inst_alu = %b, zero_flag = %b", 
                     sel, sel2, regw, alu_src, memw, memr, alu_op, inst_control, inst_alu, zero_flag);
        end
    end
endmodule
