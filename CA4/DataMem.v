`timescale 1ns/1ns
module DataMem(Mem_out, Adr, Mem_in, Mem_write, Mem_read, clk, rst);
	output [7:0]Mem_out;
	input [7:0]Mem_in;
	input [4:0]Adr;
	input Mem_read, Mem_write;
	input clk, rst;
	
	reg [7:0]Mem[31:0];
	
	always @(posedge clk)
	begin
		if(Mem_write)
			Mem[Adr] <= Mem_in;
	end
	
	assign Mem_out = Mem_read ? Mem[Adr]:8'bzzzz_zzzz;
	
	always @(posedge clk)
	begin
		#1 $write("Data Memory[27]:\n%d\n", Mem[27]);
	end
	
	initial
	begin
		$readmemb("DM.b", Mem);
	end
endmodule