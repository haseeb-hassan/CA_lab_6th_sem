module fwd_mux_b
(
    input  logic [31:0] rdata2,      
    input  logic [31:0] wdata,  
    input  logic        fwd_selb,          
    output logic [31:0] out
);

    always_comb begin
        case (fwd_selb)
            1'b0: out = rdata2; // No forwarding
            1'b1: out = wdata; // forwarding
            default: out = rdata2;
        endcase
    end
    
endmodule