module InstMem(Instout, Address, clk);
	output reg [31:0]Instout;
	input [31:0]Address;
	input clk;
	
	reg[31:0] Inst[65535:0];
	
	assign Instout = Inst[Address[31:2]];
	
	initial 
	begin
		$readmemh("Instructions.hex", Inst);
		//$monitor("2000 = %h\n2004 = %h\n2008 = %h\n2012 = %h\n",Inst[0],Inst[1],Inst[2],Inst[3]);
	end
endmodule