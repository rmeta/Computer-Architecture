module CU(ALUop, jr_ctrl, j_ctrl, jal_ctrl, RegWrite, MemWrite, branch, MemtoReg, ALUsrc, RegDst, Inst, Funct);
	output reg [2:0]ALUop;
	output reg jr_ctrl, j_ctrl, ALUsrc, MemtoReg, RegDst, RegWrite, MemWrite, jal_ctrl, branch;
	input [5:0]Inst, Funct;
	
	parameter [5:0]add = 6'b10_0000, sub = 6'b10_0010, slt = 6'b10_1010, jr = 6'b00_1000, addi = 6'b00_1000, slti = 6'b00_1010, lw = 6'b10_0011, sw = 6'b10_1011, 
					j = 6'b00_0010,  jal = 6'b00_0011, beq = 6'b00_0100, bne = 6'b00_0101;
	
	always @(Inst,Funct)
	begin
	if(Inst==6'b00_0000)
		case(Funct)
			add: {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_1_0_0_0_0_0_0_1_0;
			sub: {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b001_1_0_0_0_0_0_0_1_0;
			slt: {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b010_1_0_0_0_0_0_0_1_0;
			jr:  {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_0_0_0_0_0_1_0_0_0;
			default: {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_1_0_0_0_0_0_0_1_0;
		endcase
	else
		case(Inst)
			slti: {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b010_0_0_1_0_0_0_0_1_0;
			addi: {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_0_0_1_0_0_0_0_1_0;
			j: 	  {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_0_0_0_0_0_0_1_0_0;
			jal:  {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_0_1_0_0_0_0_1_1_0;
			beq:  {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b011_0_0_0_0_1_0_0_0_0;
			bne:  {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b100_0_0_0_0_1_0_0_0_0;
			lw:   {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_0_0_1_1_0_0_0_1_0;
			sw:   {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_0_0_1_0_0_0_0_0_1;
			default: {ALUop, RegDst, jal_ctrl, ALUsrc, MemtoReg, branch, jr_ctrl, j_ctrl, RegWrite, MemWrite} = 12'b000_0_0_1_0_0_0_0_1_0;
		endcase
	end
	
endmodule