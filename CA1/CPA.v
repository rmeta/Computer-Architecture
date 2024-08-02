module CPA(Sum,Cout,Ain,Bin,Cin,en,clk,rst);
	parameter N = 8;		//Adder size
	output reg [N-1:0]Sum;	//output 
	output reg Cout;		//carry out
	input [N-1:0]Ain,Bin;	//inputs
	input Cin;				//carry in
	input en;				//Add enable signal
	input clk,rst;			//clock and resetting signals

	always @(posedge clk, posedge rst)
	begin
		if(rst)
			{Cout,Sum} <= 0;
		else if(en)
			{Cout,Sum} <=  Ain + Bin + Cin;
		else
			{Cout,Sum} <= {Cout,Sum};
	end
endmodule