`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:51:54 06/22/2012 
// Design Name: 
// Module Name:    player 
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
module player(
    input clk,
    input reset,
    input left,
    input right,
    output [7:0] car_x,
    output [9:0] car_y
//  ,output alive
    );
	 
	localparam
		PLAYER_STARTX = 128,
		PLAYER_STARTY = 480-40,
		PLAYER_WIDTH = 16,
		PLAYER_HEIGHT = 32,
		ROADTRACK_WIDTH = 255;
	
	reg [7:0] car_x_reg, car_x_next;
//	reg dead_next, dead_reg;	
	
	always @(posedge clk, posedge reset)
	begin
		if(reset) 
		begin
			car_x_reg <= PLAYER_STARTX-PLAYER_WIDTH/2; 
			//El ancho de la pista es 256, el ancho del auto es 16
//			dead_reg <= 0;	  //No murio
		end
		else
		begin
			car_x_reg <= car_x_next;
//			dead_reg <= dead_next;
		end
	end
	
	always @*
	begin
		car_x_next = car_x_reg;
//		dead_next = 0;

		case({left,right})
			2'b00, 2'b11:
				car_x_next = car_x_reg;
			2'b10:
				if(car_x_reg > 0)
					car_x_next = car_x_reg-1;
//				else
//					dead_next = 1'b1;
			2'b01:
				if(car_x_reg < ROADTRACK_WIDTH-PLAYER_WIDTH)
					car_x_next = car_x_reg+1;
//				else
//					dead_next = 1'b1;
		endcase
	end
	
//	assign alive = ~dead_reg;
	assign car_x = car_x_reg;
	assign car_y = PLAYER_STARTY; //Le damos un poco de espacio al auto;
	
endmodule
