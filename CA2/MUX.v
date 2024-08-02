module MUX(W,A,B,S);
	parameter N = 32;
	output [N-1:0]W;
	input [N-1:0]A,B;
	input S;
	
	assign W = S ? B:A;
endmodule