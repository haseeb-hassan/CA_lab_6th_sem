module fwd_mux_a
(
    input  logic [31:0] rdata1,      
    input  logic [31:0] wdata,  
    input  logic        fwd_sela,          
    output logic [31:0] out
);

    always_comb begin
        case (fwd_sela)
            1'b0: out = rdata1; // No forwarding
            1'b1: out = wdata; // forwarding
            default: out = rdata1;
        endcase
    end

endmodule