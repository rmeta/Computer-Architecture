module RegFile(RFout1, RFout2, RFread1, RFread2, RFwrite, DATAin, RegWrite, clk, rst);
	output [31:0]RFout1, RFout2;
	input [4:0]RFread1, RFread2, RFwrite;
	input [31:0]DATAin;
	input RegWrite, clk, rst;
	
	reg[31:0] RF[31:0];
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			RF[31] <= 0;
			RF[0] <= 0;
		end
		else if(RegWrite)
			RF[RFwrite] <= DATAin;
	end
	assign RFout1 = RF[RFread1];
	assign RFout2 = RF[RFread2];
endmodule