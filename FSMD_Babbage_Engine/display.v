`timescale 1ns / 1ps

/////////////////////////////////////////////////////////////////////////////////*/
module display(
	 input wire clk, done_tick,
	 input wire [12:0] data,
	 output reg [7:0] sseg,
    output reg [3:0]an
    );

	localparam [7:0]	D_ZERO = 8'b100000001, //0
							D_ONE = 8'b11001111, //1
							D_TWO = 8'b10010010, //2
							D_THREE = 8'b10000110, //3
							D_FOUR = 8'b11001100, //4
							D_FIVE = 8'b10100100, //5
							D_SIX = 8'b101000000, //6
							D_SEVEN = 8'b10001111, //7
							D_EIGHT = 8'b10000000, //8
							D_NINE = 8'b10000100;//9
						//	DASH = 8'b10111111; //dash

	localparam [3:0] ZERO = 4'd0,
						  ONE = 4'd1,
						  TWO = 4'd2,
						  THREE = 4'd3,
						  FOUR = 4'd4,
						  FIVE = 4'd5,
						  SIX = 4'd6,
						  SEVEN = 4'd7,
						  EIGHT = 4'd8,
						  NINE = 4'd9;
						  
	localparam [3:0]	DISP_0 = 4'b1110,
							DISP_1 = 4'b1101,
							DISP_2 = 4'b1011,
							DISP_3 = 4'b0111,
							OFF    = 4'b1111;

	localparam [1:0]	ONES_DIGIT = 2'b00,
							TENS_DIGIT = 2'b01,
							HUND_DIGIT = 2'b10,
							THOU_DIGIT = 2'b11;

	//internal signals
	reg [3:0] ones, next_ones; 		//register for the ones digit
	reg [3:0] tens, next_tens; 		//register for the tens digit
	reg [3:0] hundreds, next_hun;	  //register for the hundreds digit
	reg [3:0] thousands, next_thou; //register for the thousands digit

	//reg [1:0] roll_count; Think about using this
	reg [1:0] current_state, next_state;

	//instantiate
	initial current_state = ONES_DIGIT;
	
	always @ (posedge clk) begin
		if(done_tick) begin
			ones <= data[3:0];
			tens <= data[7:4];
			hundreds <= data[11:8];
			thousands <= data[12];
			current_state <= next_state;
		end 
		//else
		//	current_state <= next_state;
	end	
		
	always @ (*) begin
		next_state = current_state;
		next_ones = ones;
		next_tens = tens;
		next_hun = hundreds;
		next_thou = thousands;
		
		case(current_state)
			ONES_DIGIT: begin
				an = DISP_0;
				next_state = TENS_DIGIT;
				case(ones)
					ZERO: sseg = D_ZERO;
					ONE: sseg = D_ONE;
					TWO: sseg = D_TWO;
					THREE: sseg = D_THREE;
					FOUR: sseg = D_FOUR;
					FIVE: sseg = D_FIVE;
					SIX: sseg = D_SIX;
					SEVEN: sseg = D_SEVEN;
					EIGHT: sseg = D_EIGHT;
					NINE: sseg = D_NINE;
				endcase
			end
			
			TENS_DIGIT: begin
				an = DISP_1;
				next_state = HUND_DIGIT;
				case(tens)
					ZERO: sseg = D_ZERO;
					ONE: sseg = D_ONE;
					TWO: sseg = D_TWO;
					THREE: sseg = D_THREE;
					FOUR: sseg = D_FOUR;
					FIVE: sseg = D_FIVE;
					SIX: sseg = D_SIX;
					SEVEN: sseg = D_SEVEN;
					EIGHT: sseg = D_EIGHT;
					NINE: sseg = D_NINE;
				endcase
			end
			
			HUND_DIGIT: begin
				an = DISP_2;
				next_state = THOU_DIGIT;
				case(hundreds)
					ZERO: sseg = D_ZERO;
					ONE: sseg = D_ONE;
					TWO: sseg = D_TWO;
					THREE: sseg = D_THREE;
					FOUR: sseg = D_FOUR;
					FIVE: sseg = D_FIVE;
					SIX: sseg = D_SIX;
					SEVEN: sseg = D_SEVEN;
					EIGHT: sseg = D_EIGHT;
					NINE: sseg = D_NINE;
				endcase
			end	
				
			THOU_DIGIT: begin
				an = DISP_3;
				next_state = ONES_DIGIT;
				case(thousands)
					ZERO: sseg = D_ZERO;
					ONE: sseg = D_ONE;
					TWO: sseg = D_TWO;
					THREE: sseg = D_THREE;
					FOUR: sseg = D_FOUR;
					FIVE: sseg = D_FIVE;
					SIX: sseg = D_SIX;
					SEVEN: sseg = D_SEVEN;
					EIGHT: sseg = D_EIGHT;
					NINE: sseg = D_NINE;
				endcase
			end
			default: begin
				next_state = ONES_DIGIT;
				next_ones = D_ZERO;
				next_tens = D_ZERO;
				next_hun = D_ZERO;
				next_thou = D_ZERO;
			end
		endcase
	end
	
endmodule