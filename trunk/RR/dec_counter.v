`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:21:44 08/29/2012 
// Design Name: 
// Module Name:    dec_counter 
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
module dec_counter(
	 input clk,
    input reset,
    input up, 
	 output over,
    output [3:0] value
    );

	reg [3:0] val_next, val_reg;
	reg over_next, over_reg;
	
	always @(posedge up, posedge reset)
	begin
		if(reset) 
			begin
				val_reg 	<= 0;
				over_reg <= 0;
			end 
		else
			begin
				val_reg 	<= val_next;
				over_reg <= over_next;
			end
	end

	always @*
	begin
		if(val_reg == 4'h9) 
			begin
				val_next 	= 0;
				over_next 	= 1;
			end 
		else 
			begin
				val_next 	= val_reg + 1;
				over_next	= 0;
			end
	end

	assign value = val_reg;
	assign over = over_reg;
	
endmodule
