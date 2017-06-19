`include "mips.v"

module testbench ();
	reg clk, rst;

	initial begin
		clk = 0;
		rst = 1;
		#20 rst = 0;
	end

	always #10 clk = ~clk;

	mips mips(
		.clk(clk),
		.rst(rst)
	);

endmodule // Test Bench;
