`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:45:04 07/26/2013 
// Design Name: 
// Module Name:    speaker 
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
module speaker(
	input clk,
	output speaker_out
    );


reg [14:0] counter;
always @(posedge clk) 
	if(counter==28408) 
		counter <= 0; 
	else 
		counter <= counter+1;

reg speaker;
always @(posedge clk) 
	if(counter==28408) 
		speaker <= ~speaker;
		
assign speaker_out = speaker;
endmodule
