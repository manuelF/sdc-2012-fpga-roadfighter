`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:23 08/01/2013 
// Design Name: 
// Module Name:    river_drawer 
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
module river_drawer(
    input [9:0] pixel_x,
    input [9:0] pixel_y,
    input clk, input reset,
	 input update_signal,
    output is_on
    );

	localparam STREAM_CENTER = 120;
	localparam STREAM_OSC = 30;
	localparam STREAM_WIDTH = 90;
	localparam STREAM_LENGTH = 512;
	
	wire [6:0] offset;

	reg [9:0] shift_reg;
	wire [9:0] shift_val;

	always @(posedge clk, posedge reset)
		if(reset)
			shift_reg <= 0;
		else if(update_signal)
			if(shift_val == 0)
				shift_reg <= STREAM_LENGTH-1;
			else
				shift_reg <= shift_val -1;

	assign shift_val = shift_reg;
	
	wire [9:0] total_offset;
	assign total_offset = shift_val + pixel_y;

	wire [7:0] offset_index;
	assign offset_index = total_offset[7:0]; 

	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	river_offsets your_instance_name (
	  .clka(clk), // input clka
	  .addra(offset_index), // input [7 : 0] addra
	  .douta(offset) // output [5 : 0] douta
	);
	// INST_TAG_END ------ End INSTANTIATION Template ---------
		
	wire [9:0] stream_pos;
	assign stream_pos = STREAM_CENTER - STREAM_OSC + offset;
	
	assign is_on = pixel_x >= stream_pos && pixel_x <= stream_pos+STREAM_WIDTH;
	
endmodule
