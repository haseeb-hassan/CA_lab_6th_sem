module SingleCycleProc (
    input var logic rst,
    input var logic clk
);
wire logic [3:0] n11;
wire logic [6:0] n10;
wire logic [9:0] n12;
wire logic [1:0] n4;
wire logic       n1, n2, n3, n5, n6, n7, n8, n9;

processor_datapath      DATAPATH   (.clk         (clk),
                                    .rst        (rst),
                           .sel         (n9),
                           .sel2        (n3),
                           .regw        (n7),
                           .alu_src     (n6),
                           .memw        (n5),
                           .memr        (n2),
                           .alu_op      (n11),
                           .inst_control(n10),
                           .inst_alu    (n12),
                           .zero_flag   (n8)
                          );

controller     Control    (.instruction (n10),
                           .Branch      (n1),
                           .MemRead     (n2),
                           .MemtoReg    (n3),
                           .ALUOp       (n4),
                           .MemWrite    (n5),
                           .ALUSrc      (n6),
                           .RegWrite    (n7)
                          );

ALU_controller ALUControl (.ALUOp(n4),
                           .inst_Func7  (n12[9:3]),
                           .inst_Func3  (n12[2:0]),
                           .operation   (n11)
                          );

assign n9 = n1 & n8;

endmodule