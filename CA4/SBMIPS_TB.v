`timescale 1ns/1ns
module SBMIPS_TB();
	reg clk = 1'b0, rst = 1'b0;
	
	SBMIPS P(clk, rst);
	
	always #10 clk = ~clk;
	
	initial 
	begin
	#10 rst = 1'b1;
	#20 rst = 1'b0;
	#650 $stop;
	end
endmodule