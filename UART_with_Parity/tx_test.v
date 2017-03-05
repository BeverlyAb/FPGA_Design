`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:29:31 03/02/2017
// Design Name:   uart_tx
// Module Name:   C:/Users/Beverly/Desktop/CSE_classes/CSE_521/UART/UART_with_Parity/tx_test.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_tx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tx_test;

	// Inputs
	reg clk;
	reg reset;
	reg tx_START;
	reg s_tick;
	reg [7:0] din;

	// Outputs
	wire tx_done_tick;
	wire tx_parity;
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	uart_tx uut (
		.clk(clk), 
		.reset(reset), 
		.tx_START(tx_START), 
		.s_tick(s_tick), 
		.din(din), 
		.tx_done_tick(tx_done_tick), 
		.tx_parity(tx_parity), 
		.tx(tx)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		tx_START = 1;
		s_tick = 0;
		din = 0;
		
		#10 din = 8'b11111111;

	end
      
	initial begin:stop
		#20 $stop;
	end
	initial begin:clock
		forever #1 clk = ~clk;
	end
endmodule

