module regFile (busW, clk, wE, rW, rA, rB, busA, busB);
	input 	[31:0] 	busW;
	input 		clk, wE;
	input 	[4:0] 	rW, rA, rB;
	output 	[31:0] 	busA, busB;

	reg		[31:0] 	register[0:31];

	initial begin
		register[0] = 0;
		register[8] = 1;
		register[9] = 3;
	end

	assign busA = (rA != 0)? register[rA]: 0;
	assign busB = (rB != 0)? register[rB]: 0;

	always @ ( posedge clk ) begin
		if ((wE == 1) && (rW != 0)) begin
			register[rW] <= busW;
		end
	end
endmodule // Register File
