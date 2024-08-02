`timescale 1ns/1ns
module Pipe_MIPS_TB();
	reg clk = 1'b0, rst = 1'b0;
	
	Pipe_MIPS P(clk, rst);
	
	always #10 clk = ~clk;
	
	initial
	begin
	rst = 1'b1;
	#10 rst = 1'b0;
	
	#2500 $stop;
	end
endmodule