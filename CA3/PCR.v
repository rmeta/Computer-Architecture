module PCR(PC, nPC, write, clk, rst);
	output reg [31:0]PC;
	input [31:0]nPC;
	input write;
	input clk, rst;
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			PC <= 0;
		else if(~write)
			PC <= nPC;
	end
	
	always @(write)
	begin
		if(write)
			PC <= PC;
	end
endmodule