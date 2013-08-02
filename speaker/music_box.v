`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:47:33 07/26/2013 
// Design Name: 
// Module Name:    music_box 
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
module music_handler (
	input clk,
	input [7:0] fullnote,
	output speaker
);

	wire [2:0] octave;
	wire [3:0] note;
	divide_by12 divby12(	.numer(fullnote[5:0]), 
								.quotient(octave), 
								.remain(note));

	reg [8:0] clkdivider;
	always @(note)
	case(note)
		0: clkdivider = 512-1; // A 
		1: clkdivider = 483-1; // A#/Bb
		2: clkdivider = 456-1; // B 
		3: clkdivider = 431-1; // C 
		4: clkdivider = 406-1; // C#/Db
		5: clkdivider = 384-1; // D 
		6: clkdivider = 362-1; // D#/Eb
		7: clkdivider = 342-1; // E 
		8: clkdivider = 323-1; // F 
		9: clkdivider = 304-1; // F#/Gb
		10: clkdivider = 287-1; // G 
		11: clkdivider = 271-1; // G#/Ab
		12: clkdivider = 0; // should never happen
		13: clkdivider = 0; // should never happen
		14: clkdivider = 0; // should never happen
		15: clkdivider = 0; // should never happen
	endcase

	reg [8:0] counter_note;
	always @(posedge clk) 
		if(counter_note==0) 
			counter_note <= clkdivider; 
		else 
			counter_note <= counter_note-1;

	reg [7:0] counter_octave;
	always @(posedge clk)
		if(counter_note==0)
			begin
				if(counter_octave==0)
					counter_octave <= (octave==0?255:octave==1?127:octave==2?63:octave==3?31:octave==4?15:octave==5?7:3);
				else
					counter_octave <= counter_octave-1;
			end

	reg speaker_out;
	always @(posedge clk) 
		if(counter_note==0 && counter_octave==0 && fullnote != 0) 
			speaker_out <= ~speaker_out;
	
	assign speaker = speaker_out;
endmodule