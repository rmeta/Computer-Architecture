module DP(Inst, Funct, Cmd, clk, rst);
	output reg [5:0] Inst, Funct;
	input [16:0] Cmd;
	input clk, rst;

	parameter [31:0] NOP = 32'b110011_00000_00000_1111_1111_1111_1111;
	
	wire [31:0] PC, PCp4_IF, nPC, PCp4_ID, PCp4_EX;
	wire [31:0] bAdr, b_jAdr, b_j_jrAdr;
	wire [31:0] Inst_IF, Inst_ID;
	wire [31:0] ExtCnst_ID, ExtCnst_EX, SHL2cnst;
	wire [15:0] Cnst_ID;
	wire [31:0] RFout1_ID, RFout1_EX, RFout2_ID, RFout2_EX;
	wire [31:0] A, B_EX, B_M;
	wire [31:0] ALUin1, ALUin2;
	wire [31:0] ALUout_EX, ALUout_M, ALUout_WB;
	wire [31:0] MEMout_M, MEMout_WB;
	wire [31:0] RFdatain;
	wire [4:0] Rs_ID, Rs_EX, Rt_ID, Rt_EX, Rd_ID, Rd_EX;
	wire [4:0] RDst_EX, RDst_M, RDst_WB;
	wire [7:0] EXcmd_ID, EXcmd_EX;
	wire [1:0] Mcmd_ID, Mcmd_EX, Mcmd_M;
	wire [1:0] WBcmd_ID, WBcmd_EX, WBcmd_M, WBcmd_WB;
	wire [1:0] fw1, fw2;
	wire PCslc, PCsrc, Branch, Eql, Jr_ctrl, J_ctrl, neq;
	wire Flush, write, PCslc_EX;
	
	assign {EXcmd_ID, Mcmd_ID, WBcmd_ID, PCsrc, Branch, Jr_ctrl, J_ctrl, neq} = Cmd;
	assign PCslc = PCsrc | (Eql & Branch);
	
	// IF part
	PCR PCRB(PC, nPC, write, clk, rst);
	Adder #(32) PCp4B(PCp4_IF, , PC, 4, 1'b0);
	InstMem IMB(Inst_IF, PC, clk, rst);
	MUX #(32) M1(nPC, PCp4_IF, b_j_jrAdr, PCslc);
	
	MidReg #(64) IFID({PCp4_ID, Inst_ID}, {PCp4_IF, Inst_IF}, {PC, NOP}, Flush, clk, rst);
	
	assign {Inst, Funct} = {Inst_ID[31:26], Inst_ID[5:0]};
	assign {Rs_ID, Rt_ID, Rd_ID} = {Inst_ID[25:21], Inst_ID[20:16], Inst_ID[15:11]};
	assign Cnst_ID = Inst_ID[15:0];
	
	// ID part
	RegFile RFB(RFout1_ID, RFout2_ID, Rs_ID, Rt_ID, RDst_WB, RFdatain, WBcmd_WB[1], clk, rst);
	EQL EQLB(Eql, RFout1_ID, RFout2_ID, neq);
	SE #(16) SEB(ExtCnst_ID, Cnst_ID);
	SHL2 #(32) SHL2B(SHL2cnst, ExtCnst_ID);
	Adder #(32) brchAdr(bAdr, , PCp4_ID, SHL2cnst, 1'b0);
	MUX #(32) M2(b_jAdr, bAdr, {PCp4_ID[31:26], Inst_ID[25:0]}, J_ctrl);
	MUX #(32) M3(b_j_jrAdr, b_jAdr, RFout1_ID, Jr_ctrl);
	
	HzdU HZB(Flush, write, RDst_EX, Rs_ID, Rt_ID, Mcmd_EX[1], PCslc_EX);
	
	MidReg #(156) IDEX({EXcmd_EX, Mcmd_EX, WBcmd_EX, PCslc_EX, PCp4_EX, RFout1_EX, RFout2_EX, ExtCnst_EX, Rs_EX, Rt_EX, Rd_EX}
				, {EXcmd_ID, Mcmd_ID, WBcmd_ID, PCslc, PCp4_ID, RFout1_ID, RFout2_ID, ExtCnst_ID, Rs_ID, Rt_ID, Rd_ID}
				, 156'b0, 1'b0, clk, rst);
	
	// EX part
	MUX4 #(32) M4(A, RFout1_EX, ALUout_M, RFdatain, 32'b0, fw1);
	MUX4 #(32) M5(B_EX, RFout2_EX, ALUout_M, RFdatain, 32'b0, fw2);
	MUX #(32) M6(ALUin1, A, PCp4_EX, EXcmd_EX[4]);
	MUX4 #(32) M7(ALUin2, B_EX, ExtCnst_EX, 32'b0, 32'b0, EXcmd_EX[3:2]);
	ALU ALUB(ALUout_EX, , ALUin1, ALUin2, EXcmd_EX[7:5]);
	MUX4 #(5) M8(RDst_EX, Rt_EX, Rd_EX, 5'b11111, 5'b0, EXcmd_EX[1:0]);
	
	FwdU FWB(fw1, fw2, RDst_M, RDst_WB, WBcmd_M[1], WBcmd_WB[1], Rs_EX, Rt_EX);
	
	MidReg #(73) EXMEM({Mcmd_M, WBcmd_M, ALUout_M, B_M, RDst_M}
						, {Mcmd_EX, WBcmd_EX, ALUout_EX, B_EX, RDst_EX}, 73'b0, 1'b0, clk, rst);
						
	// MEM part
	DataMem DMB(MEMout_M, ALUout_M, B_M, Mcmd_M[1], Mcmd_M[0], clk, rst);
	
	MidReg #(71) MEMWB({WBcmd_WB, MEMout_WB, ALUout_WB, RDst_WB}
						, {WBcmd_M, MEMout_M, ALUout_M, RDst_M}, 71'b0, 1'b0, clk, rst);
						
	// WB part
	MUX #(32) M9(RFdatain, ALUout_WB, MEMout_WB, WBcmd_WB[0]);
	
endmodule