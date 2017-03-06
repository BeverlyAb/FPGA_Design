`timescale 1ns / 1ps

//
//////////////////////////////////////////////////////////////////////////////////
module hold_display(
	input wire clk, done_tick,
	output wire longer_clk
    );
	
	reg [19:0] delayer;
	
	always @ (posedge clk)
		delayer <= delayer + 1;
//	assign longer_clk = (done_tick) ? 1 : 0;
	assign longer_clk = (delayer == 0 & done_tick == 1) ? 1: 0;

endmodule// hold_display