`timescale 1ns / 1ps
// Left rotates the value d_in based on the bit_amount. The output is d_out.
/////////////////////////////////////////////////////////////////
module left_rotator(
	output reg [7:0] d_out,				// 8'b
	input wire [7:0] d_in,
	input wire [2:0] bit_amount	// 3'b, enough to specify #'b to rotate
    );
	
	//In Verilog you can't use a variable as the end of range.
	// https://verificationacademy.com/forums/systemverilog/range-must-be-bounded-constant-expressions
	//assign d_out = {d_in[bit_amount +: 0], d_in[7+: 8]};	
	
	always @(*) begin
		case(bit_amount)
			3'd1: d_out = {d_in[6:0], d_in[7]};
			3'd2: d_out = {d_in[5:0], d_in[7:6]};
			3'd3: d_out = {d_in[4:0], d_in[7:5]};
			3'd4: d_out = {d_in[3:0], d_in[7:4]};
			3'd5: d_out = {d_in[2:0], d_in[7:3]};
			3'd6: d_out = {d_in[1:0], d_in[7:2]};
			3'd7: d_out = {d_in[0], d_in[7:1]};
			default: d_out = d_in; // case 0  
		endcase
	end	
endmodule//left_rotator
