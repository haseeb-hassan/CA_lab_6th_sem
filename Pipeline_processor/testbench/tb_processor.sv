module tb_processor();
    logic clk;
    logic rst;

    processor dut
    (
        .clk(clk),
        .rst(rst)
    );

    // Clock Generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset Generator
    initial begin
        rst = 1;
        #10;
        rst = 0;
        #10000;
        $finish;
    end

    // Initializing Instruction, Register File, and Data Memories
    initial begin
        $readmemh("instruction_memory", dut.imem.mem);
        $readmemb("register_file", dut.reg_file_inst.reg_mem);
        $readmemb("data_memory", dut.data_mem_inst.mem);
    end

    // For the use of GTKWave
    initial begin
        $dumpfile("processor.vcd");
        $dumpvars(0, tb_processor);
        $dumpvars(1, dut.reg_file_inst.reg_mem); // Dump register file values
    end

endmodule