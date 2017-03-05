`timescale 1ns / 1ps
// Polynomial: 		f(n) = 2n**2 + 3n + 5 
// Differ. Engine:	f(n) = 5, if n = 0,
//							f(n) = f(n-1) + g(n), if n > 0, 
//							g(n) = 5, if n = 1,
//							g(n) = g(n-1) + g(n), if n > 1
//////////////////////////////////////////////////////////////////////////////////
module Difference_Engine(
	input wire [5:0] n, //max n = 2**6 - 1
	input wire start, clk, reset,
	output reg [12:0] data_out, //max data_out = f(n), so max bits is log base 2 of f(n)
	output reg done_tick
    );
	 localparam [1:0]	IDLE = 2'b00,
							OPERATE = 2'b01,
							DONE = 2'b10;
	//state reg
	reg [1:0] current_state, next_state;
	//data reg
	reg [5:0] current_i, next_i;  // matches # of bits in n
	reg [12:0] current_f, next_f; // matches # of bits in data_out
	reg [12:0] current_g, next_g; // arbritarily matches # bits in data_out		

	initial current_state = IDLE;
	//current state sequential
	always @ (posedge clk, posedge reset) begin
		if(reset) begin
			current_state <= IDLE;
			current_i <= 0;
			current_f <= 0; //CHECK THIS. Should I start at f(0) and g(1) ?
			current_g <= 0;
		end 
		else begin
			current_state <= next_state;
			current_i <= next_i;
			current_f <= next_f;
			current_g <= next_g;
		end
	end
	//next state  combinational
	always @ * begin
		next_state = current_state;
		next_i = current_i;
		next_f = current_f;
		next_g = current_g;
		done_tick = 0; // don't forget output signal instantiation
		data_out = 0;
		case(current_state) 
			IDLE: begin 
				next_i = 0;
				next_f = 0;
				next_g = 5;
				next_state = (start) ? OPERATE : IDLE;
			end
			OPERATE:begin
				if(current_i == 0) begin
					next_f = 5; //CHECK THIS LOGIC
					next_i = current_i + 1;
				end
				else if(current_i == 1) begin
					next_g = 5;
					next_f = current_f + current_g; //CHECK THIS LOGIC
					next_i = current_i + 1;
				end
				else begin//(current_i > 1) begin
					next_g = current_g + 4;	
					next_f = current_f + next_g; //CHECK THIS LOGIC
					next_i = current_i + 1;
				end
				next_state = (current_i == n) ? DONE : OPERATE;
			end
			DONE: begin
				done_tick = 1;
				next_state = IDLE;
				data_out = current_f;
			end
			default: next_state = IDLE;
		endcase
	end
endmodule
