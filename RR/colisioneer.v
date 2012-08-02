`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:19:15 07/04/2012 
// Design Name: 
// Module Name:    colisioneer 
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
module colisioneer(
  	input [7:0] position_1_x, 
	input [9:0] position_1_y,
  	input [7:0] position_2_x, 
	input [9:0] position_2_y,
	output wire colision
   );
	
	localparam 
		CAR_WIDTH = 16,
		CAR_HEIGHT = 32;
		
	wire [7:0] left_bound_1;
	wire [9:0] upper_bound_1;
	wire [7:0] right_bound_1;
	wire [9:0] lower_bound_1;
	assign left_bound_1 = position_1_x;
	assign upper_bound_1 = position_1_y;
	assign right_bound_1 = position_1_x + 16;
	assign lower_bound_1 = position_1_y + 32;

	wire [7:0] left_bound_2;
	wire [9:0] upper_bound_2;
	wire [7:0] right_bound_2;
	wire [9:0] lower_bound_2;
	assign left_bound_2 = position_2_x;
	assign upper_bound_2 = position_2_y;
	assign right_bound_2 = position_2_x + 16;
	assign lower_bound_2 = position_2_y + 32;
	
	assign colision = (( lower_bound_2 >= lower_bound_1 && lower_bound_1 >= upper_bound_2 ) ||
							( lower_bound_2 >= upper_bound_1 && upper_bound_1 >= upper_bound_2 )) &&
							(( right_bound_2 >= left_bound_1 && left_bound_1 >= left_bound_2 ) ||
							( right_bound_2 >= right_bound_1 && right_bound_1 >= left_bound_2 ));

endmodule
