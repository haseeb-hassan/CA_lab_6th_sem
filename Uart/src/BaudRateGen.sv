module BaudRateGen(
    input  logic clk,
    input  logic rst,
    output logic baud_clk
);
    
    logic [2:0] counter; // Divide by 10

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            baud_clk <= 0;
        end 
        else begin
            if (counter == 3'h4) begin
                counter <= 0;
                baud_clk <= ~baud_clk;
            end 
            else begin
                counter <= counter + 1;
            end
        end
    end
endmodule