`timescale 1ns / 1ps
module reverse_testbench;

	// Inputs
	reg [7:0] rev_in;

	// Outputs
	wire [7:0] rev_out;

	// Instantiate the Unit Under Test (UUT)
	reverse uut (
		.rev_out(rev_out), 
		.rev_in(rev_in)
	);

	initial begin
		// Initialize Inputs
		rev_in = 8'b10000000;
		#5
		rev_in = 8'b11110000;
		#5
		rev_in = 8'b11010100;
		#5
		rev_in = 8'b10000011;
	end
	
	always @(rev_out) 
			#1 $display ("Time = %d \t rev_in = %b \t  rev_out = %b",
			$time, rev_in, rev_out);	
endmodule

