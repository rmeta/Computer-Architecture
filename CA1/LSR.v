module LSR(PO,PI,SerIn,Shift,Load,clk,rst);
	parameter N = 8;		//Register Size
	output reg [N-1:0]PO;	//paraller output
	input [N-1:0]PI;		//paraller input
	input SerIn;			//Serial input
	input Shift, Load;		//Shift and Load control
	input clk, rst;			//clock and resetting signals

	always @(posedge clk, posedge rst)
	begin
		if(rst)
			PO <= 0;
		else if(Load)
			PO <= PI;
		else if(Shift)
			PO <= {PO[N-2:0],SerIn};
		else
			PO <= PO;
	end
endmodule