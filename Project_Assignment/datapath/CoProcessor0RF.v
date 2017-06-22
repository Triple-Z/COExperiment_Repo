module CoProcessor0RF(clk, din, wEn, regNum, sel, dout);
	input			clk;
	input	[31:0]	din;
	input	[1:0]	wEn;
	input 	[4:0]	regNum;
	input	[2:0]	sel;
	output	[31:0]	dout;

	reg	[31:0]	coprf	[0:31];

	initial begin
		coprf[12]	= 32'h3000_0000;// Status
		coprf[13]	= 32'h0000_0000;// Cause
		coprf[14]	= 32'h0000_3000;// EPC
	end

	assign dout = coprf[regNum];

	always @ (posedge clk) begin
		if (wEn) begin
			coprf[regNum] <= din;
		end
	end

endmodule // CoProcessor 0 Register File;
