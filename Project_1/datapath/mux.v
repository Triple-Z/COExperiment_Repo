module mux #(parameter WIDTH = 32) (a, b, ctrl_s, dout);
	input 	[WIDTH - 1:0] 	a;
	input 	[WIDTH - 1:0] 	b;
	input 		ctrl_s;

	output 	[WIDTH - 1:0]	dout;

	assign dout = ctrl_s? b: a;

endmodule // Multiplexer;
