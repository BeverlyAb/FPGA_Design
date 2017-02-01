`timescale 1ns / 1ps
// Connects the Barrel_Rotator code to the physical layout onto the FPGA.
//////////////////////////////////////////////////////////////////////////////////
module FPGA_Barrel_Rotator(
	output wire [7:0] led,
	input wire [3:0] btn, // 3:1 amount, 0 lr 
	input wire [7:0] sw
    );

Barrel_Rotator BR_Test(
	.data_out(led),
	.lr(btn[0]),
	.amount(btn[3:1]),
	.data_in(sw)
	);
	
endmodule // FPGA_Barrel_Rotator