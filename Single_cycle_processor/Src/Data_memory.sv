module Data_memory (
    input [31:0] Add,         
    input [31:0] write_data,       
    input clock,               
    input reset,               
    input mem_write,            
    input mem_read,           
    output logic [31:0] read_data   
);

   
    logic [31:0] memory [0:511]; // 512 words of 32-bit (2KB)
initial begin
    $readmemh("C:/Users/HP/Downloads/CA_LABS_CODES/LAB2/data_memory_init.txt", memory);
end


 
    always_comb begin
        if (mem_read)  // If read is enabled
            read_data = memory[Add];  // Read data from memory at the address
    end


    always @(negedge clock or posedge reset) begin
        if (reset) begin
           
            for (int i = 0; i < 512; i++) begin
                memory[i] = $random;  
            end
        end
        else if (mem_write) begin
            memory[Add] <= write_data;
        end
    end
endmodule
