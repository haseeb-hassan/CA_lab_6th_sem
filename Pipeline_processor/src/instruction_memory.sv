module inst_mem
(
    input  logic [31:0] addr,
    output logic [31:0] data
);

    logic [31:0] mem [100];

    always_comb
    begin
        // doing right shift as pc is adding 4, to make it +1 as we want to do word addresable memory access
        data=mem[addr[31:2]];
    end

endmodule
