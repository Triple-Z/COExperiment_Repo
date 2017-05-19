module im_4k (addr, dout);
	input 	[11:2] addr;
	output [31:0] dout;

	reg	[31:0]	im[1023:0];// 32-bit*1024;

	initial begin
		$readmemh("code.txt", im);
	end

	assign dout = im[addr[11:2]][31:0];


endmodule // 4k Instruction Memeory;
