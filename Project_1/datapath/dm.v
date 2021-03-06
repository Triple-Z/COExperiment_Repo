module dm_4k (addr, din, wEn, clk, dout);
	input 		[11:2] 	addr;
	input 		[31:0] 	din;
	input  				wEn;
	input 				clk;
	output  	[31:0] 	dout;

	reg [31:0] dm [1023:0];// 32-bit*1024;

	assign dout = dm[addr[11:2]][31:0];

	always @ ( posedge clk ) begin// Write;
		if (wEn) begin
			dm[addr[11:2]][31:0] <= din[31:0];
		end
	end
endmodule // 4K Data Memeory;
