module SE(W, A);
	parameter N = 16;
	output [(2*N)-1:0]W;
	input [N-1:0]A;
	
	assign W[N-1:0] = A;
	
	genvar i;
	generate
		for(i=N; i<(2*N); i=i+1)
			assign W[i] = A[N-1];
	endgenerate
endmodule