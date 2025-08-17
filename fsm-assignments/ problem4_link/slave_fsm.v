

module slave_fsm(
  input  wire       clk,
  input  wire       rst,     
  input  wire       req,
  input  wire [7:0] data_in,
  output reg        ack,
  output reg [7:0]  last_byte
);

  reg [1:0] state;
  reg       req_d;
  reg [1:0] hold_cnt;

  localparam R_IDLE      = 2'd0,
             R_ACK_HOLD  = 2'd1,
             R_WAIT_REQ0 = 2'd2;

  wire req_rise = req & ~req_d;

  always @(posedge clk) begin
    if (rst) begin
      state     <= R_IDLE;
      req_d     <= 1'b0;
      ack       <= 1'b0;
      last_byte <= 8'h00;
      hold_cnt  <= 2'd0;
    end else begin
      req_d <= req;

      case (state)
        R_IDLE: begin
          if (req_rise) begin
            last_byte <= data_in;
            ack       <= 1'b1;
            hold_cnt  <= 2'd2;
            state     <= R_ACK_HOLD;
          end
        end

        R_ACK_HOLD: begin
          if (hold_cnt != 2'd0)
            hold_cnt <= hold_cnt - 2'd1;
          if (hold_cnt == 2'd1)
            state <= R_WAIT_REQ0;
        end

        R_WAIT_REQ0: begin
          if (!req) begin
            ack   <= 1'b0;
            state <= R_IDLE;
          end
        end
      endcase
    end
  end
endmodule
