module Pipe_MIPS(clk, rst);
	input clk, rst;
	
	wire [16:0] Cmd;
	wire [5:0] Inst, Funct;
	
	DP DPB(Inst, Funct, Cmd, clk, rst);
	CU CUBCU(Cmd, Inst, Funct);
endmodule