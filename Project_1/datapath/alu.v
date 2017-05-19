module alu (ALUop, a, b, result, zero);
	input 	[2:0] 	ALUop;
	input 	[31:0] 	a, b;
	output 		zero;
	output reg 	[31:0] 	result;

	assign zero = (result == 0)? 1: 0;

	always @ ( ALUop or a or b ) begin
		case (ALUop)
			3'b000: result = a + b;// addu;
			3'b001: result = a + b;// add;
			3'b010: result = a | b;// or;
			3'b100: result = a - b;// subu;
			3'b101: result = a - b;// sub;
			3'b110: result = a < b? 1: 0;// sltu;
			3'b111: result = a < b? 1: 0;// slt;
			default: result = 0;
		endcase
	end

endmodule // Arithmetic Logic Unit;
