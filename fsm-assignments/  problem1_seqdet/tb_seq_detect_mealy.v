module tb_seq_detect_mealy;
reg clk,rst,din;
wire y;

 seq_detect_mealy dut(.clk(clk),
                      .rst(rst),
                      .din(din),
                       .y(y));

reg [15:0] sequence = 16'b1101101101011001; 
integer i;


initial clk = 0;
    always #5 clk = ~clk;
 
initial begin
       
$dumpfile("dump.vcd");
$dumpvars(0, tb_seq_detect_mealy);

    
    rst = 1; din = 0;
    @(posedge clk);
    rst = 0;

    
    for (i = 15; i >= 0; i = i - 1) begin
            din = sequence[i];
            @(posedge clk);
    end

$finish;
end


initial begin
        $display("time   clk din y");
        $monitor("%4t   %b   %b   %b", $time, clk, din, y);
    end
endmodule



