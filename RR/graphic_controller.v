`timescale 1ns / 1ps

module graphic_controller
#(parameter N=7)	
	(
	input wire [N:0] on_objs,
	input wire [N:0] r_objs, g_objs, b_objs,
	output reg [2:0] rgb
	);
	
	integer i;
	always @*
	begin	
	
		//Dibuja cada uno de los objetos, y siempre dibuja el 0, que es el auto del jugador
		for(i=0; i<=N; i=i+1)
		begin
			if((on_objs[i]==1'b1)||(i==0))
			begin
				rgb[0] = r_objs[i];
				rgb[1] = g_objs[i];
				rgb[2] = b_objs[i];
			end
		end
		
	end

endmodule
