`timescale 1ps/1ps
module CPA_TB();
	reg [7:0]A,B;
	wire [7:0]S;
	reg C, en = 1'b0, clk = 1'b0, rst = 1'b0;
	wire Co;

	CPA Adder(S,Co,A,B,C,en,clk,rst);

	always #10 clk = ~clk;

	initial begin
	#10 rst = 1'b1;
	#20 rst = 1'b0;
	repeat(5) begin
	#20 A = $random();
	B = $random();
	C = $random();
	en = $random();
	end
	#20 $stop;
	end
endmodule