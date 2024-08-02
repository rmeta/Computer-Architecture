module DP(Insto, Funct, ALUop, jr_ctrl, j_ctrl, jal_ctrl, RegWrite, MemWrite, branch, MemtoReg, ALUsrc, RegDst, clk, rst);
	output [5:0]Insto, Funct;
	input [2:0]ALUop;
	input jr_ctrl, j_ctrl, jal_ctrl, RegWrite, MemWrite, branch, MemtoReg, ALUsrc, RegDst;
	input clk, rst;
	
	wire [31:0]Inst, PCp4, pPC, nPC, RFout2, DATAin, SEC, SL2, PCb, Res, Memout;
	wire [31:0]A, B, W1, W2, W3;
	wire [4:0]W4, RFwrite;
	wire zero, PCsrc;
	
	assign PCsrc = branch & zero;
	assign Insto = Inst[31:26];
	assign Funct = Inst[5:0];
	
	PCR PC(pPC, nPC, clk, rst);
	//j ctrl
	MUX #(32) M1(nPC, W2, {pPC[31:26],Inst[25:0]}, j_ctrl);
	//jr ctrl
	MUX #(32) M2(W2, W1, A, jr_ctrl);
	//branch ctrl
	MUX #(32) M3(W1, PCp4, PCb, PCsrc);
	
	SE SEM(SEC, Inst[15:0]);
	SHL2 SL(SL2, SEC);
	
	//PC+4
	Adder #(32) Add1(PCp4, , 4, pPC, 1'b0);
	//PC+4+(4*branchAdr)
	Adder #(32) Add2(PCb, , PCp4, SL2, 1'b0);
	
	//InstMem with pPC(present PC) input and Inst output
	InstMem IM(Inst, pPC, clk);
	
	//RegFile  
	RegFile RF(A, RFout2, Inst[25:21], Inst[20:16], RFwrite, DATAin, RegWrite, clk, rst);
	//ctrl jal
	MUX #(32) M4(DATAin, W3, PCp4, jal_ctrl);
	//ctrl mem
	MUX #(32) M5(W3, Res, Memout, MemtoReg);
	//ctrl jal
	MUX #(5) M6(RFwrite, W4, 5'b11111, jal_ctrl);
	//ctrl wr
	MUX #(5) M7(W4, Inst[20:16], Inst[15:11], RegDst);
	
	ALU AU(Res, zero, A, B, ALUop);
	MUX #(32) M(B, RFout2, SEC, ALUsrc);
	
	DataMem DM(Memout, Res, RFout2, MemWrite, clk);
endmodule