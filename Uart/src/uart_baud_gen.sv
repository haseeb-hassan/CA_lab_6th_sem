module uart_baud_gen (
    input logic clk,          
    input logic rst,          
    input logic [15:0] baud_div, 
    output logic baud_clk_16 
);
    logic [15:0] counter;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            counter <= 0;
        else if (counter == baud_div) begin
            counter <= 0;
            baud_clk_16 <= ~baud_clk_16;
        end else
            counter <= counter + 1;
    end
endmodule