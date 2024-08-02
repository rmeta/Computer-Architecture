module ALU(Res, zero, A, B, ALUop);
	output reg [7:0]Res;
	output reg zero;
	input [7:0]A, B;
	input [1:0]ALUop;
	
	parameter ADD = 2'b00, SUB = 2'b01, AND = 2'b10, NOT = 2'b11;
	
	always @(A, B, ALUop)
	begin
		case(ALUop)
			ADD: Res = A + B;
			SUB: Res = A - B;
			AND: Res = A & B;
			NOT: Res = ~A;
		endcase
		zero = &(~Res);
	end
endmodule