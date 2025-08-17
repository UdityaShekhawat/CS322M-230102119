`timescale 1ns/1ps

module tb_traffic_light;

    reg clk, rst;
    reg tick;   
    integer cyc;

    
    wire ns_g, ns_y, ns_r;
    wire ew_g, ew_y, ew_r;

   
    traffic_light dut (
        .clk(clk),
        .rst(rst),
        .tick(tick),
        .ns_g(ns_g), .ns_y(ns_y), .ns_r(ns_r),
        .ew_g(ew_g), .ew_y(ew_y), .ew_r(ew_r)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;

    
    always @(posedge clk) begin
        cyc <= cyc + 1;
        tick <= (cyc % 20 == 0); 
    end

    
    initial begin
        cyc = 0;
        tick = 0;

   
        rst = 1;
        repeat (9) @(posedge clk);
        rst = 0;

        #(100)
        $finish;
    end

endmodule
