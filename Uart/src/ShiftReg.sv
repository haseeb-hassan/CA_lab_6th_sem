module ShiftReg(
    input  logic clk,       
    input  logic rst,       
    input  logic shift_en,  
    input  logic rx,     
    output logic en,  
    output logic [7:0] data_out
);
    logic [2:0] count = 0;
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= 8'h0; 
            
        end 
        
        
        else begin
            if (count == 7) begin
                en = 1;
            end
            else begin
                en = 0;
            end
            if (shift_en) begin
            data_out <= {rx, data_out[7:1]};
            count <= count + 1;
        end
        
        end
    end
    
endmodule