module uart_tx_fsm (
    input logic clk,         // Clock signal
    input logic rst,         // Reset signal
    input logic FIFO_empty,  // FIFO empty flag
    input logic FIFO_full,   // FIFO full flag
    output logic write_en,   // Write enable signal for FIFO
    output logic read_en,    // Read enable signal for FIFO
    output logic load        // Load signal for Shift Register
);
    // Define states using enum
    typedef enum logic [1:0] {RESET, X, Y} state_t;
    state_t state, next_state;

    // Register for delayed read_en
    logic read_en_delayed;

    // State transition logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= RESET;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        // Default values
        write_en = 1'b0;
        read_en = 1'b1;
        next_state = state;

        case (state)
            RESET: begin
                if (!FIFO_empty && !FIFO_full)
                    next_state = X;
            end
            X: begin
                write_en = 1'b1;
                read_en = 1'b1; // Read from FIFO
                next_state = (FIFO_full) ? Y : X;
            end
            Y: begin
                write_en = 1'b1;
                read_en = 1'b0; // Stop reading
                if (!FIFO_full)
                    next_state = X;
            end
        endcase
    end

    // Generate delayed read_en for load signal
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            read_en_delayed <= 1'b0;
        else
            read_en_delayed <= read_en;
    end

    // Assign load = read_en delayed by 1 cycle
    assign load = read_en_delayed;

endmodule