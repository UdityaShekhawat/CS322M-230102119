module tick_divider #(
 parameter integer CLK_FREQ_HZ= 50_000_000,
 parameter integer TICK_HZ =1
 )(
 input wire clk,
 input wire rst, //syncactive-high
 output reg tick  //1-cycle pulse each1/TICK_HZ seconds
 );

 
    localparam integer TERMINAL = CLK_FREQ_HZ / TICK_HZ;
    localparam integer WIDTH    = $clog2(TERMINAL);

    reg [WIDTH-1:0] count;

always@(posedge clk) begin
     if (rst) begin
            count <= 0;
            tick <= 0;
     end
     else if (count == TERMINAL-1 ) begin
             count<= 0;
             tick<=1;
     end
     else begin
             count<= count +1;
             tick<=0;
     end

end

 endmodule