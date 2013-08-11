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
    output is_on, 
	 output is_on_foam
    );

	localparam STREAM_CENTER = 110;
	localparam STREAM_OSC = 30;
	localparam STREAM_WIDTH = 90;
	localparam STREAM_LENGTH = 512;
	localparam WINDOW_HEIGHT = 512;
	
	wire [6:0] offset;

	reg [9:0] shift_reg;
	wire [9:0] shift_val;

	reg [9:0] window_offset_reg;
	wire [9:0] window_offset;
	
	always @(posedge clk, posedge reset)
		if(reset) begin
			shift_reg <= 0;
			window_offset_reg <= 0;
		end else if(update_signal) begin
			if(shift_val == 0)
				shift_reg <= STREAM_LENGTH-1;
			else
				shift_reg <= shift_val -1;

			if(window_offset == WINDOW_HEIGHT)
				window_offset_reg <= 0;
			else
				window_offset_reg <= window_offset + 1;
		end

	assign shift_val = shift_reg;
	assign window_offset = window_offset_reg;
	
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
	
	// FOAMS
	localparam FOAM_WIDTH = 5;
	
	localparam FOAM1_STARTY = 0;
	localparam FOAM1_ENDY = 200;
	localparam FOAM1_STARTX = 75;
	
	localparam FOAM2_STARTY = 390; //240;
	localparam FOAM2_ENDY = 480; //370;
	localparam FOAM2_STARTX = 40;

	localparam FOAM3_STARTY = 240; // 420;
	localparam FOAM3_ENDY = 370; // 480;
	localparam FOAM3_STARTX = 20;
		
	wire [9:0] stream_pos;
	assign stream_pos = STREAM_CENTER - STREAM_OSC + offset;
	wire [9:0] yp = (pixel_y+window_offset)%WINDOW_HEIGHT;
	
	assign is_on = pixel_x >= stream_pos && pixel_x <= stream_pos+STREAM_WIDTH;
	assign is_on_foam = 
		((pixel_x >= stream_pos+FOAM1_STARTX && pixel_x <= stream_pos + FOAM1_STARTX + FOAM_WIDTH) &&
			yp >= FOAM1_STARTY && yp<= FOAM1_ENDY) ||
		((pixel_x >= stream_pos+FOAM2_STARTX && pixel_x <= stream_pos + FOAM2_STARTX + FOAM_WIDTH) &&
			yp >= FOAM2_STARTY && yp<= FOAM2_ENDY) ||
		((pixel_x >= stream_pos+FOAM3_STARTX && pixel_x <= stream_pos + FOAM3_STARTX + FOAM_WIDTH) &&
			yp >= FOAM3_STARTY && yp<= FOAM3_ENDY);
			
endmodule
