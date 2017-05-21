module npc (iaddr, branch, jump, zero, imm16, imm26, niaddr);
	input 	branch, jump, zero;
	input [31:0]	iaddr;// Instruction Address;
	input [15:0] imm16;
	input [25:0]	imm26;

	output reg [31:0] niaddr;// Next Instruction Address;

	wire [31:0] pc4;
	assign pc4 = iaddr + 3'b100;

	always @ ( * ) begin
		if (zero) begin// Branch;
			niaddr = {{14{imm16[15]}}, imm16, 2'b00} + pc4;
		end else if (jump) begin// Jump;
			niaddr = {iaddr[31:28], imm26, 2'b00};
		end else begin// PC + 4;
			niaddr = pc4;
		end
	end
	
endmodule // Next Program Counter;
