`timescale 1ns / 1ps
// Creates a clock "tick" called longer_clk, which has enough bits to slow down 
// the display to visible frequency. This takes the 50 MHz oscillator frequency of
// Spartan-3 down to (50 x 10**6) / (2**24), which is approximately 3Hz.
//////////////////////////////////////////////////////////////////////////////////
module freq_divider(
	input wire clk,
	output wire longer_clk
    );
	//inner signal, 
	reg [23:0] delayer; 
	
	always @ (posedge clk)
		delayer <= delayer + 1;
	
	assign longer_clk = (delayer == 0) ? 1: 0;
	//Note: longer_clk always starts as ON at Time == 0
endmodule// freq_divider

