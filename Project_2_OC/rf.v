module rf ();
	input 	[31:0] 	busW;
	input 	[4:0] 	rA;
	input 	[4:0] 	rB;
	input 	[4:0] 	rW;
	input  		clk;
	input 		wE;

	output  	[31:0] 	busA;
	output  	[31:0] 	busB;

	reg 	[31:0] 	register[31:0];

	// Read;
	assign busA[31:0] = register[rA];
	assign busB[31:0] = register[rB];

	// Write;
	always @ ( posedge clk ) begin
		if (wE) begin
			register[rW] <= busW;
		end
	end
endmodule // Register File;
