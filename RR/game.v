`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:27 07/06/2012 
// Design Name: 
// Module Name:    game 
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
module game(
    input wire clk, reset2,
	 input wire left, right,
	 input wire start,
    output wire hsync, vsync,
    output wire [2:0] rgb,
	 output wire colision,	 
	 output wire [5:0] total_score
   );
	
	wire reset = ~reset2;
	wire go_left, go_right;

	reg start_reg, start_next;

	db_fsm db1 ( .clk(clk), .reset(reset), .sw(left), .db(go_left) );
	db_fsm db2 ( .clk(clk), .reset(reset), .sw(right), .db(go_right) );

	/* ACELERACION */
	localparam ACCELTOPE = 10*25000000;
	wire accelerate; 
	
	reg [29:0] accelerate_reg, accelerate_next;
	always @(posedge clk, posedge reset)
		if(reset)
			accelerate_reg <= 0;
		else
			accelerate_reg <= accelerate_next;
	
	always @*
		if(accelerate)
			accelerate_next = 0;
		else if(start_reg)
			accelerate_next = accelerate_reg + 1;
		else
			accelerate_next = accelerate_next;
	assign accelerate = accelerate_reg >= ACCELTOPE;
	/* END ACELERACION */
	
	wire upsig, upsig_fast;

	localparam ACCELDEC = 5000;
	
	/* INCREMENTO DE UPSIG */
	localparam TOPE = 17'b11111111111111111;

	reg [17:0] tope_reg, tope_next;
	always @(posedge clk, posedge reset)
		if(reset)
			tope_reg <= TOPE;
		else
			tope_reg <= tope_next;
	
	always @*
		if(accelerate)
			tope_next = tope_reg - ACCELDEC;
		else
			tope_next = tope_reg;

	/* FIN INCREMENTO DE UPSIG */
	
	universal_bin_counter #(.N(17)) updatesignal 
		(.clk(clk), .reset(reset),
		 .en(1'b1), .up(1'b1), .d(0), .syn_clr(1'b0),
		 .load(1'b0), .max_tick(upsig),.min_tick(), .q(), 
		 .tope(tope_reg)
		);
	
	reg [17:0] upsig_fast_reg, upsig_fast_next;
	always @(posedge clk, posedge reset)
		if(reset)
			begin
				upsig_fast_reg <= 0;
			end
		else
			begin
				upsig_fast_reg <= upsig_fast_next;
			end
	always @*
	begin
		if(upsig_fast_reg >= tope_reg-9000)
			upsig_fast_next = 0;
		else
			upsig_fast_next = upsig_fast_reg+1;
	end	

	assign upsig_fast = upsig_fast_reg >= tope_reg-9000;

	wire run;
	assign run = upsig & !colision;
	
	reg [2:0] red_reg;
	wire [2:0] red_next,rgb_out;
	
	always@(posedge clk, posedge reset)
		if (reset)
			red_reg <= 0;
		else if(upsig)
			red_reg <= red_next;
			
	assign red_next = {colision & ~red_reg, 2'b00};
	
	assign rgb = rgb_out;

	localparam DROPRATE = 25;
	localparam DROPSYNC = 25'b0110010101011110111110101;

	reg [DROPRATE:0] drop_reg,drop_next;

	/* INCREMENTO DE DROPSYNC */
	reg [DROPRATE:0] dropsync_reg, dropsync_next;
	always @(posedge clk, posedge reset)
		if(reset)
			dropsync_reg <= DROPSYNC;
		else
			dropsync_reg <= dropsync_next;
	
	always @*
		if(accelerate)
			dropsync_next = dropsync_reg - 8*ACCELDEC;
		else
			dropsync_next = dropsync_reg;
	/* FIN INCREMENTO DROPSYNC */
	
	always @(posedge clk, posedge reset)
		if(reset)
			drop_reg <= 0;
		else
			drop_reg <= drop_next;
	
	always @*
		if(drop_reg > dropsync_reg)
			drop_next = 0;
		else
			drop_next = drop_reg + 1;
	
	always @(posedge clk,posedge reset)
		if(reset)
			start_reg <= 0;
		else if(~start) //Invertimos la logica porque el control de sega funciona al reves 
			start_reg <= 1;
		else
			start_reg <= start_next;

	always @*
		start_next = start_reg;
	
	localparam CLK = 50000000; //ceil(log(CLK)) = 26, por eso son 26 bits.
	reg [25:0] clk_counter_reg, clk_counter_next;
	reg [5:0] total_score_reg, total_score_next;

	always @(posedge clk, posedge reset)	
		if(reset)
			begin
				clk_counter_reg <= 0;
				total_score_reg <= 0;				
			end
		else if((~colision)&(start_reg))
			begin
				clk_counter_reg <= clk_counter_next;
				total_score_reg <= total_score_next;
			end
		
	always @*
		if(clk_counter_reg > CLK)
			begin
				clk_counter_next = 0;
				total_score_next = total_score_reg+1;
			end
		else
			begin 
				clk_counter_next = clk_counter_reg+1;
				total_score_next = total_score_reg;
			end
	assign total_score = total_score_reg;

	main road_fighter (
		.clk(clk), .reset(reset), .upsig(run), .upsig_fast(upsig_fast & ~colision),
		.drop((drop_reg >= dropsync_reg) & ~colision & start_reg),  .alive(~colision & start_reg),
		.left(go_left), .right(go_right),					
		.hsync(hsync), .vsync(vsync), .rgb(rgb_out), .colision(colision)
	);
				
endmodule
