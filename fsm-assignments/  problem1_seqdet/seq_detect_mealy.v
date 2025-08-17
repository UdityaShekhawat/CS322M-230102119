module seq_detect_mealy (
 input wire clk,
 input wire rst, //syncactive-high
 input wire din, //serialinputbitperclock
 output wire y //1-cyclepulsewhenpattern...1101seen
 );
   
    localparam S0   = 2'b00,
               S1   = 2'b01,
               S2   = 2'b10,
               S3   = 2'b11;

    reg [1:0] state, next_state;

    // next-state 
    always @(*) begin
        
        case (state)
            S0: begin
                if (din)     next_state = S1;
                else         next_state = S0;
            end
            S1: begin
                if (din)     next_state = S2;
                else         next_state = S0;
            end
            S2: begin
                if (din)     next_state = S2; 
                else         next_state = S3;
            end
            S3: begin
                if (din)     next_state = S1;  
                else         next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    
    always @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

   
    assign y = (state == S3) & din;

endmodule
