module ErrorHandler (
    input  logic clk,
    input  logic rst,        
    input  logic fifo_full,        // FIFO overflow condition
    output logic overrun_error    // FIFO overflow
);
 
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            
            overrun_error <= 0;
        end 
        else if (fifo_full) begin
            overrun_error <= fifo_full;           // FIFO was full when data arrived
        end
    end
endmodule