module pc (clk, rst, data, dout);
	input 	clk;
	input 	rst;
	input 	[31:0]	data;
	output reg	[31:0]	dout;

	always @ ( posedge clk ) begin
		if (rst)
			dout <= 32'h0000_3000;
		else
			dout <= data;
	end
endmodule // Program Counter;
