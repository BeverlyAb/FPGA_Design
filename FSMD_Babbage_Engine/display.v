`timescale 1ns / 1ps

/* Used this as reference:
 http://simplefpga.blogspot.com/2012/07/00-to-99-two-digit-decimal-counter-via.html
//////////////////////////////////////////////////////////////////////////////////*/
module display(
	 input clk,
	 input [12:0] data,
	 output [7:0] sseg,
    output [3:0]an
    );

localparam [7:0] D_ZERO = 8'b11000000, //0
   				 D_ONE = 8'b11111001, //1
   					D_TWO = 8'b10100100, //2
  			 			D_THREE = 8'b10110000, //3
   					D_FOUR = 8'b10011001, //4
   					D_FIVE = 8'b10010010, //5
   					D_SIX = 8'b10000010, //6
   					D_SEVEN = 8'b11111000, //7
   					D_EIGHT = 8'b10000000, //8
   					D_NINE = 8'b10010000;//9
   				//	DASH = 8'b10111111; //dash

localparam [3:0] ZER0 = 4'd0;
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

//internal signals
reg [3:0] ones, next_ones; 		//register for the ones digit
reg [3:0] tens, next_tens; 		//register for the tens digit
reg [3:0] hundreds, next_hun;	  //register for the hundreds digit
reg [3:0] thousands, next_thou; //register for the thousands digit

//reg [1:0] roll_count; Think about using this
//reg current_state, next_state;

always @ (posedge clk) begin
//	current_state <= next_state;
	ones <= data[3:0];
	tens <= data[7:4];
	hundreds <= data[11:8];
	thousands <= data[12];
end	
	
always @ (*) begin
//	next_sate = current_state;
	next_ones = ones;
	next_tens = tens;
	next_hun = hundreds;
	next_thou = thousands;
	
	case(ones)
		an = DISP_0;
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
		
	case(tens)
		an = DISP_1;
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
	
	
	case(hundreds)
		an = DISP_2;
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
	
	
	case(thousands)
		an = DISP_3;
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
endmodule