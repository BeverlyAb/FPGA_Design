`timescale 1ns / 1ps
 
//
//////////////////////////////////////////////////////////////////////////////////
module double_UART(
	input wire clk, reset, rx,
	input wire [7:0] din,
	output wire [7:0] dout,
	output wire err, tx
    );

	wire tx_full, rx_empty, btn_tick;
   wire [7:0] rec_data, rec_data1;

	uart_with_parity
   #( // Default setting:
      // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
      .DBIT(8),
      .SB_TICK(16), // # ticks for stop bits, 16/24/32
                              // for 1/1.5/2 stop bits
      .DVSR(163),   // baud rate divisor
                              // DVSR = 50M/(16*baud rate)
      .DVSR_BIT(8), // # bits of DVSR
      .FIFO_W(2)    // # addr bits of FIFO
                              // # words in FIFO=2^FIFO_W
   ) one
   (
    .clk(clk), .reset(reset),
    .rd_uart(), .wr_uart(), .rx(),
    .w_data(), // 8'b
    .tx_full(), .rx_empty(), .tx(), error(), // output
    .r_data() // 8'b
   );
	

	uart_with_parity
   #( // Default setting:
      // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
      .DBIT(8),
      .SB_TICK(16), // # ticks for stop bits, 16/24/32
                              // for 1/1.5/2 stop bits
      .DVSR(163),   // baud rate divisor
                              // DVSR = 50M/(16*baud rate)
      .DVSR_BIT(8), // # bits of DVSR
      .FIFO_W(2)    // # addr bits of FIFO
                              // # words in FIFO=2^FIFO_W
   ) one
   (
    .clk(clk), .reset(reset),
    .rd_uart(), .wr_uart(), .rx(),
    .w_data(), // 8'b
    .tx_full(), .rx_empty(), .tx(), error(), // output
    .r_data() // 8'b
   );
	
endmodule
