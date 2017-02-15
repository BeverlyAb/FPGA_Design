`timescale 1ns / 1ps
//Implements rotating square circuit onto FPGA Spartan-3. 
////////////////////////////////////////////////////////////////////////////////

module FPGA_RSC(
	input wire clk,  
	input wire [1:0] sw, //en and cw
	output wire [3:0] an,
	output wire [6:0] sseg
   );

	//internal signal
	wire fq_out, BUFG_out;

	freq_divider fq1(
		.clk(clk),
		.longer_clk(fq_out)
		);
	
	//removes low skew warning from freq_divider
	BUFG clk1_bufg (
		.I (fq_out), 
		.O (BUFG_out)
		);	

  // instantiate 7-seg LED display module
   RSC rsc1(
		.clk(BUFG_out),
		.en(sw[1]),
		.cw(sw[0]),
		.an(an),
		.sseg(sseg)
		);

endmodule
