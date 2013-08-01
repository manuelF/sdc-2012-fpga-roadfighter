`timescale 1ns / 1ps

module rr_music(
		input clock,
		output speaker_b,
		output speaker_m
    );

	reg [40:0] tone_bass;
	reg [31:0] tone_melody;

	wire [7:0] fullnote_bass;
	wire speaker_bass;

	wire [7:0] fullnote_melody;
	wire speaker_melody;
		
	always @(posedge clock) 
	begin
		if(fullnote_bass == 8'hFF) 		
			tone_bass <= 2**21;
		else
			tone_bass <= tone_bass+1;

		if(fullnote_melody == 8'hFF) 
			tone_melody <= 2**23;
		else
			tone_melody <= tone_melody+1;
	end
	
	reg [1:0] cut_clock;
	wire half_clock;
	
	always @(posedge clock)
	begin
		cut_clock <= cut_clock+1;
	end
	
	assign half_clock = cut_clock[1];
	
	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	music_bass musicbox_bass (
	  .clka(clock), // input clka
	  .addra(tone_bass[30:21]), // input [7 : 0] addra
	  .douta(fullnote_bass) // output [7 : 0] douta
	);
	// INST_TAG_END ------ End INSTANTIATION Template ---------
	
	music_handler notes_bass( .clk(clock), .fullnote(fullnote_bass), .speaker(speaker_bass) );
	
	assign speaker_b = speaker_bass;
	
	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	music_melody musicbox_melody (
	  .clka(clock), // input clka
	  .addra(tone_melody[30:23]), // input [6 : 0] addra
	  .douta(fullnote_melody) // output [7 : 0] douta
	);
	// INST_TAG_END ------ End INSTANTIATION Template ---------
	
	music_handler notes_melody( .clk(clock), .fullnote(fullnote_melody), .speaker(speaker_melody) );
	assign speaker_m = speaker_melody;

endmodule

