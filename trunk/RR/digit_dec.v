`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:12:01 08/26/2012 
// Design Name: 
// Module Name:    digit_dec 
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
module digit_dec(
    input [19:0] in,
    output [3:0] dig
    );

	localparam [4:0] d1 = 1,
						  d2 = 2,
						  d3 = 4,
						  d4 = 8,
						  d5 = 6,
						  d6 = 2,
						  d7 = 4,
						  d8 = 8,
						  d9 = 6,
						  d10= 2,
						  d11= 4,
						  d12= 8,
						  d13= 6,
						  d14= 2,
						  d15= 4,
						  d16= 8,
						  d17= 6,
						  d18= 2,
						  d19= 4;
	integer i;
	
	assign dig = in[3:0];
endmodule
