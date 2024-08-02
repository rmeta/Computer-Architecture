module cmp1(Wout,Ain,ctrl);
	parameter N = 8;
	output reg [N-1:0]Wout;
	input [N-1:0]Ain;
	input ctrl;

	genvar i;
	generate
		for(i=0; i<N; i=i+1)
			assign Wout[i] = ctrl ^ Ain[i];
	endgenerate
endmodule