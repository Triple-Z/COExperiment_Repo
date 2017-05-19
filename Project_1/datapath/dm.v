module dm_4k (addr, din, we, clk, dout);
	input[11:2] addr;// address bus
	input[31:0] din;// 32-bit input data
	input we;// memory write enable
	input clk;// clock
	output[31:0] dout;  // 32-bit memory output

endmodule // dm_4k
