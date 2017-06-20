module ctrl (ins, compare, jump, regDst, aluSrcA, aluSrcB, aluCtr, regWr, memWr, extOp, memtoReg, CopWr);
	input 	[31:0] 	ins;

	output 	reg 	[3:0]	aluCtr;
	output 	reg				compare;
	output 	reg				jump;
	output 	reg		[1:0]	regDst;
	output 	reg		[1:0]	aluSrcA;
	output 	reg		[1:0]	aluSrcB;
	output 	reg		[1:0]	regWr;
	output 	reg		[1:0]	memWr;
	output 	reg		[1:0]	extOp;
	output 	reg		[1:0]	memtoReg;
	output  reg 	[1:0]	CopWr;


	wire [5:0] op;
	wire [5:0] func;

	assign op	= ins[31:26];
	assign func	= ins[5:0];

	// Operation code;
	parameter  	R 				= 6'b000000,
				ADDIU			= 6'b001001,
				SLTI			= 6'b001010,
				SLTIU			= 6'b001011,
				ANDI			= 6'b001100,
				ORI				= 6'b001101,
				XORI			= 6'b001110,
				LUI				= 6'b001111,
				LW				= 6'b100011,
				SW				= 6'b101011,
				LB				= 6'b100000,
				LBU				= 6'b100100,
				SB				= 6'b101000,
				BEQ				= 6'b000100,
				BNE				= 6'b000101,
				BGTZ			= 6'b000111,
				BLEZ			= 6'b000110,
				BGEZ_BLTZ 		= 6'b000001,
				J				= 6'b000010,
				JAL				= 6'b000011,
				MTC0_MFC0_ERET	= 6'b010000;
	// Function code;
	parameter 	ADD 	= 6'b100000,
				ADDU 	= 6'b100001,
				SUB 	= 6'b100010,
				SUBU 	= 6'b100011,
				AND 	= 6'b100100,
				OR		= 6'b100101,
				XOR		= 6'b100110,
				NOR		= 6'b100111,
				SLT 	= 6'b101010,
				SLTU 	= 6'b101011,
				SLL		= 6'b000000,
				SRL		= 6'b000010,
				SRA		= 6'b000011,
				SLLV	= 6'b000100,
				SRLV	= 6'b000110,
				SRAV	= 6'b000111,
				JR		= 6'b001000,
				JALR	= 6'b001001,
				MULT	= 6'b011000,
				MFHI	= 6'b010000,
				MTHI	= 6'b010001,
				MFLO	= 6'b010010,
				MTLO	= 6'b010011,
				SYSCALL	= 6'b001100;

	always @ ( * ) begin
		case (op)
			R: begin// R-Type Instructions;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst 		<= 2'b01;
				aluSrcB		<= 2'b00;
				memtoReg 	<= 2'b00;
				memWr		<= 2'b00;
				CopWr		<= 2'b00;
				case (func)
					// Arithmetic operations.
					ADD: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0000;
						regWr	<= 2'b01;
					end
					ADDU: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0000;
						regWr	<= 2'b01;
					end
					SUB: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0001;
						regWr	<= 2'b01;
					end
					SUBU: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0001;
						regWr	<= 2'b01;
					end
					AND: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0010;
						regWr	<= 2'b01;
					end
					OR: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0011;
						regWr	<= 2'b01;
					end
					XOR: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0101;
						regWr	<= 2'b01;
					end
					NOR: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0100;
						regWr	<= 2'b01;
					end
					SLT: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b1011;
						regWr	<= 2'b01;
					end
					SLTU: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b1010;
						regWr	<= 2'b01;
					end
					// Bit moving operations.
					SLL: begin
						aluSrcA	<= 2'b01;
						aluCtr	<= 4'b0110;
						regWr	<= 2'b01;
					end
					SRL: begin
						aluSrcA	<= 2'b01;
						aluCtr 	<= 4'b0111;
						regWr	<= 2'b01;
					end
					SRA: begin
						aluSrcA	<= 2'b01;
						aluCtr 	<= 4'b1000;
						regWr	<= 2'b01;
					end
					SLLV: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0110;
						regWr	<= 2'b01;
					end
					SRLV: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b0111;
						regWr	<= 2'b01;
					end
					SRAV: begin
						aluSrcA	<= 2'b00;
						aluCtr 	<= 4'b1000;
						regWr	<= 2'b01;
					end
					// Jump || link operations.
					JR: begin
						jump 	<= 1'b1;
						regWr	<= 2'b00;
					end
					JALR: begin
						jump 	<= 1'b1;
						regWr	<= 2'b01;
					end
					MULT: begin
						jump 	<= 1'b0;
						aluCtr	<= 4'b1001;
						aluSrcA	<= 2'b00;
						regWr	<= 2'b00;
					end
					MFHI: begin
						jump 	<= 1'b0;
						aluCtr	<= 4'b1101;
						aluSrcA	<= 2'b00;
						regWr	<= 2'b01;
					end
					MTHI: begin
						jump 	<= 1'b0;
						aluCtr	<= 4'b1110;
						aluSrcA	<= 2'b00;
						regWr	<= 2'b00;
					end
					MFLO: begin
						jump 	<= 1'b0;
						aluCtr	<= 4'b1100;
						aluSrcA	<= 2'b00;
						regWr	<= 2'b01;
					end
					MTLO: begin
						jump 	<= 1'b0;
						aluCtr	<= 4'b1111;
						aluSrcA	<= 2'b00;
						regWr	<= 2'b00;
					end
					SYSCALL:begin
						jump 	<= 1'b0;
						regWr	<= 2'b00;
						CopWr	<= 2'b01;
					end
				endcase
			end

			LW: begin// Load word;
			end

			SW: begin// Store word;
			end

			BEQ: begin// Branch on equal;
			end

			J: begin// J-Type Instructions;
			end

			ORI: begin// Or immediate;
			end
		endcase
	end

endmodule // Control;
