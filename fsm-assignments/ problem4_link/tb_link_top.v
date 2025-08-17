
`timescale 1ns/1ps
module tb_link_top;
  reg  clk, rst;
  wire done;

  link_top dut(.clk(clk), .rst(rst), .done(done));

  // Clock 100 MHz
  initial clk = 0;
  always #5 clk = ~clk;

  
  initial begin
    rst = 1;
    repeat (3) @(posedge clk);
    rst = 0;
  end

  
  wire        req  = dut.u_master.req;
  wire        ack  = dut.u_slave.ack;
  wire [7:0]  data = dut.u_master.data;

  integer n_bytes = 0;
  integer ack_hold = 0;
  reg ack_prev = 0;

  always @(posedge clk) begin
    if (ack) ack_hold = ack_hold + 1;
    else ack_hold = 0;

    ack_prev <= ack;
    if (ack_prev && !ack) begin
      n_bytes = n_bytes + 1;
      $display("[%0t] Byte %0d done, data=0x%0h (ack_hold=%0d)", $time, n_bytes, data, ack_hold);
    end
  end

  initial begin
    $dumpfile("link_wave.vcd");
    $dumpvars(0, tb_link_top);
    wait(done == 1'b1);
    @(posedge clk);
    $display("DONE pulse seen. Bytes transferred=%0d", n_bytes);
    $finish;
  end
endmodule
