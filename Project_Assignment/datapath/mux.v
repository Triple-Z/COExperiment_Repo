module mux #(parameter WIDTH = 32) (a, b, ctrl_s, dout);
	input 	[WIDTH - 1:0] 	a;
	input 	[WIDTH - 1:0] 	b;
	input 	[WIDTH - 1:0]	c;
	input 	[WIDTH - 1:0] 	d;
	input 	[1:0]	ctrl_s;

	output 	reg 	[WIDTH - 1:0]	dout;

	always @ ( * ) begin
		case (ctrl_s)
			2'b00: dout = a;
			2'b01: dout = b;
			2'b10: dout = c;
			2'b11: dout = d;
		endcase
	end


endmodule // Multiplexer;
