module DivCU(Ready,ldAslc,ldBslc,ldAen,ldBen,ldCen,Shiften,Signslc,Adden,Res,Start,ASign,clk,rst);
	parameter N = 6;
	output reg Ready;
	output reg ldAslc, ldBslc;
	output reg ldAen, ldBen, ldCen;
	output reg Shiften, Signslc, Adden;
	output reg Res;
	input Start, ASign;
	input clk, rst;
	
	reg [3:0]Counter, ps, ns;
	reg Cnten, Cntout, set;
	
	parameter [3:0]Init0 = 4'b0000, Init1 = 4'b0001, Begin = 4'b0010, SHL = 4'b0011, Sub = 4'b0100, Load1 = 4'b0101, Check1 = 4'b0110,
				Add = 4'b0111, Load2 = 4'b1000, Check2 = 4'b1001, Finish = 4'b1010;
	
	always @(ps,Start,ASign,Cntout)
	begin
		case(ps)
			Init0 : ns = Start ? Init1:Init0;
			Init1 : ns = Start ? Init1:Begin;
			Begin : ns = SHL;
			SHL   : ns = Sub;
			Sub	  : ns = Load1;
			Load1 : ns = Check1;
			Check1: ns = ASign ? Add:Cntout ? Finish:SHL;
			Add   : ns = Load2;
			Load2 : ns = Check2;
			Check2: ns = Cntout ? Finish:SHL;
			Finish: ns = Start ? Init1:Finish;
			default:ns = Init0;
		endcase
	end
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			ps <= Init0;
		else
			ps <= ns;
	end
	
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			Counter <= 4'b0000;
		else if(set)
			Counter <= (~N);
		else if(Cnten)
			Counter <= Counter + 1;
		else
			Counter <= Counter;
	end
	
	always @(ps)
	begin
		Ready = (ps==Finish) ? 1'b1:1'b0;
		ldAslc = (ps==Begin) ? 1'b0:1'b1;
		ldBslc = (ps==Begin) ? 1'b0:1'b1;
		ldAen = (ps==Begin) ? 1'b1:(ps==Load1) ? 1'b1:(ps==Load2) ? 1'b1:1'b0;
		ldBen = (ps==Begin) ? 1'b1:(ps==Check1) ? 1'b1:1'b0;
		ldCen = (ps==Begin) ? 1'b1:1'b0;
		Adden = (ps==Sub) ? 1'b1:(ps==Add) ? 1'b1:1'b0;
		Cnten = (ps==SHL) ? 1'b1:1'b0;
		Shiften = (ps==SHL) ? 1'b1:1'b0;
		Signslc = ~ASign;
		Res = ~ASign;
		set = (ps==Begin) ? 1'b1:1'b0;
	end
	
	assign Cntout = &Counter;
endmodule