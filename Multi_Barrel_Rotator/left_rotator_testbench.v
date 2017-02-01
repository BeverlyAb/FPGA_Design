`timescale 1ns / 1ps

module left_rotator_testbench;

	// Inputs
	reg [7:0] d_in;
	reg [2:0] bit_amount;

	// Outputs
	wire [7:0] d_out;

	// Instantiate the Unit Under Test (UUT)
	left_rotator uut (
		.d_out(d_out), 
		.d_in(d_in), 
		.bit_amount(bit_amount)
	);

	initial begin
		// Initialize Inputs
		d_in = 8'b10010010;
		
		bit_amount = 3'b000;
		#5;
		bit_amount = 3'b001;
		#5
		bit_amount = 3'b010; 
		#5
		bit_amount = 3'b011;
		#5
		bit_amount = 3'b100;
		#5;
		bit_amount = 3'b101;
		#5
		bit_amount = 3'b110; 
		#5
		bit_amount = 3'b111;
	end
    always @(d_out)
		#1 $display ("Time = %d \t d_in = %b \t bit_amount = %d \t d_out = %b",
			$time, d_in, bit_amount, d_out);
			
endmodule

