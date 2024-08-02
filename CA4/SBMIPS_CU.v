module SBMIPS_CU(PCsrc, PCwrite, PCwriteCond, IorD, MemRead, MemWrite, Ild, Ssrc, 
						Push, Pop, Tos, Bld, ALUsrc1, ALUsrc2, ALUop, Inst, clk, rst);
	output reg PCsrc, PCwrite, PCwriteCond, IorD, MemRead, MemWrite, 
					Ild, Ssrc, Push, Pop, Tos, Bld, ALUsrc1;
	output reg [1:0] ALUsrc2, ALUop;
	input [2:0] Inst;
	input clk, rst;
	
	parameter [2:0] JMP = 3'b111, JZ = 3'b110, PUSH = 3'b100, POP = 3'b101,
					NOT = 3'b011, ADD = 3'b000, SUB = 3'b001, AND = 3'b010;
					
	parameter [3:0] IF = 4'b0000, ID = 4'b0001, JMP1 = 4'b0010, JZ1 = 4'b0011, JZ2 = 4'b0100,
					NOT1 = 4'b0101, NOT2 = 4'b0110, POP1 = 4'b0111, POP2 = 4'b1000,
					PUSH1 = 4'b1001, AL1 = 4'b1010, AL2 = 4'b1011, PUSH_SUM = 4'b1100,
					PUSH_SUB = 4'b1101, PUSH_AND = 4'b1110;
	reg [3:0] ps, ns;
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			ps <= IF;
		else
			ps <= ns;
	end
	
	always @(ps)
	begin
		case(ps)
			IF: ns = ID;
			ID: ns = (Inst == JMP) ? JMP1: (Inst == JZ) ? JZ1:
						(Inst == POP) ? POP1: (Inst == PUSH) ? PUSH1:
						(Inst == NOT) ? NOT1: AL1;
			JMP1: ns = IF;
			JZ1: ns = JZ2;
			JZ2: ns = IF;
			NOT1: ns = NOT2;
			NOT2: ns = IF;
			POP1: ns = POP2;
			POP2: ns = IF;
			PUSH1: ns = IF;
			AL1: ns = AL2;
			AL2: ns = (Inst == ADD) ? PUSH_SUM: (Inst == SUB) ? PUSH_SUB: PUSH_AND;
			PUSH_SUM: ns = IF;
			PUSH_SUB: ns = IF;
			PUSH_AND: ns = IF;
			default: ns = IF;
		endcase
	end
	
	always @(ps)
	begin
		PCsrc = (ps == JMP1) ? 1'b1: (ps == JZ1) ? 1'b1: 1'b0;
		PCwrite = (ps == IF) ? 1'b1: (ps == JMP1) ? 1'b1: 1'b0;
		PCwriteCond = (ps == JZ2) ? 1'b1: 1'b0;
		IorD = (ps == POP2) ? 1'b1: (ps == PUSH1) ? 1'b1: 1'b0;
		MemRead = (ps == IF) ? 1'b1: (ps == PUSH1) ? 1'b1: 1'b0;
		MemWrite = (ps == POP2) ? 1'b1: 1'b0;
		Ild = (ps == IF) ? 1'b1: 1'b0;
		Ssrc = (ps == PUSH1) ? 1'b1: 1'b0;
		Push = (ps == PUSH1) ? 1'b1: (ps == NOT2) ? 1'b1: (ps == PUSH_AND) ? 1'b1:
							(ps == PUSH_SUB) ? 1'b1: (ps == PUSH_SUM) ? 1'b1: 1'b0;
		Pop = (ps == POP1) ? 1'b1: (ps == AL1) ? 1'b1: (ps == AL2) ? 1'b1: 1'b0;
		Tos = (ps == JZ1) ? 1'b1: 1'b0;
		Bld = (ps == AL2) ? 1'b1: 1'b0;
		ALUsrc1 = (ps == JZ2) ? 1'b1: (ps == NOT2) ? 1'b1: (ps == PUSH_AND) ? 1'b1: 
							(ps == PUSH_SUB) ? 1'b1: (ps == PUSH_SUM) ? 1'b1: 1'b0;
		ALUsrc2 = (ps == IF) ? 2'b10: (ps == JZ2) ? 2'b01: 2'b00;
		ALUop = (ps == NOT2) ? 2'b11: (ps == PUSH_SUB) ? 2'b01: (ps == AND) ? 2'b10: 2'b00;
	end
endmodule