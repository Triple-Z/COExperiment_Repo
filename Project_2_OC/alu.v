module alu (a, b, ALUop, result);
	input 	[31:0] 	a;
	input 	[31:0] 	b;
	input 		ALUop;

	output  	reg 	[31:0] 	result;

	always @ ( ALUop or a or b ) begin
		case (ALUop)
			4'b0000: result = a + b;// add;
			4'b0001: result = a - b;// sub;
			4'b0010: result = ($signed(a) < $signed(b))? 1: 0;// slt;
			4'b0011: result = (a < b)? 1: 0;// sltu;
			4'b0100: result = a & b;// and;
			4'b0101: result = ~(a | b);// nor;
			4'b0110: result = a | b;// or;
			4'b0111: result = a ^ b;// xor;
			4'b1000: result = a << b[4:0];// sll;
			4'b1001: result = a >> b[4:0];// srl;
			4'b1010: result = $signed(a) >> b[4:0];// sra;
			4'b1011: result = a >> 16;// lui;
			default: result = 0;
		endcase
	end
endmodule // Arithmetic Logic Unit;
