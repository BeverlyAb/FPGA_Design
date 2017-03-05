`timescale 1ns / 1ps

//
//////////////////////////////////////////////////////////////////////////////////
module hold_display(
	input wire clk, done_tick,
	output wire longer_clk
    );
	//inner signal, 
	reg [23:0] delayer; 
	
	always @ (posedge clk)
		delayer <= delayer + 1;
	
	assign longer_clk = (delayer == 0 & done_tick == 1) ? 1: 0;
	//Note: longer_clk always starts as ON at Time == 0
endmodule// freq_divider
	