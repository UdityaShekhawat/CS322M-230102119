`timescale 1ns/1ns
`include "mycomparator.v"

module mycomparator_tb;
reg a,b;
wire o1,o2,o3;

mycomparator DUT_comparator(
    .A(a),
    .B(b),
    .O1(o1),
    .O2(o2),
    .O3(o3)

);

initial 
begin
    $dumpfile("mycomparator_tb.vcd");
    $dumpvars (0,mycomparator_tb);

       a=0;b=0;
       #10
       a=0;b=1;
       #10
       a=1;b=0;
       #10
       a=1;b=1;
       #10

    $finish;

end


endmodule