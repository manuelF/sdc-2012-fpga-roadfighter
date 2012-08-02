`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:04:28 05/09/2012 
// Design Name: 
// Module Name:    flank_detector 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module flank_detector(
	input bt_in,
	input clk,
	input reset,
	output reg bt_out
	);

	reg bt_reg;

	always@ (posedge clk, posedge reset)
		if (reset)
			bt_reg <= 0;
		else
		begin
			bt_out <= bt_in && ~bt_reg;
			bt_reg <= bt_in;
		end
	
endmodule
