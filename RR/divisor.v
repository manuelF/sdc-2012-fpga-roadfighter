`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:42:14 08/27/2012 
// Design Name: 
// Module Name:    divisor 
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
module divider
#(parameter N=19)	
(
    input [N-1:0] a,
    input [N-1:0] b,
	 input clk, reset,
    output [N-1:0] res,
	 output done
    );

	localparam [1:0]
		INIT = 2'b00,
		LOOP = 2'b01,
		END = 2'b10;

	reg [1:0] state_reg, state_next;
	reg done_reg, done_next;
	reg [N-1:0] a_reg,a_next,res_next, res_reg;

	always @(posedge clk, posedge reset)
	begin
		if(reset)
			begin
				res_reg   <= 0;
				done_reg  <= 0;
				state_reg <= INIT;
				a_reg <= 0;
			end
		else
			begin
				res_reg   <= res_next;
				done_reg  <= done_next;
				state_reg <= state_next;
				a_reg <= a_next;
			end
	end
	
	always @*
	begin
		case(state_reg)
			INIT:
				begin
					res_next 		= 0;
					a_reg 			= a;
					state_next 		= LOOP;
					done_next 		= 0;
				end
			LOOP:
				begin
					done_next = 0;
					if(a_reg > b)
						begin
							a_next 		= a_reg - b;
							state_next 	= LOOP;
							res_next 	= res_reg + 1;
						end
					else
						begin
							state_next 	= END;
						end
				end
			END:
				begin
					done_next 	= 1;
					state_next	= INIT;
				end
			default:
				begin
					done_next 	= done_reg;
					state_next 	= state_reg;
					res_next		= res_reg;
					a_next		= a_reg;
				end
		endcase
	end

	assign res = res_reg;
	assign done = done_reg;
	
endmodule
