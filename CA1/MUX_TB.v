`timescale 1ps/1ps
module MUX_TB();
	reg [7:0]A,B;
	wire [7:0]W;
	reg S;

	MUX M(W,A,B,S);

	initial begin
	repeat(5) begin
	#20 A = $random();
	B = $random();
	S = $random();
	end
	#10 $stop;
	end
endmodule