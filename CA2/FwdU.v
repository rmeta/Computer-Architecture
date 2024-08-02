module FwdU(Aslc, Bslc, RDst1, RDst2, WB1, WB2, Rs, Rt);
	output reg [1:0] Aslc, Bslc;
	input WB1, WB2;
	input [4:0] RDst1, RDst2, Rs, Rt;
	
	assign Aslc = WB1&(Rs == RDst1) ? 2'b01: WB2&(Rs == RDst2) ? 2'b10: 2'b00;
	assign Bslc = WB1&(Rt == RDst1) ? 2'b01: WB2&(Rt == RDst2) ? 2'b10: 2'b00;
endmodule