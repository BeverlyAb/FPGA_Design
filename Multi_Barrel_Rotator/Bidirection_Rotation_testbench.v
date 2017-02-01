`timescale 1ns / 1ps

module Bidirection_Rotation_testbench;

	// Inputs
	reg lr;
	reg [2:0] amount;
	reg [7:0] data_in;

	// Outputs
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	Bidirection_Rotation uut (
		.data_out(data_out), 
		.lr(lr), 
		.amount(amount), 
		.data_in(data_in)
	);

		initial begin
		// Initialize Inputs and check for left rotate first
		data_in = 8'b10010010;
		
		lr = 1;
		amount = 3'b000;
		#5;
		amount = 3'b001;
		#5
		amount = 3'b010; 
		#5
		amount = 3'b011;
		#5
		amount = 3'b100;
		#5;
		amount = 3'b101;
		#5
		amount = 3'b110; 
		#5
		amount = 3'b111;
		
		#5
		lr = 0;  // Now check for right rotate
		amount = 3'b000;
		#5;
		amount = 3'b001;
		#5
		amount = 3'b010; 
		#5
		amount = 3'b011;
		#5
		amount = 3'b100;
		#5;
		amount = 3'b101;
		#5
		amount = 3'b110; 
		#5
		amount = 3'b111;
	end
    always @(data_out)
		#1 $display ("Time = %d \t data_in = %b \t amount = %d \t lr = %b \t data_out = %b",
			$time, data_in, amount, lr, data_out);
		
      
endmodule
