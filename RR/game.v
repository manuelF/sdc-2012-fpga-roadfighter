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
    input wire clk, reset,
	 input wire left, right,
	 input wire start,
    output wire hsync, vsync,
    output wire [2:0] rgb,
	 output wire colision,
	 output wire [5:0] total_score
   );
	
	wire go_left, go_right;
	db_fsm db1 ( .clk(clk), .reset(reset), .sw(left), .db(go_left) );
	db_fsm db2 ( .clk(clk), .reset(reset), .sw(right), .db(go_right) );

	wire upsig;
	universal_bin_counter #(.N(17)) updatesignal 
		(.clk(clk), .reset(reset),
		 .en(1'b1), .up(1'b1), .d(0), .syn_clr(1'b0),
		 .load(1'b0), .max_tick(upsig),.min_tick(), .q()
		);
		
	wire [19:0] counter;
	localparam TOPE = 19'b1111111111111111111;
	
	universal_bin_counter #(.N(19)) updatesignal2 
		(.clk(clk), .reset(reset),
		 .en(1'b1), .up(1'b1), .d(0), .syn_clr(counter == TOPE),
		 .load(1'b0), .max_tick(),.min_tick(), .q(counter)
		);
			
	wire run;
	assign run = upsig & !colision;
	
	reg [2:0] rgb_reg,rgb_next,red_reg;
	wire [2:0] red_next,rgb_out;
	
	always@(posedge upsig, posedge reset)
		if (reset)
			red_reg <= 0;
		else
			red_reg <= red_next;
			
	assign red_next = {colision & ~red_reg, 2'b00};
	
	assign rgb = rgb_out;
	
	localparam DROPRATE = 25;
	localparam DROPSYNC = 25'b10110010101011110111110101;
	reg [DROPRATE:0] drop_reg,drop_next;
	
	always @(posedge clk)
		if(reset)
			drop_reg <= 0;
		else
			drop_reg <= drop_next;
	
	always @*
		if(drop_reg == DROPSYNC)
			drop_next = 0;
		else
			drop_next = drop_reg+1;
	
	reg start_reg,start_next;
	always @(posedge clk,posedge reset)
		if(reset)
			start_reg <= 0;
		else if(start)
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
		else
			begin
				clk_counter_reg <= clk_counter_next;
				total_score_reg <= total_score_next;
			end
		
	always @*
		if(clk_counter_reg == CLK)
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
	
	main road_fighter (.clk(clk), .reset(reset), .upsig(run), .upsig_fast((counter == TOPE) & !colision),
				.drop((drop_reg == DROPSYNC) & ~colision & start_reg), .left(go_left), .right(go_right),
				.hsync(hsync), .vsync(vsync), .rgb(rgb_out),
				.colision(colision)
				);

endmodule
