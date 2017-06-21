module alu (ALUop, a, b, result);
	input 	[3:0] 	ALUop;
	input 	[31:0] 	a, b;

	output reg 	[31:0] 	result;

	reg [31:0]	HI, LO;

	always @ ( ALUop or a or b ) begin
		case (ALUop)
			4'b0000: result <= a + b;// add|addu;
			4'b0001: result <= a - b;// sub|subu;
			4'b0010: result <= a & b;// and|andi;
			4'b0011: result <= a | b;// or|ori;
			4'b0100: result <= ~(a | b);// nor;
			4'b0101: result <= a ^ b;// xor|xori;
			4'b0110: result <= b << a[4:0];// sll;
			4'b0111: result <= b >> a[4:0];// srl|srlv;
			4'b1000: result <= $signed(b) >> a[4:0];// sra|srav;
			4'b1001: begin// mult;
					{HI, LO} = a * b;
				end
			4'b1010: result <= (a < b)? 1: 0;// sltu|sltiu;
			4'b1011: result <= ($signed(a) < $signed(b))? 1: 0;// slt|slti;
			4'b1100: result = LO;// mflo;
			4'b1101: result = HI;// mfhi;
			4'b1110: HI = a;//mthi;
			4'b1111: LO = a;//mtlo;
		endcase
	end

endmodule // Arithmetic Logic Unit;
