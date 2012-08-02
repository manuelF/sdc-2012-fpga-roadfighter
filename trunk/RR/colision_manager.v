`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:29:38 07/04/2012 
// Design Name: 
// Module Name:    colisionManager 
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
module colisionManager
(
	 input [7:0]position_0_x,
	 input [9:0]position_0_y,
    input [7:0]position_1_x,
	 input [9:0]position_1_y,
	 input [7:0]position_2_x,
	 input [9:0]position_2_y,
	 input [7:0]position_3_x,
	 input [9:0]position_3_y,
	 input [7:0]position_4_x,
	 input [9:0]position_4_y,
	 input [7:0]position_5_x,
	 input [9:0]position_5_y,
	 input [7:0]position_player_x,
	 input [9:0]position_player_y,
	 output colision
);
	 
	wire colision_0, colision_1, colision_2, colision_3, colision_4, colision_5;
	
	colisioneer col_0 (.position_1_x(position_0_x), .position_1_y(position_0_y), 
							 .position_2_x(position_player_x), .position_2_y(position_player_y),
							 .colision(colision_0));
	colisioneer col_1 (.position_1_x(position_1_x), .position_1_y(position_1_y), 
							 .position_2_x(position_player_x), .position_2_y(position_player_y),
							 .colision(colision_1) );
	colisioneer col_2 (.position_1_x(position_2_x), .position_1_y(position_2_y), 
							 .position_2_x(position_player_x), .position_2_y(position_player_y),
							 .colision(colision_2));						 
	colisioneer col_3 (.position_1_x(position_3_x), .position_1_y(position_3_y), 
							 .position_2_x(position_player_x), .position_2_y(position_player_y),
							 .colision(colision_3));
	colisioneer col_4 (.position_1_x(position_4_x), .position_1_y(position_4_y), 
							 .position_2_x(position_player_x), .position_2_y(position_player_y),
							 .colision(colision_4));
	colisioneer col_5 (.position_1_x(position_5_x), .position_1_y(position_5_y), 
							 .position_2_x(position_player_x), .position_2_y(position_player_y),
							 .colision(colision_5));
							 
	assign colision = colision_0 || colision_1 || colision_2 || colision_3 || colision_4 || colision_5;
	
endmodule
