`timescale 1ps/1ps
module Divider_TB();
	reg clk = 1'b0, rst = 1'b0;
	reg Start = 1'b0;
	reg [11:0]Dividend;
	reg [5:0]Divisor;
	wire [5:0]R,Q;
	wire Ready;
	
	Divider #(6) Div(Ready,R,Q,Start,Dividend,Divisor,clk,rst);
	
	always #10 clk = ~clk;
	
	initial
	begin
	#10 rst = 1'b1;
	#10 rst = 1'b0;
	
	#30 Start = 1'b1;
	#20 Start = 1'b0;
		Dividend = 12'b000000111001;
		Divisor = 6'b001100;
	
	#1000 Start = 1'b1;
	#20 Start = 1'b0;
		Dividend = 12'b000100111001;
		Divisor = 6'b001110;
	
	#1000 Start = 1'b1;
	#20 Start = 1'b0;
		Dividend = 12'b000101000111;
		Divisor = 6'b011001;
		
	#1000 Start = 1'b1;
	#20 Start = 1'b0;
		Dividend = 12'b001011100101;
		Divisor = 6'b011100;
		
	#1000 $stop;
	end
endmodule