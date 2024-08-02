module MUX4(W_out, A, B, C, D, S);
	parameter N = 8;
	output [N-1:0]W_out;
	input [N-1:0]A, B, C, D;
	input [1:0]S;
	
	assign W_out = (S==2'b00) ? A: (S==2'b01) ? B: (S==2'b10) ? C: D;
endmodule