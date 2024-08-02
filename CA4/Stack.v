module Stack(Data_out, Data_in, POP, PUSH, TOS, clk, rst);
	output reg [7:0]Data_out;
	input [7:0]Data_in;
	input POP, PUSH, TOS;
	input clk, rst;
	
	//pointer always point to top of stack
	reg [4:0]pointer;
	reg [7:0]File[31:0];
	
	always @(posedge clk)
	begin
		if(PUSH)
			File[pointer] <= Data_in;
		else if(POP)
			Data_out <= File[pointer-1];
		else if(TOS)
			Data_out <= File[pointer-1];
		else
			Data_out <= Data_out;
	end
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			pointer <= 0;
		else if(PUSH)
			pointer <= pointer + 1;
		else if(POP)
			pointer <= pointer - 1;
		else
			pointer <= pointer;
	end
	
	always @(posedge clk)
	begin
		$write("Stack:\n%d %d %d %d \n%d %d %d %d \n%d %d %d %d \n%d %d %d %d \n%d %d %d %d \n%d %d %d %d \n%d %d %d %d \n%d %d %d %d \npointer=%d\n",
					File[0], File[1], File[2], File[3], File[4], File[5], File[6], File[7], File[8], File[9], File[10], File[11], File[12]
					, File[13], File[14], File[15], File[16], File[17], File[18], File[19], File[20], File[21], File[22], File[23], File[24]
					, File[25], File[26], File[27], File[28], File[29], File[30], File[31], pointer);
	end
endmodule