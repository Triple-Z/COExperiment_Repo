`define BigEndianCPU 1

module dm_4k (addr, din, byteExt, wEn, clk, dout);
	input 		[11:0] 	addr;
	input 		[31:0] 	din;
	input 		[1:0]	byteExt;
	input  		[1:0]	wEn;
	input 				clk;
	output  reg	[31:0] 	dout;

	reg [31:0] dm [1023:0];// 32-bit*1024;

	wire 	[1:0]	byteSel;
	wire	[9:0]	gpAddr;

	reg 	[7:0]	byteIn;
	reg 	[31:0] 	tmpReg;

	assign byteSel 	= addr[1:0] ^ 2'b11;// Big endian.
	assign gpAddr 	= addr[11:2];

	always @ ( * ) begin
		if (byteExt == 2'b01 || byteExt == 2'b00) begin// Load byte.
			case (byteSel)
				2'b00: byteIn <= dm[gpAddr][7:0];
				2'b01: byteIn <= dm[gpAddr][15:8];
				2'b10: byteIn <= dm[gpAddr][23:16];
				2'b11: byteIn <= dm[gpAddr][31:24];
			endcase
			case (byteExt)// Embedded extender.
				2'b00: dout <= {{24{1'b0}}, byteIn};// Logical Cal;
				2'b01: dout <= {{24{byteIn[7]}}, byteIn};// Arithmetic Cal;
			endcase
		end else begin
			dout = dm[gpAddr][31:0];// Load word.
		end
	end


	always @ ( posedge clk ) begin// Write;
		if (wEn == 2'b01) begin
			if (byteExt == 2'b10) begin// Store byte.
				tmpReg = dm[gpAddr][31:0];
				case (byteSel)
					2'b00: tmpReg[7:0] 		= din[7:0];
					2'b01: tmpReg[15:8] 	= din[7:0];
					2'b10: tmpReg[23:16] 	= din[7:0];
					2'b11: tmpReg[31:24] 	= din[7:0];
				endcase
				dm[gpAddr][31:0] = tmpReg[31:0];
			end else begin// Store word.
				dm[gpAddr][31:0] = din[31:0];
			end
		end
	end
endmodule // 4K Data Memeory;
