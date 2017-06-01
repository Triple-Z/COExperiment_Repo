module alu (a, b, ALUop, result);
	input 	[31:0] 	a;
	input 	[31:0] 	b;
	input 		ALUop;

	output  	reg 	[31:0] 	result;

	always @ ( ALUop or a or b ) begin
		case (ALUop)

			default: result = 0;
		endcase
	end
endmodule // Arithmetic Logic Unit;
