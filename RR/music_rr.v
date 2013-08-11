`timescale 1ns / 1ps

module rr_music(
		input clock,
		input reset,
		input colision,
		input started,
		output loser,
		output speaker_b,
		output speaker_m,
		output bpm_tick
    );

	wire enabled;
	assign enabled = ~colision & started;
	
	wire [7:0] fullnote_bass;
	wire speaker_bass;

	wire [7:0] fullnote_melody;
	wire speaker_melody;

	localparam [31:0] BPMTOP = 520833;
	reg [31:0] bpm_counter_reg;
	reg bpm_tick_reg;
		
	wire update; 
	assign update = enabled & ~reset;

	always @(posedge clock)
		if(started)
			if(bpm_counter_reg == BPMTOP) begin
				bpm_counter_reg <= 0;
				bpm_tick_reg <= 1;
			end else begin
				bpm_counter_reg <= bpm_counter_reg+1;
				bpm_tick_reg <= 0; 
			end
		else begin
			bpm_counter_reg <= 0;
			bpm_tick_reg <= 0;
		end

	assign bpm_tick = bpm_tick_reg;
	
	reg [11:0] tone_bass;
	reg [11:0] tone_melody;
	
	always @(posedge clock) 
		if(update)
			begin
				if(bpm_tick)
				begin
					if(fullnote_bass == 8'hFF) 		
						tone_bass <= 0;
					else
						tone_bass <= tone_bass+1;

					if(fullnote_melody == 8'hFF) 
						tone_melody <= 0;
					else
						tone_melody <= tone_melody+1;
				end
			end
			else begin
				tone_melody <= 0;
				tone_bass <= 0;
			end
	
	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	music_bass musicbox_bass (
	  .clka(clock), // input clka
	  .addra(tone_bass), // input [7 : 0] addra
	  .douta(fullnote_bass) // output [7 : 0] douta
	);
	// INST_TAG_END ------ End INSTANTIATION Template ---------
	
	music_handler notes_bass( .clk(clock), 
		.fullnote(fullnote_bass), 
		.speaker(speaker_bass) );
			
	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	music_melody musicbox_melody (
	  .clka(clock), // input clka
	  .addra(tone_melody), // input [6 : 0] addra
	  .douta(fullnote_melody) // output [7 : 0] douta
	);
	// INST_TAG_END ------ End INSTANTIATION Template ---------
	
	music_handler notes_melody( .clk(clock), 
		.fullnote(fullnote_melody), 
		.speaker(speaker_melody) );

	//MUSICA DE PERDER

	reg [7:0] loser_music_reg;
	wire [7:0] loser_music;

	localparam LOSER_MUSIC_LIMIT = 3*12+11;
	wire speaker_lost; 
		
	reg [5:0] note_counter;
	always @(posedge clock, posedge reset)
		if(reset) begin
			loser_music_reg <= LOSER_MUSIC_LIMIT;
			note_counter <= 12;
		end else begin
			if(loser)
				if(bpm_tick)
					if(note_counter == 0) begin
						note_counter <= 12;
						if (loser_music > 2*12+11)
							loser_music_reg <= loser_music - 1;
						else
							loser_music_reg <= 0;
					end else
						note_counter <= note_counter-1;
		end

	assign loser = (colision & started);
	assign loser_music = loser_music_reg;
	
	music_handler notes_loser( .clk(clock), 
		.fullnote(loser_music), 
		.speaker(speaker_lost) );
		
	assign speaker_b = (enabled & speaker_bass) | (loser & speaker_lost);
	assign speaker_m = (enabled & speaker_melody) | (loser & speaker_lost);

endmodule
