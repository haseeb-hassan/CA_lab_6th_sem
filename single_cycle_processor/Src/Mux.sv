module Mux (
    output var logic unsigned [31:0] out,
    input  var logic unsigned [31:0] in1,
    input  var logic unsigned [31:0] in2,
    input  var logic unsigned        MemtoReg
);

    always_comb begin

        case(MemtoReg)
            1'b0 : out = in1;
            1'b1 : out = in2;
        endcase
    end

endmodule