`timescale 1ns / 1ps
// This is the complete design for the Barrel_rotator (left and right),
// which is suitable for simulation.
////////////////////////////////////////////////////////////////
module Barrel_Rotator(
	output [7:0] data_out, 
	input wire lr,
	input wire [2:0] amount,
	input [7:0] data_in
    );
	 
	 // internal signals
	wire [7:0] left_out, right_out;
	 
	left_rotator left_rotator1(
		.d_out(left_out),	//output
		.d_in(data_in),	//inputs
		.bit_amount(amount)
		);
	
	right_rotator right_rotator1(
		.d_out(right_out),	//output
		.d_in(data_in),	//inputs
		.bit_amount(amount)
		);
	
	mux_2_to_1 mux_2_to_1_1(
		.y(data_out),	//output
		.left(left_out),//inputs
		.right(right_out),
		.lr(lr)
		);
endmodule // Barrel_Rotator
