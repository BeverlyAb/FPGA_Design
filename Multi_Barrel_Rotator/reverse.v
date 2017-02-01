`timescale 1ns / 1ps
 
// Outputs the reverse order of rev_in as rev_out.
////////////////////////////////////////////////////////////////
module reverse(
	output wire [7:0] rev_out,
	input wire [7:0] rev_in
    );
	//Generate loop index i must be defined as a genvar
	genvar i;
	// generate for loop is generating an instance for each iteration
	generate for(i = 0; i < 8; i = i + 1) begin
		assign rev_out[i] = rev_in[7-i];
	end endgenerate

endmodule // reverse
