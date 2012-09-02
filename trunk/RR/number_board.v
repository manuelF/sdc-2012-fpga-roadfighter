`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:01 08/26/2012 
// Design Name: 
// Module Name:    binary2dec 
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

//Este modulo convierte un numero binario a decimal.
//Se le pasa que posicion deseada y devuelve si esta activada y que digito es
//Puede hacer valores hasta 2^20 ~ un millon. Para mi alcanza.
/*
def digit(n,i):
	while(i > 0):
		n = n / 10
		i = i - 1
	return (n > 0, n - 10*(n/10))

y la division la hacemos con esta cosa (gracias Hacker's Delight)

def divu10(a):
	q = (a >> 1) + (a >> 2)
	q = q + (q >> 4)
	q = q + (q >> 8)
	q = q + (q >> 16)
	q = q >> 3
	r = a-q*10
	return q + ((r + 6) >> 4)
*/
module binary2dec(
	input [19:0] number_to_display,
	input [3:0] position,
	input clk, reset,
	output done, set,
	output [4:0] digit
	);

	localparam [2:0]
		INIT = 2'b00,
		LOOP = 2'b01,
		FINISH = 2'b10;

	reg [19:0] n_reg, n_next;
	reg [3:0] i_reg, i_next;
	reg [2:0] state_next,state_reg;
	reg done_reg, done_next;
	reg [19:0] q, r;
	
	always @(posedge clk,posedge reset)
	begin
		if(reset)
			begin
				done_reg <= 0;
				n_reg <= 0;
				i_reg <= 0;
				state_reg <= INIT;
			end
		else
			begin
				done_reg <= done_next;
				n_reg <= n_next;
				i_reg <= i_next;
				state_reg <= state_next;
			end
	end
	
	reg [19:0] n_reg_div10;
	always @*
	begin
		q = (n_reg >> 1) + (n_reg >> 2);
		q = q + (q >> 4);
		q = q + (q >> 8);
		q = q + (q >> 16);
		q = q >> 3;
		r = n_reg-q*10;
		n_reg_div10 = q + ((r + 6) >> 4);	
	end
	
	always @*
	begin
		case(state_reg)
			INIT:
				begin
					n_next = number_to_display;
					i_next = i_reg;
					state_next = LOOP;
					done_next = 0;
				end
			LOOP:
				begin
					n_next = n_reg_div10;
					i_next = i_next - 1;
					done_next = 0;
					if(i_reg == 0)
						state_next = FINISH;
					else
						state_next = LOOP;
				end
			FINISH:
				begin
					n_next = n_reg;
					i_next = i_reg;
					done_next = 1;	
					state_next = INIT;
				end
		endcase
	end
	
	assign done = done_reg;
	assign set = n_reg > 0;
	assign digit = n_reg - 10*(n_reg_div10);

endmodule
