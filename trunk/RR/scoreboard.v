`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:16 08/26/2012 
// Design Name: 
// Module Name:    scoreboard 
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

//Dibuja el scoreboard empezando desde la posicion indicada por ini_xcoord e ini_ycoord
//Empieza en cero.
module scoreboard_display(
	input [9:0] xcoord, ycoord, xcoord_ini, ycoord_ini,
	input clk, reset, 
	output on,
	output [2:0] rgb
	);
	
	localparam 	MAX_DIGITS = 6,
					DIGIT_CONT = 4;

	wire [DIGIT_CONT-1:0] score [MAX_DIGITS-1:0];
	/*
	assign score[0] = 1;
	assign score[1] = 2;
	assign score[2] = 7;
	assign score[3] = 3;
	assign score[4] = 4;
	assign score[5] = 5;	
	*/
	/**************************************************************************
							BEGIN DIGIT COUNTER WITH PROPAGATION
	**************************************************************************/

	genvar i;
	wire [MAX_DIGITS:0] ups;
	
	reg [26:0] div_reg, div_next;
	reg tick_reg, tick_next;
	
	localparam TICK = 26'd25000000;

	always @(posedge clk, posedge reset)
		if(reset)
			begin
				div_reg <= 0;
				tick_reg <= 0;
			end
		else
			begin
				div_reg <= div_next;
				tick_reg <= tick_next;
			end
			
	always @*
		if(div_reg == TICK)
			begin
				div_next = 0;
				tick_next = 1;
			end
		else
			begin
				div_next = div_reg+1;
				tick_next = 0;
			end

	assign ups[0] = tick_reg;
	generate
		for(i = 0; i < MAX_DIGITS; i = i+1)
			begin: dec_counter_gen
				dec_counter dec_counter_inst (
					 .clk(clk),.reset(reset),.up(ups[i]),
					 .over(ups[i+1]), .value(score[i])
				 );
			end
	endgenerate

	/**************************************************************************
							END DIGIT COUNTER WITH PROPAGATION
	**************************************************************************/
	
	/**************************************************************************
							BEGIN NUMBER DISPLAY MODULE
	**************************************************************************/

	wire [9:0] xcoord_rel, ycoord_rel;
	wire on_position, on_digit;

	wire [9:0] xcoord_digit, ycoord_digit;
	
	localparam	DIGIT_WIDTH = 8, DIGIT_HEIGHT = 7;
	localparam  SCOREBOARD_WIDTH = MAX_DIGITS*DIGIT_WIDTH,
					SCOREBOARD_HEIGHT = DIGIT_HEIGHT;
	
	assign xcoord_rel = xcoord - xcoord_ini;
	assign ycoord_rel = ycoord - ycoord_ini;

	assign on_position = 
			xcoord >= xcoord_ini && xcoord < xcoord_ini + SCOREBOARD_WIDTH &&
			ycoord >= ycoord_ini && ycoord < ycoord_ini + SCOREBOARD_HEIGHT;

	assign xcoord_digit = xcoord_rel - DIGIT_WIDTH*xcoord_rel[9:3];
	assign ycoord_digit = ycoord_rel;
	
	letter_memory digit_glyph (
		.xcoord(xcoord_digit), .ycoord(ycoord_digit),
		.letra(score[MAX_DIGITS-1-xcoord_rel[9:3]]), .reset(reset),
		.Rx(rgb[0]), .Gx(rgb[1]), .Bx(rgb[2]), .on(on_digit)
	);
	
	assign on = on_position && on_digit;
	
	/**************************************************************************
							END NUMBER DISPLAY MODULE
	**************************************************************************/
	
endmodule
