module MidReg(D_out, D_in, InEfctCmd, Flush, clk, rst);
	parameter N = 64;
	output reg [N-1:0]D_out;
	input [N-1:0]D_in, InEfctCmd;
	input Flush;
	input clk, rst;
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			D_out <= InEfctCmd;
		else if(~Flush)
			D_out <= D_in;
	end
	
	always @(Flush)
	begin
		if(Flush)
			D_out <= InEfctCmd;
	end
endmodule