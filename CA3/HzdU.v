module HzdU(Flush, Rep, RDst, Rs, Rt, MemRead, PCslc);
	output reg Flush, Rep;
	input MemRead, PCslc;
	input [4:0] RDst, Rs, Rt;
	
	assign Flush = PCslc ? 1'b1: MemRead&(RDst == Rs) ? 1'b1: MemRead&(RDst == Rt) ? 1'b1: 1'b0;
	assign Rep = PCslc ? 1'b1: MemRead&(RDst == Rs) ? 1'b1: MemRead&(RDst == Rt) ? 1'b1: 1'b0;
endmodule