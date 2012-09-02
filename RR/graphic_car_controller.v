`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:37:42 06/15/2012 
// Design Name: 
// Module Name:    graphic_car_controller 
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

// Cuando me entra el update seteo la posicion del auto con lo que
// hay en car_position
module graphic_car_controller(
	input [7:0] car_position_x, 
	input [9:0] car_position_y,
	input [9:0] pixel_x, pixel_y,	
	output [2:0] rgb,
	output wire on,
	input [2:0] owner,
	input reset, input pclk
   );
	
	localparam 
		CAR_WIDTH = 16,
		CAR_HEIGHT = 32;
		
	wire [7:0] left_bound;
	wire [9:0] upper_bound;

	assign left_bound = car_position_x;
	assign upper_bound = car_position_y;
	
	wire [7:0] right_bound;
	wire [9:0] lower_bound;

	wire [3:0] local_pixel_x; // ancho 16
	wire [4:0] local_pixel_y; // ancho 32
	
	assign right_bound = car_position_x + CAR_WIDTH;
	assign lower_bound = car_position_y + CAR_HEIGHT;
	
	assign local_pixel_x = pixel_x[7:0] - left_bound;
	assign local_pixel_y = pixel_y - upper_bound;

	wire on_road = pixel_x[9:8] == 2'b01;
		
	// block ram
	//reg [3:0] car_draw [8:0]; //(3)*(16*32) [ = (3)*(2^5) ]

	localparam [2:0]
		NEGRO 	= 3'b000,
		AZUL		= 3'b001,
		VERDE		= 3'b010,
		CYAN		= 3'b011,
		ROJO		= 3'b100,
		MAGENTA	= 3'b101,
		AMARILLO = 3'b110,
		BLANCO	= 3'b111;

	// output
	reg [2:0] rgb_reg;
	wire[CAR_WIDTH*3 -1:0] car_line;
	
	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
car_bitmap autito (
  .clka(pclk), // input clka
  .addra((owner*32)+local_pixel_y), // input [4 : 0] addra
  .douta(car_line) // output [47 : 0] douta
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

	assign rgb[2]=car_line[local_pixel_x*3+2];
	assign rgb[1]=car_line[local_pixel_x*3+1];
	assign rgb[0]=car_line[local_pixel_x*3+0];

	assign on = on_road && ( 
		right_bound >= pixel_x[7:0] && pixel_x[7:0] >= left_bound && 
		pixel_y <= lower_bound && pixel_y >= upper_bound ) && rgb != 3'b000;

endmodule
