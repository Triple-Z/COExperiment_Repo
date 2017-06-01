module adder ();
	input 	[31:0] 	operand1;
	input 	[31:0] 	operand2;
	input 		cin;
	output 		cout;
	output 	[31:0] 	result;

	assign {cout, result} = operand1 + operand2 + cin;

endmodule // Adder;
