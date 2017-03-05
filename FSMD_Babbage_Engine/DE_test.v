`timescale 1ns / 1ps

// 
////////////////////////////////////////////////////////////////////////////////

module DE_test;

	// Inputs
	reg [5:0] n;
	reg start;
	reg clk;
	reg reset;

	// Outputs
	wire [12:0] data_out;
	wire done_tick;

	// Instantiate the Unit Under Test (UUT)
	Difference_Engine uut (
		.n(n), 
		.start(start), 
		.clk(clk), 
		.reset(reset), 
		.data_out(data_out), 
		.done_tick(done_tick)
	);

	initial begin:init
		// Initialize Inputs
		n = 0; // fn = 5
		start = 1;
		clk = 0;
		reset = 0;
		#1 reset = 0;
	end
	
	initial begin:test
	#5 n = 1;	//fn = 10
	#10 n = 2;	//fn = 19
	#10 start = 0; // disable
	
	end
	
	initial begin: clock_cycle
		forever #1 clk = ~clk;
	end

	initial begin:stop
		#30 $stop;
	end
endmodule

