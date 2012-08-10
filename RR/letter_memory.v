
// 5x5 sprite memory,
module letter_memory(

	input [3:0] xcoord, ycoord,
	input [4:0] letra,
	input reset, pclk,
//	input clk, Reset, pclk,	
	output Rx, Gx, Bx
	);
	
	
	localparam ROWS = 5;
	localparam WIDTH = 5*3;
	reg [WIDTH-1:0] letrarow;
	
	
	reg [WIDTH-1:0] letra0[ROWS-1:0];
	reg [WIDTH-1:0] letra1[ROWS-1:0];
	reg [WIDTH-1:0] letra2[ROWS-1:0];
	reg [WIDTH-1:0] letra3[ROWS-1:0];
	reg [WIDTH-1:0] letra4[ROWS-1:0];
	reg [WIDTH-1:0] letra5[ROWS-1:0];
	reg [WIDTH-1:0] letra6[ROWS-1:0];
	reg [WIDTH-1:0] letra7[ROWS-1:0];
	reg [WIDTH-1:0] letra8[ROWS-1:0];
	reg [WIDTH-1:0] letra9[ROWS-1:0];
	
	
	// Initialize
	always @(posedge reset) 
	begin
			// Letra 0
			letra0[0] = 15'b111000000000111;
			letra0[1] = 15'b000111111111000;
			letra0[2] = 15'b000111111111000;
			letra0[3] = 15'b000111111111000;
			letra0[4] = 15'b111000000000111;

			// Letra 1
			letra1[0] = 15'b111000000111111;
			letra1[1] = 15'b111111000111111;
			letra1[2] = 15'b111111000111111;
			letra1[3] = 15'b111111000111111;
			letra1[4] = 15'b111000000000111;

			// Letra 2
			letra2[0] = 15'b111000000000111;
			letra2[1] = 15'b111111111000111;
			letra2[2] = 15'b111000000000111;
			letra2[3] = 15'b111000111111111;
			letra2[4] = 15'b111000000000111;

			// Letra 3
			letra3[0] = 15'b111000000000111;
			letra3[1] = 15'b111111111000111;
			letra3[2] = 15'b111000000000111;
			letra3[3] = 15'b111111111000111;
			letra3[4] = 15'b111000000000111;

			// Letra 4
			letra4[0] = 15'b111111000000111;
			letra4[1] = 15'b111000111000111;
			letra4[2] = 15'b000000000000111;
			letra4[3] = 15'b111000111000111;
			letra4[4] = 15'b111000111000111;

			// Letra 5
			letra5[0] = 15'b111000000000111;
			letra5[1] = 15'b111000111111111;
			letra5[2] = 15'b111000000000111;
			letra5[3] = 15'b111000111000111;
			letra5[4] = 15'b111000000000111;

			// Letra 6
			letra6[0] = 15'b111000000000111;
			letra6[1] = 15'b111000111000111;
			letra6[2] = 15'b111000000000111;
			letra6[3] = 15'b111000111000111;
			letra6[4] = 15'b111000000000111;

			// Letra 7
			letra7[0] = 15'b111000000000111;
			letra7[1] = 15'b111000111000111;
			letra7[2] = 15'b111111111000111;
			letra7[3] = 15'b111111111000111;
			letra7[4] = 15'b111111111000111;

			// Letra 8
			letra8[0] = 15'b111000000000111;
			letra8[1] = 15'b111000111000111;
			letra8[2] = 15'b111000000000111;
			letra8[3] = 15'b111000111000111;
			letra8[4] = 15'b111000000000111;

			// Letra 9
			letra9[0] = 15'b111000000000111;
			letra9[1] = 15'b111000111000111;
			letra9[2] = 15'b111000000000111;
			letra9[3] = 15'b111111111000111;
			letra9[4] = 15'b111000000000111;		
	end
	
	// Assign signals to proper outputs
	reg R,G,B;
	always @(posedge pclk) 
	begin

		if (letra == 0)
			letrarow = letra0[ycoord];
		if (letra == 1)
			letrarow = letra1[ycoord];
		if (letra == 2)
			letrarow = letra2[ycoord];
		if (letra == 3)
			letrarow = letra3[ycoord];
		if (letra == 4)
			letrarow = letra4[ycoord];
		if (letra == 5)
			letrarow = letra5[ycoord];
		if (letra == 6)
			letrarow = letra6[ycoord];
		if (letra == 7)
			letrarow = letra7[ycoord];
		if (letra == 8)
			letrarow = letra8[ycoord];
		if (letra == 9)
			letrarow = letra9[ycoord];
	
		R = letrarow[(xcoord*3)+2];
		G = letrarow[(xcoord*3)+1];
		B = letrarow[(xcoord*3)+0];		
	end
	assign Rx=R;
	assign Gx=G;
	assign Bx=B;
endmodule