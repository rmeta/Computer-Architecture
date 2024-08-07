`timescale 1ps/1ps
module LSR_TB();
	reg [7:0]PI;
	reg SerIn,Shift,Load,clk = 1'b0,rst = 1'b0;
	wire [7:0]PO;

	LSR R(PO,PI,SerIn,Shift,Load,clk,rst);

	always #10 clk = ~clk;

	initial begin
	#10 rst = 1'b1;
	#20 rst = 1'b0;
	#20 Load = 1'b1;
	PI = $random();
	#20 Load = 1'b0;
	Shift = 1'b1;
	SerIn = $random();
	#40 $stop;
	end
endmodule