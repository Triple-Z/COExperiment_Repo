module ctrl (ins, compare, jump, regDst, aluSrcA, aluSrcB, aluCtr, regWr, memWr, immExt, memtoReg, copWr, byteExt, manInput_raddr, manInput_shf);
	input 	[31:0] 	ins;

	output 	reg 	[3:0]	aluCtr;
	output 	reg				compare;
	output 	reg				jump;
	output 	reg		[1:0]	regDst;
	output 	reg		[1:0]	aluSrcA;
	output 	reg		[1:0]	aluSrcB;
	output 	reg		[1:0]	regWr;
	output 	reg		[1:0]	memWr;
	output 	reg		[1:0]	immExt;
	output 	reg		[1:0]	memtoReg;
	output  reg 	[1:0]	copWr;
	output 	reg 	[1:0]	byteExt;
	output 	reg 	[4:0] 	manInput_raddr;
	output 	reg 	[31:0]	manInput_shf;



	wire [5:0] op;
	wire [5:0] func;

	assign op			= ins[31:26];
	assign func			= ins[5:0];
	assign begz_bltz	= ins[20:16];
	assign mf_tc0_eret	= ins[25:21];

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
	// BGEZ_BLTZ
	parameter 	BGEZ 	= 5'b00001,
				BLTZ 	= 5'b00000;
	// MTC0_MFC0_ERET
	parameter 	MTC0 	= 5'b00100,
				MFC0 	= 5'b00000,
				ERET 	= 5'b10000;


	always @ ( * ) begin
		case (op)
			R: begin// R-Type Instructions;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst 		<= 2'b01;
				aluSrcB		<= 2'b00;
				memtoReg 	<= 2'b00;
				memWr		<= 2'b00;
				copWr		<= 2'b00;
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
						aluSrcA	<= 2'b00;
					end
					JALR: begin
						jump 		<= 1'b1;
						regWr		<= 2'b01;
						aluSrcA		<= 2'b00;
						memtoReg	<= 2'b11;
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
						copWr	<= 2'b01;
					end
				endcase
			end

			ADDIU: begin
				aluCtr 		<= 4'b0000;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b00;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b00;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b00;
				copWr		<= 2'b00;
			end

			SLTI: begin
				aluCtr 		<= 4'b1011;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b00;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b00;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b01;
				copWr		<= 2'b00;
			end

			SLTIU: begin
				aluCtr 		<= 4'b1010;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b00;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b00;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b00;
				copWr		<= 2'b00;
			end

			ANDI: begin
				aluCtr 		<= 4'b0010;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b00;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b00;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b00;
				copWr		<= 2'b00;
			end

			ORI: begin
				aluCtr 		<= 4'b0011;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b00;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b00;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b00;
				copWr		<= 2'b00;
			end

			XORI: begin
				aluCtr 		<= 4'b0101;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b00;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b00;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b00;
				copWr		<= 2'b00;
			end

			LUI: begin
				aluCtr 			<= 4'b0110;
				compare			<= 1'b0;
				jump			<= 1'b0;
				regDst			<= 2'b00;
				aluSrcA			<= 2'b10;
				aluSrcB			<= 2'b01;
				memtoReg		<= 2'b00;
				regWr			<= 2'b01;
				memWr			<= 2'b00;
				immExt			<= 2'b00;
				copWr			<= 2'b00;
				manInput_shf	<= 32'h0000_0010;
			end

			LW: begin// Load word;
				aluCtr 		<= 4'b0000;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b00;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b01;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b01;
				copWr		<= 2'b00;
				byteExt		<= 2'b11;
			end

			SW: begin// Store word;
				aluCtr 		<= 4'b0000;
				compare		<= 1'b0;
				jump		<= 1'b0;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				regWr		<= 2'b00;
				memWr		<= 2'b01;
				immExt		<= 2'b01;
				copWr		<= 2'b00;
				byteExt 	<= 2'b11;
			end

			LB: begin// Load byte.
				aluCtr 		<= 4'b0000;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b01;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b01;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b01;
				copWr		<= 2'b00;
				byteExt 	<= 2'b01;
			end

			LBU: begin// Load byte unsigned.
				aluCtr 		<= 4'b0000;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b01;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				memtoReg	<= 2'b01;
				regWr		<= 2'b01;
				memWr		<= 2'b00;
				immExt		<= 2'b01;
				copWr		<= 2'b00;
				byteExt 	<= 2'b00;
			end

			SB: begin// Store byte.
				aluCtr 		<= 4'b0000;
				compare		<= 1'b0;
				jump		<= 1'b0;
				regDst		<= 2'b00;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b01;
				regWr		<= 2'b00;
				memWr		<= 2'b01;
				immExt		<= 2'b01;
				copWr		<= 2'b00;
				byteExt 	<= 2'b10;
			end

			BEQ: begin// Branch on equal;
				compare		<= 1'b1;
				jump		<= 1'b0;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b00;
				regWr		<= 2'b00;
				memWr		<= 2'b00;
				copWr		<= 2'b00;
			end

			BNE: begin// Branch not on equal;
				compare		<= 1'b1;
				jump		<= 1'b0;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b00;
				regWr		<= 2'b00;
				memWr		<= 2'b00;
				copWr		<= 2'b00;
			end

			BGTZ: begin// Branch greater than zero;
				compare		<= 1'b1;
				jump		<= 1'b0;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b00;
				regWr		<= 2'b00;
				memWr		<= 2'b00;
				copWr		<= 2'b00;
			end

			BLEZ: begin// Branch less or equal than zero;
				compare		<= 1'b1;
				jump		<= 1'b0;
				aluSrcA		<= 2'b00;
				aluSrcB		<= 2'b00;
				regWr		<= 2'b00;
				memWr		<= 2'b00;
				copWr		<= 2'b00;
			end

			BGEZ_BLTZ: begin
				case (begz_bltz)
					BGEZ: begin// Branch greater or equal than zero.
						compare		<= 1'b1;
						jump		<= 1'b0;
						aluSrcA		<= 2'b00;
						aluSrcB		<= 2'b00;
						regWr		<= 2'b00;
						memWr		<= 2'b00;
						copWr		<= 2'b00;
					end
					BLTZ: begin// Branch less than zero.
						compare		<= 1'b1;
						jump		<= 1'b0;
						aluSrcA		<= 2'b00;
						aluSrcB		<= 2'b00;
						regWr		<= 2'b00;
						memWr		<= 2'b00;
						copWr		<= 2'b00;
					end
				endcase
			end

			J: begin// Jump.
				compare	<= 1'b0;
				jump	<= 1'b1;
				regWr	<= 2'b00;
				memWr	<= 2'b00;
				copWr	<= 2'b00;
			end

			JAL: begin// Jump and link.
				compare			<= 1'b0;
				jump			<= 1'b1;
				regDst 			<= 2'b10;
				memtoReg		<= 2'b11;
				regWr			<= 2'b01;
				memWr			<= 2'b00;
				immExt			<= 2'b00;
				copWr			<= 2'b00;
				manInput_raddr 	<= 5'b11111;
			end

			MTC0_MFC0_ERET: begin
				case (mf_tc0_eret)
					MTC0: begin// Move to Coprocessor 0.
						compare 	<= 1'b0;
						jump		<= 1'b0;
						regDst 		<= 2'b00;
						aluSrcB 	<= 2'b00;
						memtoReg 	<= 2'b00;
						regWr 		<= 2'b00;
						memWr		<= 2'b00;
						copWr		<= 2'b01;
					end

					MFC0: begin// Move from Coprocessor 0.
						compare 	<= 1'b0;
						jump		<= 1'b0;
						regDst 		<= 2'b00;
						memtoReg 	<= 2'b10;
						regWr 		<= 2'b01;
						memWr		<= 2'b00;
						copWr		<= 2'b00;
					end

					ERET:begin// Exception return.
						compare 	<= 1'b0;
						jump 		<= 1'b0;
						memtoReg 	<= 2'b00;
						regWr 		<= 2'b00;
						memWr 		<= 2'b00;
						copWr 		<= 2'b01;
					end
				endcase
			end

		endcase
	end

endmodule // Control;
