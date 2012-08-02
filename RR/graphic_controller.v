`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:24 06/15/2012 
// Design Name: 
// Module Name:    graphicController 
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
module graphic_controller
	(
	input wire [7:0] on_objs,
	input wire [7:0] r_objs, g_objs, b_objs,
	output reg [2:0] rgb
	);
		
	always @*
	begin
		if (on_objs[7] == 1'b1)
		begin
			rgb[0] = r_objs[7];
			rgb[1] = g_objs[7];
			rgb[2] = b_objs[7];
		end
		else if (on_objs[6] == 1'b1)
		begin
			rgb[0] = r_objs[6];
			rgb[1] = g_objs[6];
			rgb[2] = b_objs[6];
		end
		else if (on_objs[5] == 1'b1)
		begin
			rgb[0] = r_objs[5];
			rgb[1] = g_objs[5];
			rgb[2] = b_objs[5];
		end
		else if (on_objs[4] == 1'b1)
		begin
			rgb[0] = r_objs[4];
			rgb[1] = g_objs[4];
			rgb[2] = b_objs[4];
		end
		else if (on_objs[3] == 1'b1)
		begin
			rgb[0] = r_objs[3];
			rgb[1] = g_objs[3];
			rgb[2] = b_objs[3];
		end
		else if (on_objs[2] == 1'b1)
		begin
			rgb[0] = r_objs[2];
			rgb[1] = g_objs[2];
			rgb[2] = b_objs[2];
		end
		else if (on_objs[1] == 1'b1)
		begin
			rgb[0] = r_objs[1];
			rgb[1] = g_objs[1];
			rgb[2] = b_objs[1];
		end
		else if (on_objs[0] == 1'b1)
		begin
			rgb[0] = r_objs[0];
			rgb[1] = g_objs[0];
			rgb[2] = b_objs[0];
		end
		else
		begin
			rgb[0] = r_objs[0];
			rgb[1] = g_objs[0];
			rgb[2] = b_objs[0];
		end
	end

endmodule
