module regFile (busW, clk, wE, rW, rA, rB, busA, busB);
	input 	[31:0] 	busW;
	input 	[4:0] 	rW, rA, rB;
	input 			clk, wE;
	output 	[31:0] 	busA, busB;

	reg		[31:0] 	register[0:31];

	initial begin
		register[0] 	= 0;// $zero;

		register[8] 	= 0;// $t0;
		register[9] 	= 1;// $t1;
		register[10] 	= 2;// $t2;
		register[11] 	= 3;// $t3;
		register[12] 	= 4;// $t4;
		register[13] 	= 5;// $t5;
		register[14] 	= 6;// $t6;
		register[15] 	= 7;// $t7;

		register[16]	= 0;// $s0;
		register[17]	= 0;// $s0;
		register[18]	= 0;// $s0;
		register[19]	= 0;// $s0;
	end

	assign busA = (rA != 0)? register[rA]: 0;
	assign busB = (rB != 0)? register[rB]: 0;

	always @ ( posedge clk ) begin
		if ((wE == 1) && (rW != 0)) begin
			register[rW] <= busW;
		end
	end
endmodule // Register File
