`timescale 1ns / 1ps
// Simulation for RSC.v
////////////////////////////////////////////////////////////////////////////////

module rsc_test;

	// Inputs
	reg clk;
	reg cw;
	reg en;
	// Outputs
	wire [3:0] an;
	wire [6:0] sseg;

	// Instantiate the Unit Under Test (UUT)
	RSC uut (
		.clk(clk), 
		.cw(cw), 
		.en(en),
		.an(an),
		.sseg(sseg)
	);

	initial begin:Init
		// Initialize Inputs
		en = 1;
		clk = 0;
		cw = 1; 			//clockwise
		# 20 cw = 0; 	//counter-clockwise
		# 21 en = 0; 	//Halt rotation
		# 5 en = 1; 	//Resume 
	end
	
	initial begin:clk_cycle 
		forever 
			#1 clk = ~clk;
	end
	
	initial begin:stop_at
		#55 $stop;
	end
      
endmodule //rsc_test

