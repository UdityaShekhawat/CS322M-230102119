 module traffic_light(
 input wire clk,
 input wire rst, //syncactive-high
 input wire tick, //1-cycle per-secondpulse
 output reg ns_g,ns_y,ns_r,
 output reg ew_g,ew_y,ew_r
 );
    
     
      parameter   S0 = 2'b00;  // NS Green, EW Red
      parameter   S1 = 2'b01;  // NS Yellow, EW Red
      parameter   S2 = 2'b10;  // NS Red, EW Green
      parameter   S3 = 2'b11;  // NS Red, EW Yellow
      
      parameter delay5 = 3'd5;
      parameter delay2 = 3'd2;
      

    reg [1:0] state, next_state;
    reg [2:0] tick_count; 

    reg [2:0]delay;

    
    always @(posedge clk) begin
        if (rst) begin
            state <= S0;
            tick_count<=0;
            

        end else if(tick) begin
        
           if(tick_count == delay-1)begin 
                state<=next_state;
                tick_count<=0;
                end
            else begin
                tick_count <= tick_count + 1;
            end
        end
    end
        

    // Next state logic
    always @(*) begin
        case (state)
            S0: begin next_state = S1; delay=delay5; end
            S1: begin next_state = S2; delay=delay2; end
            S2: begin  next_state = S3; delay=delay5;end
            S3: begin next_state = S0; delay=delay2;end
            default: next_state = S0;
        endcase
    end

    // Output logic 
    always @(*) begin
    
        ns_g=0; ns_y=0; ns_r=0;
        ew_g=0; ew_y=0; ew_r=0;
        case(state)
            S0: begin ns_g=1; ew_r=1; end
            S1: begin ns_y=1; ew_r=1; end
            S2: begin ns_r=1; ew_g=1; end
            S3: begin ns_r=1; ew_y=1; end
        endcase
    end

endmodule

