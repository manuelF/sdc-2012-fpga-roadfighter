`timescale 1ns / 1ps

module rr_music(
		input clock,
		input enabled,
		output speaker_b,
		output speaker_m,
		
    );

	reg [31:0] tone;
	always @(posedge clock) 
		if(tone[31] == 1)
			tone <= 2 ** 23;
		else
			tone <= tone+1;

	wire [7:0] fullnote_bass;
	wire speaker_bass;

	music_bass musicbox_bass (
	  .clka(clock), // input clka
	  .addra(tone[30:23]), // input [6 : 0] addra
	  .douta(fullnote_bass) // output [7 : 0] douta
	);
	music_handler notes_bass( .clk(clock), .fullnote(fullnote_bass), .speaker(speaker_bass) );
	assign speaker_b = enabled & speaker_bass;
	
	
	wire [7:0] fullnote_melody;
	wire speaker_melody;
	
	music_melody musicbox_melody (
	  .clka(clock), // input clka
	  .addra(tone[30:23]), // input [6 : 0] addra
	  .douta(fullnote_melody) // output [7 : 0] douta
	);	
	music_handler notes_melody( .clk(clock), .fullnote(fullnote_melody), .speaker(speaker_melody) );
	assign speaker_m = enabled & speaker_melody;

endmodule

