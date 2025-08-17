module vending_mealy(
    input wire clk,
    input wire rst,        // synchronous active-high
    input wire [1:0] coin, // 01=5, 10=10, 00=idle
    output reg dispense,   // 1-cycle pulse
    output reg chg5        // 1-cycle pulse when returning 5
);

    // State encoding using parameters
    parameter S0  = 2'b00;  // total = 0
    parameter S5  = 2'b01;  // total = 5
    parameter S10 = 2'b10;  // total = 10
    parameter S15 = 2'b11;  // total = 15

    reg [1:0] state, next_state;
    reg [1:0] coin_d;   

    wire coin_edge = (coin != 2'b00) && (coin_d == 2'b00);

    
    always @(*) begin
        
        dispense = 0;
        chg5 = 0;
        next_state = state;

        case (state)
            S0: begin
                if (coin_edge && coin == 2'b01) next_state = S5;
                else if (coin_edge && coin == 2'b10) next_state = S10;
            end

            S5: begin
                if (coin_edge && coin == 2'b01) next_state = S10;
                else if (coin_edge && coin == 2'b10) next_state = S15;
            end

            S10: begin
                if (coin_edge && coin == 2'b01) next_state = S15;
                else if (coin_edge && coin == 2'b10) begin
                    dispense = 1;
                    next_state = S0;
                end
            end

            S15: begin
                if (coin_edge && coin == 2'b01) begin
                    dispense = 1;
                    next_state = S0;
                end else if (coin_edge && coin == 2'b10) begin
                    dispense = 1;
                    chg5 = 1;
                    next_state = S0;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            state  <= S0;
            coin_d <= 2'b00;
        end else begin
            state  <= next_state;
            coin_d <= coin;   
        end
    end


endmodule
