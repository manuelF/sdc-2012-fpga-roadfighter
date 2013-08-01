`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:08 06/15/2012 
// Design Name: 
// Module Name:    main 
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
module main(
    input wire clk, reset,
    output wire [2:0] rgb,
	 output wire hsync, 
	 output wire vsync
   );

	localparam [2:0]
		NEGRO 	= 3'b000,
		AZUL		= 3'b001,
		VERDE		= 3'b010,
		CYAN		= 3'b011,
		ROJO		= 3'b100,
		MAGENTA	= 3'b101,
		AMARILLO = 3'b110,
		BLANCO	= 3'b111;

	wire video_on;
	wire [9:0] pixel_x, pixel_y;

	vga_sync vga (
		.clk(clk),.reset(reset),
		.hsync(hsync),.vsync(vsync),
		.video_on(video_on),.p_tick(), 
		.pixel_x(pixel_x),.pixel_y(pixel_y));

	localparam STREAM_CENTER = 250;
	localparam STREAM_OSC = 30;
	localparam STREAM_WIDTH = 63;
	localparam STREAM_LENGTH = 256;

	wire [7:0] offset_index;
	assign offset_index = pixel_y[7:0]; 
	
	wire [5:0] offset;
	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	river_offsets your_instance_name (
	  .clka(clk), // input clka
	  .addra(offset_index), // input [7 : 0] addra
	  .douta(offset) // output [5 : 0] douta
	);
	// INST_TAG_END ------ End INSTANTIATION Template ---------

	
	reg [2:0] rgb_reg;
		
	wire [9:0] stream_pos;
	assign stream_pos = STREAM_CENTER - STREAM_OSC + offset;
	
	always @(posedge clk)
		if(pixel_x >= stream_pos && pixel_x <= stream_pos+STREAM_WIDTH)
			rgb_reg <= AZUL;
		else
			rgb_reg <= NEGRO;
	
	assign rgb = (video_on ) ? rgb_reg : 3'b0;
	
endmodule
