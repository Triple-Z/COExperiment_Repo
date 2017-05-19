module im_4k (addr, dout);
	input [11:2] addr;
	output [31:0] dout;

	reg [31:0] im[1023:0];

endmodule // 4k Instruction Memeory;
