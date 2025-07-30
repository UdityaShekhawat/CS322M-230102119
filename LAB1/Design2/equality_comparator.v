module equality_comparator(
input [3:0] A,
input [3:0] B,
output O

);

wire [3:0] temp;

assign temp = ~(A ^ B);   
assign O = &temp;     

endmodule

