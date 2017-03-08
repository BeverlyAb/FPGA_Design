`timescale 1ns / 1ps

// 
////////////////////////////////////////////////////////////////////////////////

module uart_test_sim;

	// Inputs
	reg clk;
	reg reset;
	reg rd_uart;
	reg wr_uart;
	reg rx;
	reg [7:0] w_data;

	// Outputs
	wire tx_full;
	wire rx_empty;
	wire tx;
	wire [7:0] r_data;

	// Instantiate the Unit Under Test (UUT)
	uart uut (
		.clk(clk), 
		.reset(reset), 
		.rd_uart(rd_uart), 
		.wr_uart(wr_uart), 
		.rx(rx), 
		.w_data(w_data), 
		.tx_full(tx_full), 
		.rx_empty(rx_empty), 
		.tx(tx), 
		.r_data(r_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		rd_uart = 0;
		wr_uart = 0;
		rx = 0;
		w_data = 0;
	
		#1 w_data = 8'b11111111;
		rx = 1;
		wr_uart = 1;
		
		#1wr_uart = 1;
		 rd_uart = 0;
		
		#1rd_uart = 0;

	end
	initial begin:stop
		#60 $stop;
	end
	initial begin:clock
		forever #1 clk = ~clk;
	end
      
endmodule

