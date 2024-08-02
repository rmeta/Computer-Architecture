module MUX(Wout,Ain,Bin,Slc);
	parameter N = 8;		//inputs and outputs size
	output reg [N-1:0]Wout;	//output
	input [N-1:0]Ain,Bin;	//input
	input Slc;				//Selector signal
	
	assign Wout = Slc ? Bin:Ain;
endmodule