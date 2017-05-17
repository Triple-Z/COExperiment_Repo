module alu (ALUop, a, b, result, zero);
	input 	[3:0] 	ALUop;
	input 	[31:0] 	a, b;
	output 		zero;
	output reg 	[31:0] 	result;

	assign zero = (result == 0)? 1: 0;

	always @ ( ALUop or a or b ) begin

	end

endmodule // Arithmetic Logic Unit;
