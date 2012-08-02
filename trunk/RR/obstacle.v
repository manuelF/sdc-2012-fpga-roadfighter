`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:09 06/29/2012 
// Design Name: 
// Module Name:    obstacle 
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
module obstacle(
	input clk, init, reset,
   input [7:0] initial_x,
	input upsig,
	output on,
   output [7:0] car_x,
   output [9:0] car_y
);
	 
	localparam
		ROADTRACK_HEIGHT = 480;
	 
	reg [7:0] car_x_reg, car_x_next;
	reg [9:0] car_y_reg, car_y_next;
	
	always @(posedge clk, posedge reset)
	begin
		if (reset)
		begin
			car_x_reg <= 0;
			car_y_reg <= ROADTRACK_HEIGHT;
		end
		else if(init)
		begin
			car_x_reg <= initial_x;
			car_y_reg <= 0;
		end
		else if (upsig)
		begin
			car_x_reg <= car_x_next;
			car_y_reg <= car_y_next;
		end
	end
	
	always @*
	begin
		car_x_next = car_x_reg;
		if ( car_y_reg < ROADTRACK_HEIGHT )
			car_y_next = car_y_reg + 1;
		else
			car_y_next = car_y_reg;
	end
	
	assign on = car_y_reg < ROADTRACK_HEIGHT;
	assign car_x = car_x_reg;
	assign car_y = car_y_reg;

endmodule
