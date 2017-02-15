`timescale 1ns / 1ps

// 
////////////////////////////////////////////////////////////////////////////////

module PLOC_test;

	// Inputs
	reg a;
	reg b;
	reg clk;
	reg reset;

	// Outputs
	wire [1:0] inc_dec;

	// Instantiate the Unit Under Test (UUT)
	PLOC_Machine uut (
		.a(a), 
		.b(b), 
		.clk(clk), 
		.reset(reset), 
		.inc_dec(inc_dec)
	);

		initial begin:init
		reset = 0;
		// Initialize Inputs
		a = 0;		//00
		b = 0;
		clk = 0;
		#5;
		#5 a = 1;	//10
		#5 b = 1;	//11
		#5 a = 0;	//01
		#5 b = 0; 	//00 inc_dec == 2
		
		#5 b = 1;	//01
		#5 a = 1;	//11
		#5 b = 0;	//10
		#5 a = 0; 	//00 inc_dec == 1
		
		#5 reset = 1;
		#5 reset = 0;
		#5 a = 1;	//10
		#5 b = 1;	//11
		#5 a = 0;	//01
		#5 b = 0; 	//00 inc_dec == 2
		
	end
	
	initial begin:clk_cycle 
		forever
			#1 clk = ~clk;
	end 
	initial begin: stop_at
		# 60 $stop;
   end  
endmodule