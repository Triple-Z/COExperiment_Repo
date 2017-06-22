`include "datapath/alu.v"
`include "datapath/comp.v"
`include "datapath/CoProcessor0RF.v"
`include "datapath/dm.v"
`include "datapath/ext.v"
`include "datapath/im.v"
`include "datapath/mux.v"
`include "datapath/npc.v"
`include "datapath/pc.v"
`include "datapath/rf.v"
`include "control/ctrl.v"

module mips (clk, rst);
	input clk;
	input rst;

	// Wires.
	wire 	[31:0] 	pc_next;
	wire 	[31:0] 	pc_cur;
	wire 	[31:0] 	ins;
	wire 	[31:0]	ext_imm;
	wire 	[31:0]	routa;
	wire 	[31:0]	routb;
	wire 	[31:0]	rin;
	wire 	[31:0]	aluSrcA_mux_out;
	wire 	[31:0]	aluSrcB_mux_out;
	wire 	[31:0]	alu_out;
	wire 	[31:0] 	return_addr;
	wire 	[31:0]	dm_out;
	wire 	[4:0]	rWin;
	wire 	[31:0] 	cop_out;
	wire 	[31:0] 	npc_out;

	// Control signals.
	wire 	[3:0]	aluCtr;
	wire 			compare;
	wire 			branch;
	wire 			jump;
	wire 	[1:0]	regDst;
	wire 	[1:0]	aluSrcA;
	wire 	[1:0]	aluSrcB;
	wire 	[1:0]	regWr;
	wire 	[1:0]	memWr;
	wire 	[1:0]	immExt;
	wire 	[1:0]	memtoReg;
	wire 	[1:0] 	copWr;
	wire 	[1:0]	byteExt;
	wire 	[4:0] 	manInput_raddr;
	wire 	[31:0] 	manInput_shf;


	pc pc(
		.clk(clk),
		.rst(rst),
		.niaddr(pc_next),
		.iaddr(pc_cur)
	);

	npc npc(
		.iaddr(pc_cur),
		.branch(branch),
		.jump(jump),
		.ins(ins),
		.jiaddr(aluSrcA_mux_out),
		.imm16(ins[15:0]),
		.imm26(ins[25:0]),
		.riaddr(npc_out),
		.niaddr(pc_next)
	);

	im_4k im(
		.iaddr(pc_cur[11:2]),
		.ins(ins)
	);

	ext immExt_ext(
		.din(ins[15:0]),
		.extOp(immExt),
		.dout(ext_imm)
	);

	mux #(32) aluSrcA_mux(
		.a(routa),
		.b({{27{1'b0}}, ins[10:6]}),// Shift.
		.c(manInput_shf),
		.ctrl_s(aluSrcA),
		.dout(aluSrcA_mux_out)
	);

	mux #(32) aluSrcB_mux(
		.a(routb),
		.b(ext_imm),
		.ctrl_s(aluSrcB),
		.dout(aluSrcB_mux_out)
	);

	mux #(5) regDst_mux(
		.a(ins[20:16]),// rt.
		.b(ins[15:11]),// rd.
		.c(manInput_raddr),
		.ctrl_s(regDst),
		.dout(rWin)
	);

	regFile rf(
		.busW(rin),
		.clk(clk),
		.wE(regWr),
		.rW(rWin),
		.rA(ins[25:21]),
		.rB(ins[20:16]),
		.busA(routa),
		.busB(routb)
	);

	alu alu(
		.ALUop(aluCtr),
		.a(aluSrcA_mux_out),
		.b(aluSrcB_mux_out),
		.result(alu_out)
	);

	dm_4k dm(
		.addr(alu_out[11:0]),
		.din(routb),
		.byteExt(byteExt),
		.wEn(memWr),
		.clk(clk),
		.dout(dm_out)
	);

	mux #(32) memtoReg_mux(
		.a(alu_out),
		.b(dm_out),
		.c(cop_out),
		.d(npc_out),
		.ctrl_s(memtoReg),
		.dout(rin)
	);

	ctrl ctrl(
		.ins(ins),
		.compare(compare),
		.jump(jump),
		.regDst(regDst),
		.aluSrcA(aluSrcA),
		.aluSrcB(aluSrcB),
		.aluCtr(aluCtr),
		.regWr(regWr),
		.memWr(memWr),
		.immExt(immExt),
		.memtoReg(memtoReg),
		.copWr(copWr),
		.byteExt(byteExt),
		.manInput_raddr(manInput_raddr),
		.manInput_shf(manInput_shf)
	);

	comp comp(
		.dinA(aluSrcA_mux_out),
		.dinB(aluSrcB_mux_out),
		.ins(ins),
		.compare(compare),
		.branch(branch)
	);

	CoProcessor0RF CoP0(
		.clk(clk),
		.din(aluSrcB_mux_out),
		.wEn(copWr),
		.regNum(ins[15:11]),
		.sel(ins[2:0]),
		.dout(cop_out)
	);

endmodule // MIPS main program;
