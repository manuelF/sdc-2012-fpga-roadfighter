`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:37:42 06/15/2012 
// Design Name: 
// Module Name:    graphic_letter_controller 
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
// hay en letter_position
module graphic_letter_controller(
	/*input [7:0] letter_position_x, 
	input [9:0] letter_position_y,
	input [9:0] pixel_x, pixel_y,*/
	input [5:0] score,
	output [2:0] rgb
   );
	
	localparam 
		LETTER_WIDTH = 5,
		LETTER_HEIGHT = 5;
		
	wire on_road = pixel_x[9:8] == 2'b01;
	
	wire [7:0] left_bound;
	wire [9:0] upper_bound;

	assign left_bound = letter_position_x;
	assign upper_bound = letter_position_y;
	
	wire [7:0] right_bound;
	wire [9:0] lower_bound;

	wire [3:0] local_pixel_x; // ancho 5
	wire [4:0] local_pixel_y; // ancho 5
	
	assign right_bound = letter_position_x + LETTER_WIDHT;
	assign lower_bound = letter_position_y + LETTER_HEIGHT;
	
	assign local_pixel_x = pixel_x[7:0] - left_bound;
	assign local_pixel_y = pixel_y - upper_bound;
	
/*	assign on = on_road && ( 
		right_bound >= pixel_x[7:0] && pixel_x[7:0] >= left_bound && 
		pixel_y <= lower_bound && pixel_y >= upper_bound );
	*/
	// block ram
	//reg [3:0] letter_draw [8:0]; //(3)*(16*32) [ = (3)*(2^5) ]

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
	always @*
	begin
		if((local_pixel_x >= 6 && local_pixel_x <= 7) ||
			(local_pixel_x >= 10 && local_pixel_x <= 11))

			rgb_reg = BLANCO;
		else if((local_pixel_x <= 3 || local_pixel_x >= 14) &&
				  local_pixel_y <= 3)
				  
			rgb_reg = AMARILLO;
		else
			rgb_reg = ROJO;
	end
	assign rgb[2:0] = rgb_reg; //3'b100;//letter_draw[on && {local_pixel_y;local_pixel_x}];
	
endmodule
