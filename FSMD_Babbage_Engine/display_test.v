`timescale 1ns / 1ps

// 
////////////////////////////////////////////////////////////////////////////////

module display_test;

	// Inputs
	reg clk;
	reg [12:0] data;

	// Outputs
	wire [7:0] sseg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	display uut (
		.clk(clk), 
		.data(data), 
		.sseg(sseg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		data = 12'd4;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   
	initial begin: clock_cycle
		forever #1 clk = ~clk;
	end

	initial begin:stop
		#30 $stop;
	end
endmodule

