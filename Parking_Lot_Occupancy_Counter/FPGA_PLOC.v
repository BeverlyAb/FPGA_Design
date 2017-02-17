`timescale 1ns / 1ps

//
//////////////////////////////////////////////////////////////////////////////////
module FPGA_PLOC(
	input wire clk,reset,
	input wire [1:0] sw, // reset, a, and b
	output wire [3:0] an,
	output wire [7:0] sseg
    );
	//internal signal
	wire [1:0] P_M_out;
	wire [3:0] count_out;

	PLOC_Machine P_M(
		.clk(clk), //in
		.reset(reset),
		.a(sw[1]),
		.b(sw[0]),
		.inc_dec(P_M_out)
	);
	
	Occupancy_Counter OC(
		.clk(clk),	// in
		.reset(reset),
		.inc_dec(P_M_out),
		.count(count_out) //out
	);
	
	 disp_hex_mux disp_unit(	
		 .clk(clk), .reset(1'b0),
       		.hex3(4'd0), .hex2(4'd0), .hex1(4'd0), .hex0(count_out),
       		.dp_in(4'b1111), .an(an), .sseg(sseg)
	 );
	
endmodule
