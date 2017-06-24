module npc (iaddr, branch, jump, ins, jiaddr, imm16, imm26, riaddr, niaddr);
	input 	branch, jump;
	input [31:0] 	ins;
	input [31:0]	jiaddr;// Jump to instruction address.
	input [31:0]	iaddr;// Instruction Address.
	input [15:0] 	imm16;
	input [25:0]	imm26;

	output 	 	[31:0] riaddr;// Return instruction address;
	output reg 	[31:0] niaddr;// Next Instruction Address;

	wire [5:0]	op;
	wire [5:0] 	func;
	assign op 	= ins[31:26];
	assign func = ins[5:0];
	// Operation code.
	parameter 	R 		= 6'b000000,
				J  		= 6'b000010,
				JAL		= 6'b000011,
				ERET	= 6'b010000;
	// Function code.
	parameter 	JR		= 6'b001000,
				JALR	= 6'b001001,
				SYSCALL = 6'b001100;

	wire [31:0] pc4;

	assign pc4 		= iaddr + 3'b100;
	assign riaddr 	= pc4 + 3'b100;

	always @ ( * ) begin
		if (branch) begin// Branch;
			// Arithmetic extend.
			niaddr = {{14{imm16[15]}}, imm16[15:0], 2'b00} + pc4;

		end else if (jump) begin// Jump.
			case (op)
				J: begin// Jump.
					niaddr = {iaddr[31:28], imm26[25:0], 2'b00};
				end
				JAL: begin// Jump and link.
					// riaddr <= pc4 + 3'b100;
					niaddr <= {iaddr[31:28], imm26[25:0], 2'b00};
				end
				R: begin
					case (func)
						JR: begin// Jump register.
							niaddr = jiaddr[31:0];
						end
						JALR: begin// Jump and link register.
							// riaddr <= pc4 + 3'b100;
							niaddr <= jiaddr[31:0];
						end
						SYSCALL: begin
							niaddr <= jiaddr[31:0];
						end
					endcase
				end
				ERET: begin
					niaddr <= jiaddr[31:0];
				end
			endcase

		end else begin// PC + 4;
			niaddr = pc4;
		end
	end

endmodule // Next Program Counter;
