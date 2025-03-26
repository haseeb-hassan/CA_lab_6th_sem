module controller_buffer2
(
    input  logic        clk,
    input  logic        rst,

    input logic rd_en,   
    input logic wr_en,   
    input logic [1:0] wb_sel,
    input logic reg_wr,
    
    output logic rd_en1,   
    output logic wr_en1,   
    output logic [1:0] wb_sel1,
    output logic reg_wr1
    );
    always_ff @(posedge clk or posedge rst)
    begin
        if (rst) begin
            rd_en1 <= 0;
            wr_en1 <= 0;
            reg_wr1 <= 0;
           
        end else begin
            rd_en1 <= rd_en;         
            wr_en1 <= wr_en;
            reg_wr1 <= reg_wr;
            wb_sel1 <= wb_sel;
        end 
    end
endmodule