`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//

// 
////////////////////////////////////////////////////////////////////////////////

module Occupancy_Counter_test;

	// Inputs
	reg [1:0] inc_dec;
	reg reset;
	reg clk;

	// Outputs
	wire [3:0] count;

	// Instantiate the Unit Under Test (UUT)
	Occupancy_Counter uut (
		.inc_dec(inc_dec), 
		.reset(reset),
		.clk(clk), 
		.count(count)
	);

	initial begin:init
		// Initialize Inputs
		inc_dec = 0;
		reset = 0;
		clk = 0;
		
		#1 inc_dec = 2'b10;	// 1
		#1 inc_dec = 2'b01; 	// 0
			inc_dec = 2'b10;
		#30 inc_dec = 2'b10;	// 15
			reset = 1;			//0
		#1	inc_dec = 2'b01;	//0
	end
	
	initial begin:clk_cycle 
		forever
			#1 clk = ~clk;
	end 
	initial begin: stop_at
		#45 $stop;
   end  
      
endmodule

