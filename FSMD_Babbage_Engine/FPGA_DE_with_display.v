`timescale 1ns / 1ps

//
//////////////////////////////////////////////////////////////////////////////////
module FPGA_DE_with_display(
	input wire clk,reset,
	input wire [7:0] sw,  // reset, start,n
//	output wire [0:0] led, //DONE_SIGNAL
	output wire [3:0] an,
	output wire [7:0] sseg
    );
	DE_with_display DE_w_d(
		.n(sw[5:0]),
		.start(sw[6]), 
		.clk(clk), 
		.reset(sw[7]),
		.an(an),
		.sseg(sseg) 
    );
		

endmodule
