
module master_fsm(
  input  wire       clk,
  input  wire       rst,     
  input  wire       ack,
  output reg        req,
  output reg  [7:0] data,
  output reg        done
);

  // State encoding 
  reg [2:0] state;
  reg [1:0] byte_idx;

  localparam S_IDLE      = 3'd0,
             S_REQ       = 3'd1,
             S_WAIT_ACK  = 3'd2,
             S_DROP_REQ  = 3'd3,
             S_WAIT_ACK0 = 3'd4,
             S_DONE      = 3'd5;

  always @(posedge clk) begin
    if (rst) begin
      state    <= S_IDLE;
      req      <= 1'b0;
      data     <= 8'h00;
      done     <= 1'b0;
      byte_idx <= 2'd0;
    end else begin
      done <= 1'b0;  
      case (state)
        S_IDLE: begin
          data  <= 8'hA0;  
          req   <= 1'b1;
          state <= S_REQ;
        end

        S_REQ: begin
          state <= S_WAIT_ACK;
        end

        S_WAIT_ACK: begin
          if (ack) begin
            req   <= 1'b0;
            state <= S_DROP_REQ;
          end
        end

        S_DROP_REQ: begin
          state <= S_WAIT_ACK0;
        end

        S_WAIT_ACK0: begin
          if (!ack) begin
            if (byte_idx == 2'd3) begin
              done  <= 1'b1;  
              state <= S_DONE;
            end else begin
              byte_idx <= byte_idx + 2'd1;
              data     <= 8'hA0 + {6'd0, byte_idx + 2'd1};
              req      <= 1'b1;
              state    <= S_REQ;
            end
          end
        end

        S_DONE: begin
          state <= S_DONE; 
        end
      endcase
    end
  end
endmodule





 