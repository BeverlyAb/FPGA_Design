`timescale 1ns / 1ps
//
//////////////////////////////////////////////////////////////////////////////////
module PLOC_Machine(
	input wire a,b,clk,reset,
	output reg [1:0] inc_dec
    );
	 //7 states including enter, exit, and error
	localparam [3:0]	START 	= 3'b000,
							A_TRIG 	= 3'b001,
							B_TRIG 	= 3'b010,
							AB_IN 	= 3'b011,
							AB_OUT 	= 3'b100,
							ENTER 	= 3'b101,
							EXIT 		= 3'b110,
							INVALID 	= 3'b111;
   
	localparam [1:0]	INC = 2'b10,
							DEC = 2'b01,
							IDLE = 2'b00,
							ERR = 2'b11;
							
	reg [2:0] current_state, next_state;						
	initial current_state = START;
	
	//current_state sequential logic						
	always @ (posedge clk) begin
		if(reset)
			current_state <= START;
		else
			current_state <= next_state;
	end
	//next_state combinational logic
	always @ * begin
		next_state = current_state;
		case(current_state)
				START:	if (a&~b) next_state = A_TRIG;
							else if (~a&b) next_state = B_TRIG;
							else if (a&b) next_state = INVALID; // else keep next_state remains the same
							
				A_TRIG:	if (~a&~b) next_state = START;
							else if (a&b) next_state = AB_IN;
							else if (~a&b) next_state = INVALID;
				
				B_TRIG:	if (~a&~b) next_state = START;
							else if (a&b) next_state = AB_OUT;
							else if (a&~b) next_state =INVALID;
				
				AB_IN: 	next_state = ENTER;
				AB_OUT:	next_state = EXIT;
				
				ENTER:	if (a&~b) next_state = AB_OUT;
							else if (~a&b) next_state = B_TRIG;
							else if (~a&~b) next_state = INVALID;
				
				EXIT:		if(~a&b) next_state = AB_IN;
							else if (a&~b) next_state = A_TRIG;
							else if (~a&~b) next_state =INVALID;
				
				INVALID:	next_state = START;
				default: next_state =START;
		endcase
	end

	//Moore output combinational logic
	always @ * begin
		case (current_state)
			AB_IN: inc_dec = INC;
			AB_OUT: inc_dec = DEC;
			INVALID: inc_dec = ERR;
			default: inc_dec = IDLE;
		endcase
	end
endmodule
