`timescale 1ns / 1ps
// Moore machine of a lit square rotating every clock cycle (clk)
// across the four seven segment (sseg) display. en halts or resumes the process.
// cw, makes the square rotate clockwise or counter-clockwise. an enables one 
// of the four sseg outputs its value. Using this Finite State Machine (FSM), the
// square retains its position even after the en or cw switch is toggled.    
//////////////////////////////////////////////////////////////////////////////////
module RSC(
	input wire clk, cw, en,
	output reg [3:0] an,
	output reg [7:0] sseg
    );
	 // 8 different states
	 localparam [2:0]	ZERO_BOT	= 3'd0,
							ONE_BOT 	= 3'd1,
							TWO_BOT	= 3'd2,
							THREE_BOT= 3'd3,
							ZERO_TOP	= 3'd4,
							ONE_TOP 	= 3'd5,
							TWO_TOP	= 3'd6,
							THREE_TOP= 3'd7;
	// 4 sseg display and 1 off, where none of the sseg displays its value
	localparam [3:0]	DISP_0 = 4'b1110,
							DISP_1 = 4'b1101,
							DISP_2 = 4'b1011,
							DISP_3 = 4'b0111,
							OFF =		4'b1111;
	// display for square top or bottom
	localparam [7:0]	BOT = 8'b11100010,
							TOP = 8'b10011100;

	// internal signals						
	reg [2:0] state_reg, state_next;

	initial state_reg = ZERO_TOP; //ABSOLUTELY necessary in order for FPGA display to work
	
	// current state sequential
	always @ (posedge clk) begin 
		if(en)  
			state_reg <= state_next; 
	end
	
	// next state and Moore output combinational
	always @ * begin
		state_next = state_reg;
		case(state_reg)
			ZERO_BOT: begin
				an = DISP_0;
				sseg = BOT;
				state_next = (cw) ? ONE_BOT: ZERO_TOP; 
			end
			ONE_BOT: begin
				an = DISP_1;
				sseg = BOT;
				state_next = (cw) ? TWO_BOT: ZERO_BOT; 
			end
			TWO_BOT: begin
				an = DISP_2;
				sseg = BOT;
				state_next = (cw) ? THREE_BOT: ONE_BOT; 
			end
			THREE_BOT: begin
				an = DISP_3;
				sseg = BOT;
				state_next = (cw) ? THREE_TOP: TWO_BOT; 
			end
			THREE_TOP:begin
				an = DISP_3;
				sseg = TOP;
				state_next = (cw) ? TWO_TOP: THREE_BOT; 
			end
			TWO_TOP:begin
				an = DISP_2;
				sseg = TOP;
				state_next = (cw) ? ONE_TOP: THREE_TOP; 
			end
			ONE_TOP:begin
				an = DISP_1;
				sseg = TOP;
				state_next = (cw) ? ZERO_TOP: TWO_TOP; 
			end
			ZERO_TOP:begin
				an = DISP_0;
				sseg = TOP;
				state_next = (cw) ? ZERO_BOT: ONE_TOP; 
			end
			default: begin
				state_next = ZERO_BOT; // might be redundant because state_next is defined before the case statement
				an = OFF;
				sseg = BOT;
			end
		endcase	
	end		
endmodule //RSC
