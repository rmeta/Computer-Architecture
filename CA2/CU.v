module CU(Cmd, Inst, Funct);
	output reg [16:0] Cmd;
	input [5:0]Inst, Funct;
	
	parameter [5:0] add = 6'b10_0000, sub = 6'b10_0010, slt = 6'b10_1010, jr = 6'b00_1000, addi = 6'b00_1000, slti = 6'b00_1010, lw = 6'b10_0011, sw = 6'b10_1011, 
					j = 6'b00_0010,  jal = 6'b00_0011, beq = 6'b00_0100, bne = 6'b00_0101, nop = 6'b11_0011;
	reg [2:0] ALUop;
	reg [1:0] RegDst, ALUsrc2;
	reg ALUsrc1, MemRead, MemWrite, RegWrite, MemtoReg, PCsrc, branch, jr_ctrl, j_ctrl, neq;
	
	assign Cmd = {ALUop, ALUsrc1, ALUsrc2, RegDst, MemRead, MemWrite, RegWrite, MemtoReg, PCsrc, branch, jr_ctrl, j_ctrl, neq};
	
	always @(Inst,Funct)
	begin
	if(Inst==6'b00_0000)
		case(Funct)
			add: Cmd = 17'b000_0_00_01_0_0_1_0_0_0_0_0_0;
			sub: Cmd = 17'b001_0_00_01_0_0_1_0_0_0_0_0_0;
			slt: Cmd = 17'b010_0_00_01_0_0_1_0_0_0_0_0_0;
			jr:  Cmd = 17'b000_0_00_00_0_0_0_0_1_0_1_1_0;
			default: Cmd = 17'b000_0_11_01_0_0_0_0_0_0_0_0_0;
		endcase
	else
		case(Inst)
			slti: Cmd = 17'b010_0_01_00_0_0_1_0_0_0_0_0_0;
			addi: Cmd = 17'b000_0_01_00_0_0_1_0_0_0_0_0_0;
			j: 	  Cmd = 17'b000_0_00_00_0_0_0_0_1_0_0_1_0;
			jal:  Cmd = 17'b000_1_10_10_0_0_1_0_1_0_0_1_0;
			beq:  Cmd = 17'b000_0_00_00_0_0_0_0_0_1_0_0_0;
			bne:  Cmd = 17'b000_0_00_00_0_0_0_0_0_1_0_0_1;
			lw:   Cmd = 17'b000_0_01_00_1_0_1_1_0_0_0_0_0;
			sw:   Cmd = 17'b000_0_01_00_0_1_0_0_0_0_0_0_0;
			nop:  Cmd = 17'b000_0_00_00_0_0_0_0_0_0_0_0_0;
			default: Cmd = 17'b000_0_11_00_0_0_0_0_0_0_0_0_0;
		endcase
	end
	
endmodule