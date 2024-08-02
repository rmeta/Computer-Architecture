module PCR(PC, nPC, clk, rst);
	output reg [31:0]PC;
	input [31:0]nPC;
	input clk, rst;
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			PC <= 0;
		else
			PC <= nPC;
	end
endmodule