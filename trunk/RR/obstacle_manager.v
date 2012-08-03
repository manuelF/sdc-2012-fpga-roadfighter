`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:06:04 06/29/2012 
// Design Name: 
// Module Name:    obstacle_manager 
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
module obstacle_manager(
	input wire clk, reset,
	input wire drop,
	input wire upsig,
	output wire [6-1:0] obstacle_on,
	output wire [(6*8)-1:0] obstacle_x,
	output wire [(6*10)-1:0] obstacle_y,
	output wire [7:0] initial_dbg
);
	
	reg [6-1:0] init_obstacle_reg, init_obstacle_next; // lo hago reg para que se sincronizen bien
	wire [6-1:0] init_obstacle;	
	wire [7:0] initial_x;
	
	
/////////////////////////////////////////////////////////
	reg [26:0] contar;
	wire [26:0] contar_next;
	
	always@ (posedge clk, posedge reset)
		if (reset)
			contar <= 0;
		else
			contar <= contar_next;
	
	assign contar_next = contar +1;

	reg [6:0] init_reg;	
	always@ (posedge clk)
	begin
		if(drop)
			init_reg <= contar[26:20];
	end
	assign initial_dbg = init_reg;

/////////////////////////////////////////////////////////
	
	//El 1'b0 se pone porque sino aparece un heisenbug raro en el que un auto no se ve y causa colisiones invisibles.
	assign initial_x = {init_reg[1], init_reg[3], init_reg[0], 1'b0, init_reg[2], init_reg[6], init_reg[5], init_reg[4]};
	//{q[1], q[3], q[2], q[0], q[1], q[4], q[5], q[11]}
	
	obstacle ob0 ( .clk(clk), .reset(reset), .init(init_obstacle[0]), .initial_x(initial_x), .upsig(upsig),
						.on(obstacle_on[0]), .car_x(obstacle_x[7:0]), .car_y(obstacle_y[9:0]) );
						
	obstacle ob1 ( .clk(clk), .reset(reset), .init(init_obstacle[1]), .initial_x(initial_x), .upsig(upsig),
						.on(obstacle_on[1]), .car_x(obstacle_x[15:8]), .car_y(obstacle_y[19:10]) );
						
	obstacle ob2 ( .clk(clk), .reset(reset), .init(init_obstacle[2]), .initial_x(initial_x), .upsig(upsig),
						.on(obstacle_on[2]), .car_x(obstacle_x[23:16]), .car_y(obstacle_y[29:20]) );
						
	obstacle ob3 ( .clk(clk), .reset(reset), .init(init_obstacle[3]), .initial_x(initial_x), .upsig(upsig),
						.on(obstacle_on[3]), .car_x(obstacle_x[31:24]), .car_y(obstacle_y[39:30]) );
						
	obstacle ob4 ( .clk(clk), .reset(reset), .init(init_obstacle[4]), .initial_x(initial_x), .upsig(upsig),
						.on(obstacle_on[4]), .car_x(obstacle_x[39:32]), .car_y(obstacle_y[49:40]) );
						
	obstacle ob5 ( .clk(clk), .reset(reset), .init(init_obstacle[5]), .initial_x(initial_x), .upsig(upsig),
						.on(obstacle_on[5]), .car_x(obstacle_x[47:40]), .car_y(obstacle_y[59:50]) );
	
	always @(posedge clk)
	begin
		if ( drop ) begin
			init_obstacle_reg <= init_obstacle_next;
		end else begin
			init_obstacle_reg <= 0;
		end
	end

	assign init_obstacle = init_obstacle_reg;

	always@*
	begin
		// busco algún objeto inactivo para activarlo
		if ( obstacle_on[0] == 1'b0 )
			init_obstacle_next = 6'b000001;
		else if ( obstacle_on[1] == 1'b0 )
			init_obstacle_next = 6'b000010;
		else if ( obstacle_on[2] == 1'b0 )
			init_obstacle_next = 6'b000100;
		else if ( obstacle_on[3] == 1'b0 )
			init_obstacle_next = 6'b001000;
		else if ( obstacle_on[4] == 1'b0 )
			init_obstacle_next = 6'b010000;
		else if ( obstacle_on[5] == 1'b0 )
			init_obstacle_next = 6'b100000;
		else
			init_obstacle_next = 6'b000000;
	end

endmodule
