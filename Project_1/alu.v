module alu (op, a, b, result);
	input [2:0] op;
	input [7:0] a, b;
	output reg [7:0] result;

	always @ ( op or a or b ) begin
		if (op == 3'b000) result = a + b;
		else if (op == 3'b001) result = a - b;
		else if (op == 3'b010) result = a & b;
		else if (op == 3'b011) result = a | b;
		else if (op == 3'b100) result = ~a;
		else result = 8'b0;
	end
endmodule // Arithmetic Logic Unit;
