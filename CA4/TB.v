module TB();
	reg [7:0]A;
	wire [7:0]B, C;
	reg POP = 1'b0, PUSH = 1'b0, TOS = 1'b0, ldR = 1'b0;
	reg clk = 1'b0, rst = 1'b0;
	
	Stack S(B, A, POP, PUSH, TOS, clk, rst);
	Register #(8) R(C, B, ldR, clk, rst);
	
	always #10 clk = ~clk;
	
	initial
	begin
		#10 rst = 1'b1;
		#10 rst = 1'b0;
		
		#10 PUSH = 1'b1;
			A = 8'b0011_1100;
			
		#20 PUSH = 1'b1;
			A = 8'b0011_0000;
			
		#21 PUSH = 1'b0;
			TOS = 1'b1;
			ldR = 1'b1;
		#30 $stop;
	end
endmodule