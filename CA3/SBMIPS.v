module SBMIPS(clk, rst);
	input clk, rst;
	
	wire PCsrc, PCwrite, PCwriteCond, IorD, MemRead, MemWrite, Ild, 
					Ssrc, Push, Pop, Tos, Bld, ALUsrc1;
	wire [1:0] ALUsrc2, ALUop;
	wire [7:0] Inst;
	
	SBMIPS_DP DP(Inst, PCsrc, PCwrite, PCwriteCond, IorD, MemRead, MemWrite, Ild, 
					Ssrc, Push, Pop, Tos, Bld, ALUsrc1, ALUsrc2, ALUop, clk, rst);
	
	SBMIPS_CU CU(PCsrc, PCwrite, PCwriteCond, IorD, MemRead, MemWrite, Ild, Ssrc, 
						Push, Pop, Tos, Bld, ALUsrc1, ALUsrc2, ALUop, Inst[7:5], clk, rst);
endmodule