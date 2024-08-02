`timescale 1ns/1ns
module DataMem(Memout, Address, DATAin, MemRead, MemWrite, clk, rst);
	output [31:0]Memout;
	input [31:0]Address, DATAin;
	input MemWrite, MemRead;
	input clk, rst;
	
	reg[31:0] Mem[65535:0];
	
	always @(posedge clk)
	begin
		if(MemWrite)
			Mem[Address[31:2]] <= DATAin;
	end
	assign Memout = MemRead ? Mem[Address[31:2]]: 32'bz;
	
	always @(posedge clk)
	begin
		#1 $write("Data Memory:  2000 = %d\n\t\t2004 = %d\n\t\t2008 = %d\n\t\t2012 = %d\n",Mem[500],Mem[501],Mem[502],Mem[503]);
	end
	
	initial 
	begin
		$readmemh("DM.hex", Mem);
	end
endmodule