module top(
  input wire clk,
  input wire rst,
output wire ; ns_g,ns_y,ns_r,
output wire ew_g,ew_y,ew_r
)


//Top-level(examplewiring)
 wire tick_1hz;

 tick_divider #(.CLK_FREQ_HZ(50_000_000),.TICK_HZ(1))u_div(
 .clk(clk),.rst(rst), .tick(tick_1hz)
 );
 traffic_light u_tl (
 .clk(clk),.rst(rst), .tick(tick_1hz)
, .ns_g(ns_g),.ns_y(ns_y),.ns_r(ns_r),.ew_g(ew_g),.ew_y(ew_y),.ew_r(ew_r)

 );





endmodule