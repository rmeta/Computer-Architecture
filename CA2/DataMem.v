`timescale 1ns/1ns
module DataMem(Memout, Address, DATAin, MemWrite, clk);
	output [31:0]Memout;
	input [31:0]Address, DATAin;
	input MemWrite, clk;
	
	reg[31:0] Mem[65535:0];
	
	always @(posedge clk)
	begin
		if(MemWrite)
			Mem[Address[31:2]] <= DATAin;
	end
	assign Memout = Mem[Address[31:2]];
	
	always #20
		$monitor("2000 = %d\n2004 = %d\n2008 = %d\n2012 = %d\n",Mem[500],Mem[501],Mem[502],Mem[503]);

	initial 
	begin
		$readmemh("DM.hex", Mem);
	end
endmodule