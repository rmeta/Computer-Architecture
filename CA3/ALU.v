module ALU(Res, Zero, A, B, Func);
	output reg [31:0]Res;
	output reg Zero;
	input [31:0]A, B;
	input [2:0]Func;
	
	parameter [2:0]add = 3'b000, sub = 3'b001, slt = 3'b010, eql = 3'b011, neq = 3'b100;
	reg Cout;
	
	always @(A, B, Func)
	begin
		case(Func)
			add: {Cout, Res} = A + B;
			sub: {Cout, Res} = A - B;
			slt: {Cout, Res} = (A < B) ? 1:0;
			eql: {Cout, Res} = (A == B);
			neq: {Cout, Res} = (A != B);
			default: {Cout, Res} = A + B;
		endcase
	end
	assign Zero = ~(|{Cout, Res});
endmodule