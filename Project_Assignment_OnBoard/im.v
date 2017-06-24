module im_4k (iaddr, ins);
	input 	[11:2] iaddr;
	output 	[31:0] ins;

	reg	[31:0]	im	[31:0];// 32-bit*1024;

	initial begin
		$readmemh("code.txt", im);
	end

	assign ins = im[iaddr[11:2]][31:0];


endmodule // 4k Instruction Memeory;
