`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:08 06/15/2012 
// Design Name: 
// Module Name:    main 
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
module main(
    input wire clk, reset,
	 input wire drop,
	 input wire left, right,
	 input wire upsig, upsig_fast,
    output wire hsync, vsync,
    output wire [2:0] rgb,
	 output wire [7:0] initial_dbg,
	 output wire colision
   );

   //signal declaration
   reg [2:0] rgb_reg;
	wire [2:0] rgb_next;
   wire video_on;
	
	wire [9:0] pixel_x,pixel_y;
	
   // instantiate vga sync circuit
   vga_sync vsync_unit
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(), .pixel_x(pixel_x), .pixel_y(pixel_y));
		 
   // rgb buffer
   always @(posedge clk, posedge reset)
      if (reset)
         rgb_reg <= 0;
      else
         rgb_reg <= rgb_next;
	
	// -------------------------------------------------------------------------

	wire [7:0] player_car_x;
	wire [9:0] player_car_y;
	wire on_player_car;
	wire [2:0] rgb_car_player;

	player p1 (.clk(clk), .update_signal(upsig), .reset(reset), .left(left), .right(right), 
						.car_x(player_car_x), .car_y(player_car_y) );

	graphic_car_controller p1_gcontroller (
					.car_position_x(player_car_x), .car_position_y(player_car_y), 
					.pixel_x(pixel_x), .pixel_y(pixel_y), .on(on_player_car), .rgb(rgb_car_player),.owner(3'b000), .reset(reset), .pclk(upsig_fast));
					
	// -------------------------------------------------------------------------
	
	wire obs_0_on, obs_1_on, obs_2_on, obs_3_on, obs_4_on, obs_5_on;
	wire [7:0] obs_0_x, obs_1_x, obs_2_x, obs_3_x, obs_4_x, obs_5_x;
	wire [9:0] obs_0_y, obs_1_y, obs_2_y, obs_3_y, obs_4_y, obs_5_y;
	
	obstacle_manager obs_manager ( .clk(clk), .reset(reset), .upsig(upsig), .drop(drop),
		.obstacle_on({obs_0_on, obs_1_on, obs_2_on, obs_3_on, obs_4_on, obs_5_on}),
		.obstacle_x({obs_0_x, obs_1_x, obs_2_x, obs_3_x, obs_4_x, obs_5_x}),
		.obstacle_y({obs_0_y, obs_1_y, obs_2_y, obs_3_y, obs_4_y, obs_5_y})
		,.initial_dbg(initial_dbg)
		);

	wire [2:0] rgb_obs_0, rgb_obs_1, rgb_obs_2, rgb_obs_3, rgb_obs_4, rgb_obs_5;
	wire obs_0_visual_on, obs_1_visual_on, obs_2_visual_on, obs_3_visual_on, obs_4_visual_on, obs_5_visual_on;
	
	graphic_car_controller obs_0_gcont ( .car_position_x(obs_0_x), .car_position_y(obs_0_y),
					.pixel_x(pixel_x), .pixel_y(pixel_y), .on(obs_0_visual_on), .rgb(rgb_obs_0), .owner(3'b001), .reset(reset), .pclk(upsig_fast));
	graphic_car_controller obs_1_gcont ( .car_position_x(obs_1_x), .car_position_y(obs_1_y),
					.pixel_x(pixel_x), .pixel_y(pixel_y), .on(obs_1_visual_on), .rgb(rgb_obs_1), .owner(3'b001), .reset(reset), .pclk(upsig_fast));
	graphic_car_controller obs_2_gcont ( .car_position_x(obs_2_x), .car_position_y(obs_2_y),
					.pixel_x(pixel_x), .pixel_y(pixel_y), .on(obs_2_visual_on), .rgb(rgb_obs_2), .owner(3'b001), .reset(reset), .pclk(upsig_fast));
	graphic_car_controller obs_3_gcont ( .car_position_x(obs_3_x), .car_position_y(obs_3_y),
					.pixel_x(pixel_x), .pixel_y(pixel_y), .on(obs_3_visual_on), .rgb(rgb_obs_3), .owner(3'b001), .reset(reset), .pclk(upsig_fast));
	graphic_car_controller obs_4_gcont ( .car_position_x(obs_4_x), .car_position_y(obs_4_y),
					.pixel_x(pixel_x), .pixel_y(pixel_y), .on(obs_4_visual_on), .rgb(rgb_obs_4), .owner(3'b001), .reset(reset), .pclk(upsig_fast));
	graphic_car_controller obs_5_gcont ( .car_position_x(obs_5_x), .car_position_y(obs_5_y),
					.pixel_x(pixel_x), .pixel_y(pixel_y), .on(obs_5_visual_on), .rgb(rgb_obs_5), .owner(3'b001), .reset(reset), .pclk(upsig_fast));

	// -------------------------------------------------------------------------

	//wire colision;
	colisionManager cm ( .position_0_x(obs_0_x), .position_0_y(obs_0_y),
								.position_1_x(obs_1_x), .position_1_y(obs_1_y),
								.position_2_x(obs_2_x), .position_2_y(obs_2_y),
								.position_3_x(obs_3_x), .position_3_y(obs_3_y),
								.position_4_x(obs_4_x), .position_4_y(obs_4_y),
								.position_5_x(obs_5_x), .position_5_y(obs_5_y),
								.position_player_x(player_car_x), .position_player_y(player_car_y),
								.colision(colision) );

	// -------------------------------------------------------------------------
	
	wire [2:0] rgb_bg;
	background bg (.pixel_x(pixel_x), .pixel_y(pixel_y), .rgb(rgb_bg), .clk(clk), .update_signal(upsig_fast), .reset(reset));

	graphic_controller #(7) gc (
				.rgb(rgb_next),
				.on_objs({
					on_player_car,
					obs_0_on & obs_0_visual_on,
					obs_1_on & obs_1_visual_on,
					obs_2_on & obs_2_visual_on,
					obs_3_on & obs_3_visual_on,
					obs_4_on & obs_4_visual_on,
					obs_5_on & obs_5_visual_on,
					1'b1}),
				.r_objs({
					rgb_car_player[0],
					rgb_obs_0[0],
					rgb_obs_1[0],
					rgb_obs_2[0],
					rgb_obs_3[0],
					rgb_obs_4[0],
					rgb_obs_5[0],
					rgb_bg[0]}),
				.g_objs({
					rgb_car_player[1],
					rgb_obs_0[1],
					rgb_obs_1[1],
					rgb_obs_2[1],
					rgb_obs_3[1],
					rgb_obs_4[1],
					rgb_obs_5[1],
					rgb_bg[1]}),
				.b_objs({
					rgb_car_player[2],
					rgb_obs_0[2],
					rgb_obs_1[2],
					rgb_obs_2[2],
					rgb_obs_3[2],
					rgb_obs_4[2],
					rgb_obs_5[2],
					rgb_bg[2]})
				);
				
   // output
   assign rgb = (video_on) ? rgb_reg : 3'b0;
	
endmodule
