module SBMIPS_DP(Inst, PCsrc, PCwrite, PCwriteCond, IorD, MemRead, MemWrite, Ild, 
					Ssrc, Push, Pop, Tos, Bld, ALUsrc1, ALUsrc2, ALUop, clk, rst);
	output [7:0] Inst;
	input PCsrc, PCwrite, PCwriteCond, IorD, MemRead, MemWrite, 
					Ild, Ssrc, Push, Pop, Tos, Bld, ALUsrc1;
	input [1:0] ALUsrc2, ALUop;
	input clk, rst;
	
	wire [4:0] PC, PC_in, Adr;
	wire [7:0] Data_in, Data_out, src1, src2, B_out, ALU_out, Mem_out;
	wire PCld, zero;
	
	Stack stck(Data_out, Data_in, Pop, Push, Tos, clk, rst);
	
	Register I(Inst, Mem_out, Ild, clk, rst);
	
	MUX M1(Data_in, ALU_out, Mem_out, Ssrc);
	
	DataMem dm(Mem_out, Adr, Data_out, MemWrite, MemRead, clk, rst);
	
	MUX M2(src1, {3'b000,PC}, Data_out, ALUsrc1);
	
	Register B(B_out, Data_out, Bld, clk, rst);
	
	MUX4 M3(src2, B_out, 8'b0000_0000, 8'b0000_0001, Data_out, ALUsrc2);
	
	ALU AL_U(ALU_out, zero, src1, src2, ALUop);
	
	MUX #(5) M4(PC_in, ALU_out[4:0], Inst[4:0], PCsrc);
	
	Register #(5) PCR(PC, PC_in, PCld, clk, rst);
	
	MUX #(5) M5(Adr, PC, Inst[4:0], IorD);
	
	assign PCld = PCwrite | (zero & PCwriteCond);
endmodule