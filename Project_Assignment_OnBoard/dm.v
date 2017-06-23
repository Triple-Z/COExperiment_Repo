`define BigEndianCPU 1

module dm_4k (addr, din, byteExt, wEn, clk, dout, test_addr, test_data, rst);
	input 		[11:0] 	addr;
	input 		[31:0] 	din;
	input 		[1:0]	byteExt;
	input  		[1:0]	wEn;
	input 				clk;
	output  reg	[31:0] 	dout;
	//调试端口，用于读出数据显示
    input  [4 :0] test_addr;
    output  [31:0] test_data;
	input 				rst;

	reg [31:0] dm [31:0];// 32-bit * 32;

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

		if (!rst) begin
			dm[0] 	<= 0;
			dm[1] 	<= 0;
			dm[2] 	<= 0;
			dm[3] 	<= 0;
			dm[4] 	<= 0;
			dm[5] 	<= 0;
			dm[6] 	<= 0;
			dm[7] 	<= 0;
			dm[8] 	<= 0;
			dm[9] 	<= 0;
			dm[10] 	<= 0;
			dm[11] 	<= 0;
			dm[12] 	<= 0;
			dm[13] 	<= 0;
			dm[14] 	<= 0;
			dm[15] 	<= 0;
			dm[16] 	<= 0;
			dm[17] 	<= 0;
			dm[18] 	<= 0;
			dm[19] 	<= 0;
			dm[20] 	<= 0;
			dm[21] 	<= 0;
			dm[22] 	<= 0;
			dm[23] 	<= 0;
			dm[24] 	<= 0;
			dm[25] 	<= 0;
			dm[26] 	<= 0;
			dm[27] 	<= 0;
			dm[28] 	<= 0;
			dm[29] 	<= 0;
			dm[30] 	<= 0;
			dm[31] 	<= 0;
		end
	end

	//调试端口，读出特定内存的数据
	assign test_data = dm[test_addr];
    // always @(*)
    // begin
    //     case (test_addr)
    //         5'd0 : test_data <= dm[0 ];
    //         5'd1 : test_data <= dm[1 ];
    //         5'd2 : test_data <= dm[2 ];
    //         5'd3 : test_data <= dm[3 ];
    //         5'd4 : test_data <= dm[4 ];
    //         5'd5 : test_data <= dm[5 ];
    //         5'd6 : test_data <= dm[6 ];
    //         5'd7 : test_data <= dm[7 ];
    //         5'd8 : test_data <= dm[8 ];
    //         5'd9 : test_data <= dm[9 ];
    //         5'd10: test_data <= dm[10];
    //         5'd11: test_data <= dm[11];
    //         5'd12: test_data <= dm[12];
    //         5'd13: test_data <= dm[13];
    //         5'd14: test_data <= dm[14];
    //         5'd15: test_data <= dm[15];
    //         5'd16: test_data <= dm[16];
    //         5'd17: test_data <= dm[17];
    //         5'd18: test_data <= dm[18];
    //         5'd19: test_data <= dm[19];
    //         5'd20: test_data <= dm[20];
    //         5'd21: test_data <= dm[21];
    //         5'd22: test_data <= dm[22];
    //         5'd23: test_data <= dm[23];
    //         5'd24: test_data <= dm[24];
    //         5'd25: test_data <= dm[25];
    //         5'd26: test_data <= dm[26];
    //         5'd27: test_data <= dm[27];
    //         5'd28: test_data <= dm[28];
    //         5'd29: test_data <= dm[29];
    //         5'd30: test_data <= dm[30];
    //         5'd31: test_data <= dm[31];
    //     endcase
    // end
endmodule // 4K Data Memeory;
