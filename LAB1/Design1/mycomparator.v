module mycomparator(
    input A,
    input B,
    output O1,
    output O2,
    output O3
);

assign O1= A&(~B);
assign O2= ~(A^B);
assign O3= B&(~A);
   



endmodule