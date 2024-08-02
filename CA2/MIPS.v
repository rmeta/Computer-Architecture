module MIPS(clk,rst);
	input clk,rst;
	
	wire [2:0]ALUop;
	wire jr_ctrl, j_ctrl, jal_ctrl, RegWrite, MemWrite, branch, MemtoReg, ALUsrc, RegDst;
	wire [5:0]Inst, Funct;
	
	CU C(ALUop, jr_ctrl, j_ctrl, jal_ctrl, RegWrite, MemWrite, branch, MemtoReg, ALUsrc, RegDst, Inst, Funct);
	DP D(Inst, Funct, ALUop, jr_ctrl, j_ctrl, jal_ctrl, RegWrite, MemWrite, branch, MemtoReg, ALUsrc, RegDst, clk, rst);
endmodule