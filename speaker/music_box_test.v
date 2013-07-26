`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:23 07/26/2013 
// Design Name: 
// Module Name:    music_box_test 
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
module music_box_test(
		input clock,
		output speaker
    );

	reg [31:0] tone;
	always @(posedge clock) 
		if(tone[31] == 1)
			tone <= 2 ** 23;
		else
			tone <= tone+1;

	wire [7:0] fullnote;

	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	music_memory musicbox (
	  .clka(clock), // input clka
	  .addra(tone[30:23]), // input [6 : 0] addra
	  .douta(fullnote) // output [7 : 0] douta
	);
	// INST_TAG_END ------ End INSTANTIATION Template ---------


	wire speaker_in;
	music_handler notes( .clk(clock), .fullnote(fullnote), .speaker(speaker_in) );

	assign speaker = speaker_in;

endmodule
