module CoProcessor0RF(clk, din, wEn, regNum, sel, dout, npc_out, expiaddr, ins, cop_addr, cop_data);
	input				clk;
	input		[1:0]	wEn;
	input 		[4:0]	regNum;
	input		[2:0]	sel;
	input		[31:0]	din;
	input 		[31:0] 	ins;
	input 		[31:0] 	npc_out;
	output		[31:0]	dout;
	output reg 	[31:0] 	expiaddr;
	input [4:0] cop_addr;
	output [31:0] cop_data;

	reg	[31:0]	coprf	[0:31];

	wire [5:0] op;
	wire [5:0] func;
	wire [4:0] mf_tc0_eret;

	assign op			= ins[31:26];
	assign mf_tc0_eret	= ins[25:21];
	assign func			= ins[5:0];

	// op
	parameter 	R 				= 6'b000000,
				MTC0_MFC0_ERET	= 6'b010000;
	// Function code.
	parameter 	SYSCALL	= 6'b001100;
	// MTC0_MFC0_ERET
	parameter 	MTC0 	= 5'b00100,
				MFC0 	= 5'b00000,
				ERET 	= 5'b10000;

	initial begin
		coprf[12]	= 32'h0000_0000;// Status
		coprf[13]	= 32'h0000_0000;// Cause
		coprf[14]	= 32'h0000_0000;// EPC
	end

	assign dout = coprf[regNum];

	assign cop_data = coprf[cop_addr];

	always @ (posedge clk) begin
		if (wEn) begin
			if ((op == R) && (func == SYSCALL)) begin// SYSCALL
				coprf[14] <= npc_out - 4'b1000;
				coprf[13][6:2] <= 5'b01000;
				coprf[12][1] <= 1'b1;
				expiaddr <= 32'h0000_0000;
			end else if ((op == MTC0_MFC0_ERET) && (mf_tc0_eret == ERET)) begin// ERET
				coprf[12][1] <= 1'b0;
				expiaddr <= coprf[14][31:0];
			end else begin// MTC0
				coprf[regNum] <= din;
			end
		end
	end

endmodule // CoProcessor 0 Register File;
