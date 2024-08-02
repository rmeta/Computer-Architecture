module Adder(Sum, C_out, A, B, C_in);
	output [7:0]Sum;
	output C_out;
	input [7:0]A, B;
	input C_in;
	
	assign {C_out, Sum} = A + B +C_in;
endmodule