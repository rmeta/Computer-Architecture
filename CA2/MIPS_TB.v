`timescale 1ns/1ns
module MIPS_TB();
	reg clk = 1'b0, rst = 1'b0;
	
	MIPS M(clk,rst);
	
	always #10 clk = ~clk;
	
	initial
	begin
	rst = 1'b1;
	#5 rst = 1'b0;
	#1100 $stop;
	end
endmodule