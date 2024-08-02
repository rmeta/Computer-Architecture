module Adder(Sum, Cout, A, B, Cin);
	parameter N = 8;
	output [N-1:0]Sum;
	output Cout;
	input [N-1:0]A, B;
	input Cin;
	
	assign {Cout, Sum} = A + B + Cin;
	
endmodule