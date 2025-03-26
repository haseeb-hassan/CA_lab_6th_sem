module FSM (
    input   logic clk, 
    input   logic rst,
    input   logic start,
    output  logic shift_en,
    output  logic read_en,
    output  logic en_D
);
logic [1:0] c_state, n_state;
parameter S0 = 1'b0, S1 = 1'b1;

always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        c_state <= S0;
    end
    else begin
        c_state <= n_state;
    end
end
always_comb begin
    case (c_state)
        S0: begin
            if (!start) begin
                n_state = S1;
            end
            else begin
                n_state = S0;
            end
        end 
        S1: begin
            if (start) begin
                n_state = S0;
            end
            else begin
                n_state = S1;
            end
        end 
        

    endcase
end
always_comb begin
    case(c_state) 
        S0: begin
            shift_en = 0;
            read_en = 0;
            en_D = 0;
           
        end
        S1: begin
            shift_en = 1;
            read_en = 1;
            en_D = 1;
        end
    endcase
end
endmodule