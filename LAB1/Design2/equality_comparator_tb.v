`timescale 1ns/1ns
`include "equality_comparator.v"

module equality_comparator_tb;

    reg [3:0] a, b;
    wire o;

    equality_comparator comp (
        .A(a),
        .B(b),
        .O(o)
    );
    integer i,j;
    initial 
    begin
        $dumpfile("equality_comparator.vcd");
        $dumpvars(0, equality_comparator_tb);

      /*  A = 4'b0000; B = 4'b0000; 
        #10;

        A = 4'b0001; B = 4'b0000; 
        #10;

        A = 4'b1010; B = 4'b1010;
        #10;

        A = 4'b1111; B = 4'b0000; 
        #10;

        A = 4'b1100; B = 4'b1001; 
        #10;

        A = 4'b0110; B = 4'b0110; 
        #10;*/

            for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a= i[3:0];
                b = j[3:0];
                #10;

            end
            end

        $finish;
    end
endmodule
