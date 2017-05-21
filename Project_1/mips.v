`include "datapath/pc.v"
`include "datapath/alu.v"
`include "datapath/dm.v"
`include "datapath/ext.v"
`include "datapath/im.v"
`include "datapath/npc.v"
`include "datapath/rf.v"
`include "datapath/mux.v"
`include "control/ctrl.v"

module mips (clk, rst);
	input clk;
	input rst;

	wire 	[31:0] 	pc_next;
	wire 	[31:0] 	pc_cur;
	wire 	[3:0]	aluCtr;
	wire 			branch;
	wire 			jump;
	wire 			regDst;
	wire 			aluSrc;
	wire 			regWr;
	wire 			memWr;
	wire 			extOp;
	wire 			memtoReg;




	pc pc(
		.clk(clk),
		.rst(rst),
		.niaddr(pc_next),
		.iaddr(pc_cur)
	);

	ext ext_mux(
		.imm16(),
		.extOp(),
		.dout()
	);


	mux #(32) mux_alu(
		.a(),
		.b(),
		.ctrl_s(),
		.dout()
	);

endmodule // mips
