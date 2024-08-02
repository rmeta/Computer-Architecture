`timescale 1ps/1ps
module cmp1_TB();
	reg [7:0]PI;
	reg ctrl = 1'b0;
	wire [7:0]PO;

	cmp1 C(PO,PI,ctrl);

	initial begin
	repeat(5) begin
	#10 PI = $random();
	ctrl = $random();
	end
	end
endmodule