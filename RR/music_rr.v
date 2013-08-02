`timescale 1ns / 1ps

module rr_music(
		input clock,
		input reset,
		output speaker_b,
		output speaker_m,
		input enabled
    );

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
		if(update)
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

	wire bpm_tick;
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
	
	assign speaker_b = enabled & speaker_bass;
		
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
		
	assign speaker_m = enabled & speaker_melody;

endmodule

