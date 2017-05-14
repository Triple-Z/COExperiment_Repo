module regFile (din, addr, clk, rst, wEn, dout);
	input clk, rst, wEn;
	input [1:0] addr;
	input [7:0] din;
	output [7:0] dout;

	reg [7:0] R[0:3];

	assign dout = R[s];

	always @ ( posedge clk or negedge rst ) begin
		if (!rst) begin
			R[0] <= 0;
			R[1] <= 1;
			R[2] <= 2;
			R[3] <= 3;
		end
		else if (wEn) begin
			R[s] <= din;
		end
	end
endmodule // Register File
