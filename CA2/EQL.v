module EQL(Res, A, B, neq);
	output reg Res;
	input [31:0] A, B;
	input neq;
	
	assign Res = neq ? (A != B): (A ==B);
endmodule