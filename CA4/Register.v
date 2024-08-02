module Register(Data_out, Data_in, ld, clk, rst);
	parameter N = 8;
	output reg [N-1:0]Data_out;
	input [N-1:0]Data_in;
	input ld;
	input clk, rst;
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			Data_out <= 0;
		else if(ld)
			Data_out <= Data_in;
		else
			Data_out <= Data_out;
	end
endmodule