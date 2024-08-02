module DivDP(ASign,R,Q,Dividend,Divisor,ldAslc,ldBslc,ldAen,ldBen,ldCen,Signslc,Shiften,Adden,Res,clk,rst);
	parameter N = 6;
	output reg ASign;
	output reg [N-1:0]R, Q;
	input [(2*N)-1:0]Dividend;
	input [N-1:0]Divisor;
	input ldAslc, ldBslc;
	input ldAen, ldBen, ldCen;
	input Signslc, Shiften, Adden, Res;
	input clk, rst;

	wire [N:0]A, Sum, R1;
	wire [N-1:0]B, C, R2, Cp;

	MUX #(N+1) M1(R1, {1'b0,Dividend[(2*N)-1:N]}, Sum, ldAslc);
	MUX #(N) M2(R2, Dividend[N-1:0], {B[N-1:1],Res}, ldBslc);
	LSR #(N+1) AR(A, R1, B[N-1], Shiften, ldAen, clk, rst);
	LSR #(N) BR(B, R2, 1'b0, Shiften, ldBen, clk, rst);
	LSR #(N) CR(C, Divisor, 1'b0, 1'b0, ldCen, clk, rst);
	cmp1 #(N) CMP(Cp, C, Signslc);
	CPA #(N+1) Adder(Sum, , A, {Cp[N-1],Cp}, Signslc, Adden, clk, rst);
	
	assign ASign = A[N];
	assign R = A[N-1:0];
	assign Q = B[N-1:0];
	
endmodule