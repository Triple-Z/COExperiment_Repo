module ctrl (ins, branch, jump, regDst, aluSrc, aluCtr, regWr, memWr, extOp, memtoReg);
	input 	[31:0] 	ins;

	output 	reg 	[3:0]	aluCtr;
	output 	reg		branch;
	output 	reg		jump;
	output 	reg		regDst;
	output 	reg		aluSrc;
	output 	reg		regWr;
	output 	reg		memWr;
	output 	reg		extOp;
	output 	reg		memtoReg;

	wire [5:0] op;
	wire [5:0] func;

	assign op	= ins[31:26];
	assign func	= ins[5:0];

	// Operation code;
	parameter  	R 	= 6'b000000,
		LW	= 6'b100011,
		SW	= 6'b101011,
		BEQ	= 6'b000100,
		J	= 6'b000010;
	// Function code;
	parameter 	ADD 	= 6'b100000,
		SUB 	= 6'b100010,
		AND 	= 6'b100100,
		OR	= 6'b100101,
		SLT 	= 6'b101010;

	always @ ( * ) begin
		case (op)
			R: begin
				branch 	= 0;
				jump	= 0;
				regDst	= 1;
				aluSrc	= 0;
				memtoReg	= 0;
				regWr	= 1;
				memWr	= 0;
				case (func)
					ADD: 	aluCtr = 4'b0001;
					SUB: 	aluCtr = 4'b1001;
					AND: 	aluCtr = 4'b0010;
					OR:	aluCtr = 4'b0011;
					SLT:	aluCtr = 4'b1011;
				endcase
			end

			LW: begin
				branch 	= 0;
				jump 	= 0;
				regDst	= 0;
				aluSrc	= 1;
				memtoReg	= 1;
				regWr	= 0;
				memWr	= 0;
				extOp	= 1;
				aluCtr 	= 4'b0001;// add;
			end

			SW: begin
				branch 	= 0;
				jump 	= 0;
				aluSrc	= 1;
				regWr	= 0;
				memWr	= 1;
				extOp	= 1;
				aluCtr 	= 4'b0001;// add;
			end

			BEQ: begin
				branch 	= 1;
				jump 	= 0;
				aluSrc	= 0;
				regWr	= 0;
				memWr	= 0;
			end

			J: begin
				branch 	= 0;
				jump 	= 1;
				regWr	= 0;
				memWr	= 0;
			end
		endcase
	end

endmodule // Control;
