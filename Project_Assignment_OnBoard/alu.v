module alu (ALUop, a, b, result, clk, hi_data, lo_data);
	input 	[3:0] 	ALUop;
	input 	[31:0] 	a, b;
	input clk;
	
	output [31:0] hi_data;
	output [31:0] lo_data;
	output reg 	[31:0] 	result;

	reg [63:0] 	tem64;
	reg [31:0]	HI, LO;
	
	assign hi_data = HI[31:0];
	assign lo_data = LO[31:0];
	
	initial begin
		HI <= 32'h0000_0000;
		LO <= 32'h0000_0000;
	end

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
			4'b1000: result <= $signed(b) >>> a[4:0];// sra|srav;

			4'b1010: result <= (a < b)? 1: 0;// sltu|sltiu;
			4'b1011: result <= ($signed(a) < $signed(b))? 1: 0;// slt|slti;

			4'b1100: result = LO[31:0];// mflo;
			4'b1101: result = HI[31:0];// mfhi;
		endcase
	end

	always @ ( posedge clk ) begin
		case (ALUop)
			4'b1001: {HI, LO} = $signed(a) * $signed(b);
			4'b1110: HI = a[31:0];//mthi;
			4'b1111: LO = a[31:0];//mtlo;
		endcase
	end

endmodule // Arithmetic Logic Unit;
