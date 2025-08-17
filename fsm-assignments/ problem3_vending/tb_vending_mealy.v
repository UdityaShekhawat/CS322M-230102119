module tb_vending_mealy;
    reg clk, rst;
    reg [1:0] coin;
    wire dispense, chg5;

    
    vending_mealy dut(.clk(clk), .rst(rst), .coin(coin),
                      .dispense(dispense), .chg5(chg5));

    
    always #5 clk = ~clk;

    initial begin
        // VCD Dump setup
        $dumpfile("vending_mealy.vcd");   
        $dumpvars(0, tb_vending_mealy);   

       
        clk = 0; rst = 1; coin = 2'b00;
        #11 rst = 0;

        
        #10 coin = 2'b01; #10 coin = 2'b00;
        #10 coin = 2'b01; #10 coin = 2'b00;
        #10 coin = 2'b10; #10 coin = 2'b00;

       
        #10 coin = 2'b10; #10 coin = 2'b00;
        #10 coin = 2'b01; #10 coin = 2'b00;
        #10 coin = 2'b10; #10 coin = 2'b00;

       
        #10 coin = 2'b10; #10 coin = 2'b00;
        #10 coin = 2'b01; #10 coin = 2'b00;
        #10 coin = 2'b01; #10 coin = 2'b00;

        #50 $finish;
    end
    initial begin
    $monitor("T=%0t | state=%b | coin=%b | dispense=%b | chg5=%b", 
              $time, dut.state, coin, dispense, chg5);
end

endmodule
