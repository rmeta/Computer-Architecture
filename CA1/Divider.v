module Divider(Ready,R,Q,Start,Dividend,Divisor,clk,rst);
	parameter N = 6;
	output [N-1:0]R,Q;
	output Ready;
	input [(2*N)-1:0]Dividend;
	input [N-1:0]Divisor;
	input Start;
	input clk, rst;
	
	wire ASign,ldAslc,ldBslc,ldAen,ldBen,ldCen,Signslc,Shiften,Adden,Res;
	
	DivDP #(N) DP(ASign,R,Q,Dividend,Divisor,ldAslc,ldBslc,ldAen,ldBen,ldCen,Signslc,Shiften,Adden,Res,clk,rst);
	DivCU #(N) CU(Ready,ldAslc,ldBslc,ldAen,ldBen,ldCen,Shiften,Signslc,Adden,Res,Start,ASign,clk,rst);
	
endmodule