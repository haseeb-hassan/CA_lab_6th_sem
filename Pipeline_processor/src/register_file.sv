module reg_file
(
    input  logic clk,
    input  logic reg_wr,
    input  logic [4:0]  raddr1,
    input  logic [4:0]  raddr2,
    input  logic [4:0]  waddr,
    input  logic [31:0] wdata,
    output logic [31:0] rdata1,
    output logic [31:0] rdata2
);
    logic [31:0] reg_mem [32];

    //asynchronous read
    always_comb
    begin
        rdata1 = reg_mem[raddr1];
        rdata2 = reg_mem[raddr2];
    end

    //synchronous write
    always_ff @(posedge clk)
    begin
        if(reg_wr)
        begin
            reg_mem[waddr] <= wdata;
        end
    end

endmodule
