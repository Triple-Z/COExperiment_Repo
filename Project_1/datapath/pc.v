module pc (clk, rst, niaddr, iaddr);
	input 			clk;
	input 			rst;
	input 	[31:0]	niaddr;// Next Instruction Address;

	output reg	[31:0]	iaddr;// Instruction Address;

	always @ ( posedge clk ) begin
		if (rst)
			iaddr <= 32'h0000_3000;
		else
			iaddr <= niaddr;
	end
endmodule // Program Counter;
