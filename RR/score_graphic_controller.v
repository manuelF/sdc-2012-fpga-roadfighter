`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:54:27 08/12/2012 
// Design Name: 
// Module Name:    score_graphic_controller 
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
module score_graphic_controller(
    input pclk,
	 input [9:0] pixel_x,
    input [9:0] pixel_y,
	 input [9:0] xcoord_ini,
	 input [9:0] ycoord_ini,
    output [2:0] rgb,
	 output on
    );

	wire [131:0] score_line;
	wire [3:0] score_pixel_y;
	wire [7:0] score_pixel_x; 	
	assign score_pixel_y = (pixel_y <= 40+12 && pixel_y >= 40 ) ? pixel_y-40 : 0;

	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	score_bitmap score_memory(
	  .clka(pclk), // input clka
	  .addra(score_pixel_y), // input [3 : 0] addra
	  .douta(score_line) // output [131 : 0] douta
	);
	// INST_TAG_END ------ End INSTANTIATION Template ---------
	
	assign score_pixel_x = (pixel_x <= 43) ? pixel_x : 0;
		
	assign rgb[2]=score_line[score_pixel_x*3+2];
	assign rgb[1]=score_line[score_pixel_x*3+1];
	assign rgb[0]=score_line[score_pixel_x*3+0];
	
	assign on = (pixel_y <= ycoord_ini+11 && pixel_y >= ycoord_ini && 
					 pixel_x <= xcoord_ini+43 && pixel_x >= xcoord_ini);
endmodule
