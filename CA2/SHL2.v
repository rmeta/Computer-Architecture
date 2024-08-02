module SHL2(W,A);
	parameter N = 32;
	output [N-1:0]W;
	input [N-1:0]A;
	
	assign W = {A[N-3:0],2'b00};
endmodule