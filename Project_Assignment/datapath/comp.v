module comp(dinA, dinB, ins, compare, branch);
	input [31:0]	dinA;
	input [31:0]	dinB;
	input [31:0]	ins;
	input 	compare;
	output reg	branch;

	wire [5:0]	op;
	wire [4:0]	sel;

	assign sel	= ins[20:16];
	assign op 	= ins[31:26];

	// Operation code.
	parameter 	BEQ 	= 6'b000100,
		BNE 	= 6'b000101,
		BGTZ 	= 6'b000111,
		BLEZ 	= 6'b000110,
		BGEZ_BLTZ	= 6'b000001;

	// Sel code.
	parameter 	SEL0 	= 5'b00000,
		SEL1 	= 5'b00001;

	always @ ( compare or dinA or dinB ) begin
		if (compare) begin
			case (op)
				BEQ: begin
					if (dinA == dinB) begin
						branch = 1;
					end else branch = 0;
				end
				BNE: begin
					if (dinA != dinB) begin
						branch = 1;
					end else branch = 0;
				end
				BGTZ: begin
					if (dinA > 0) begin
						branch = 1;
					end else branch = 0;
				end
				BLEZ: begin
					if (dinA <= 0) begin
						branch = 1;
					end else branch = 0;
				end
				BGEZ_BLTZ: begin
					case (sel)
						SEL0: if (dinA < 0) begin// BLTZ
							branch = 1;
						end else branch = 0;
						SEL1: if (dinA >= 0) begin// BGEZ
							branch = 1;
						end else branch = 0;
					endcase
				end
				default: branch = 0;
			endcase
		end
	end

endmodule // Compare;
