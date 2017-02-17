`timescale 1ns / 1ps

//
//////////////////////////////////////////////////////////////////////////////////
module Occupancy_Counter(
	input wire clk,reset,
	input wire [1:0] inc_dec,
	output reg [3:0] count // counts up to 16 values
    );
	 
	initial count = 0;
	always @ (posedge clk, posedge reset) begin
		if (reset)
			count <= 0;
		else begin
			case(inc_dec)
				2'b10:	if (count != 15) 
						count <= count + 1;
				2'b01:	if (count != 0)
						count <= count - 1;
			default: count <= count;
			endcase
		end
	end
endmodule
