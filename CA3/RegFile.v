module RegFile(RFout1, RFout2, RFread1, RFread2, RFwrite, DATAin, RegWrite, clk, rst);
	output [31:0]RFout1, RFout2;
	input [4:0]RFread1, RFread2, RFwrite;
	input [31:0]DATAin;
	input RegWrite, clk, rst;
	
	reg[31:0] RF[31:0];
	
	integer i;
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			for(i=0; i<32; i=i+1)
				RF[i] = 32'b0;
		end
		else if(RegWrite)
			RF[RFwrite] <= DATAin;
	end
	assign RFout1 = RF[RFread1];
	assign RFout2 = RF[RFread2];
	
	always @(posedge clk)
	begin
		$write("RegFile: %d %d %d %d %d %d\n",RF[0],RF[1],RF[2],RF[3],RF[4],RF[31]);
	end
endmodule