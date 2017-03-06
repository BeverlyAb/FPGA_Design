`timescale 1ns / 1ps

//
//////////////////////////////////////////////////////////////////////////////////
module FPGA_DE(
	input wire clk,
	input wire [5:0] sw,
	input wire btn[1:0],// reset,start
	output wire [7:0] led
	//output wire done_tick_signal,
	//output wire [3:0] an,
	//output wire [7:0] sseg 
    );
	
	Difference_Engine DE(
	.n(sw), //input
	.start(btn[0:0]), .clk(clk), .reset(btn[1:1]),
	.data_out(led), //output	
	.done_tick(~sseg[7])
    );