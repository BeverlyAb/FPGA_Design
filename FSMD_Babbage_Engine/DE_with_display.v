`timescale 1ns / 1ps
//
//////////////////////////////////////////////////////////////////////////////////
module DE_with_display(
	input wire [5:0] n,
	input wire start, clk, reset,
	//output wire done_tick_signal,
	output wire [3:0] an,
	output wire [7:0] sseg 
    );

	//internal signals 
	wire [12:0] DE_data_out;
	wire DE_done_tick;
	wire HD_hold_clk;
	
	Difference_Engine DE(
	.n(n), //input
	.start(start), .clk(clk), .reset(reset),
	.data_out(DE_data_out), //output	
	.done_tick(DE_done_tick)
    );

	hold_display HD(
		.clk(clk),
		.done_tick(DE_done_tick),
		.longer_clk(HD_hold_clk)
		);
	
	display D(
		.clk(HD_hold_clk),
		.done_tick(DE_done_tick),
		.data(DE_data_out),
		.sseg(sseg),
		.an(an)
		);
endmodule
