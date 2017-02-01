`timescale 1ns / 1ps

// Y, outputs the value based on lr. y = left if lr ==1, and right otherwise.
/////////////////////////////////////////////////////////////////
module mux_2_to_1(
	output wire [7:0] y, 		// output of mux
	input  wire [7:0] left, right, 	// input a = 1'b1, b = 1'b0
	input  wire lr					// select, left or right    
	); 
	assign y = lr ? left: right;	// the type after assign must be WIRE
										// if lr = 1, then y = left
										// if lr = 0, then y = right
endmodule//mux_2_to_1
