`timescale 1ns / 1ps
//// This is the complete design for the Bidirection_Rotation (pre and post reverse),
// which is suitable for simulation.
/////////////////////////////////////////////////////////////////
module Bidirection_Rotation(
	output wire [7:0] data_out,
	input wire lr,
	input wire [2:0] amount,
	input wire [7:0] data_in
    );
// internal signals
	wire [7:0] pre_rev_out, post_rev_out;
	wire [7:0] pre_mux_out;
	wire [7:0] right_out;
	
	reverse pre_rev(
		.rev_out(pre_rev_out),	//output
		.rev_in(data_in)			//input
		);
	
	mux_2_to_1 pre_mux(
		.y(pre_mux_out),	//output				
		.right(data_in),	//inputs
		.left(pre_rev_out), 
		.lr(lr)	// lr = 1 -> prev_rev_out, lr = 0 -> data_in
		);
		
	right_rotator right_rotator1(
		.d_out(right_out),	//output
		.d_in(pre_mux_out),	//inputs
		.bit_amount(amount)
		);
		
	reverse post_rev(
		.rev_out(post_rev_out),	//output
		.rev_in(right_out)			//input
		);
		
	mux_2_to_1 post_mux(
		.y(data_out),	//output
		.right(right_out),//input 
		.left(post_rev_out), // lr = 1 -> post_rev_out, lr = 0 -> right_out
		.lr(lr)
		);
endmodule // Bidirection_Rotation