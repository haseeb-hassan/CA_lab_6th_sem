module tb_UartReceiver;
    logic clk;
    logic rst;
    logic rx;
    logic start;
    logic [8:0] data_out;
    logic clk_div;
    

    UartReceiver uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .start(start),
        .data_out(data_out)
    );
    BaudRateGen dut(
        .clk(clk),
        .rst(rst),
        .baud_clk(clk_div)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        
        rst = 1;
        #5 rst = 0; start = 1;
        @(posedge clk);
        #5 start = 0; 
        @(posedge clk_div);
        rx = 1;
        @(posedge clk_div);
        rx = 1;
        @(posedge clk_div);
        rx = 1;
        @(posedge clk_div);
        rx = 1;
        @(posedge clk_div);
        rx = 0;
        @(posedge clk_div);
        rx= 0;
        @(posedge clk_div);
        rx = 0;
        @(posedge clk_div);
        rx = 0;
        @(posedge clk_div);
        
        repeat (10) @(posedge clk_div);
        $finish;
    end

    
endmodule