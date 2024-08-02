module MUX(W_out, A, B, S);
	parameter N = 8;
	output [N-1:0]W_out;
	input [N-1:0]A, B;
	input S;
	
	assign W_out = S ? B:A;
endmodule