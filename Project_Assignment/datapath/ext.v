module ext #(parameter WIDTH = 16)(din, extOp, dout);
    input       [1:0]			extOp;
    input       [WIDTH - 1:0]	din;
	output reg  [31:0]			dout;

    always @ ( * ) begin
        case (extOp)
			2'b00: dout = {{(32 - WIDTH){1'b0}}, din};// Logical Cal;
            2'b01: dout = {{(32 - WIDTH){din[WIDTH - 1]}}, din};// Arithmetic Cal;
			default: dout = din;
        endcase
    end
endmodule // Extender;
