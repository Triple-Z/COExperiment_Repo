module alu (ALUop, a, b, result, zero);
	input 	[3:0] 	ALUop;
	input 	[31:0] 	a, b;
	output 		zero;
	output reg 	[31:0] 	result;

	assign zero = (result == 0)? 1: 0;

	always @ ( ALUop or a or b ) begin
		case (ALUop)
			4'b0000: result = a + b;// addu;
			4'b0001: result = a + b;// add;
			4'b0010: result = a & b;// and;
			4'b0011: result = a | b;// or;
			4'b1000: result = a - b;// subu;
			4'b1001: result = a - b;// sub;
			4'b1010: result = a < b? 1: 0;// sltu;
			4'b1011: result = a < b? 1: 0;// slt;
			default: result = 0;
		endcase
	end

endmodule // Arithmetic Logic Unit;
