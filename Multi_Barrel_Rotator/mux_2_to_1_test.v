`timescale 1ns / 1ps

module mux_2_to_1_test;

	// Inputs
	reg [7:0] left;
	reg [7:0] right;
	reg lr;

	// Outputs
	wire [7:0] y;

	// Instantiate the Unit Under Test (UUT)
	mux_2_to_1 uut (
		.y(y), 
		.left(left), 
		.right(right), 
		.lr(lr)
	);

	initial begin
		// Initialize Inputs
		left = 0;
		right = 1;
		lr = 0; //output right
		#1;
		lr =1; // output left
		#1;
		$stop;
	end
      
endmodule

