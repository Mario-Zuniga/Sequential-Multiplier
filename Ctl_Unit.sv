/**********************************************************
Module Name: 
	Ctl_Unit.sv
Description: 
	State machine and values of Control for the Sequential Multiplier
Inputs:
	- start
	- reset
	- clk
Outputs:
	- one_shot
	- first
	- ready
Version:
	1.0
Authors:
	- Oscar Alejandro Cortes Acosta
	- Mario Eugenio Zuñiga Carrillo
Date:
	24/02/18
**********************************************************/
module Ctl_Unit
(
	/* Inputs */
	input start,
	input reset,
	input clk,
	
	/* Outputs */
	output one_shot,
	output first,
	output ready
);


/* List of the state values */
enum logic [3:0] {IDLE, ONE_SHOT, FIRST, SECOND, THIRD, FOURTH, FIFTH, SIXTH, SEVENTH, EIGHTH, READY} state; 

/* Local values */
bit one_shot_bit;		// For the state ONE_SHOT
bit first_bit;			// For the state FIRST
bit ready_bit;			// For the state READY

/* Cycle to assign to the next state */
always_ff@(posedge clk, negedge reset) begin

	/* General condition for the reset */
	if(reset == 1'b0)
		state <= IDLE;
		
	else
	begin
		case(state)
			/* The state machine will jump to the next state following
				the steps of the sequential multiplier, but only on the
				first and last state will need to aprove a condition to
				continue */
			IDLE:				if(start == 1'b1) 	state <= ONE_SHOT;
			ONE_SHOT:									state <= FIRST;
			FIRST:									 	state <= SECOND;
			SECOND:										state <= THIRD;
			THIRD:										state <= FOURTH;
			FOURTH:										state <= FIFTH;
			FIFTH:										state <= SIXTH;
			SIXTH:										state <= SEVENTH;
			SEVENTH:									 	state <= EIGHTH;
			EIGHTH:										state <= READY;
			READY:			if(start == 1'b0) 	state <= IDLE;
			
			default:		state <= IDLE;
				
		endcase
	end
end


/* Cycle for the values of the state */
always_comb begin
	/* All values will start in 0 */
	one_shot_bit = 1'b0;
	first_bit = 	1'b0;
	ready_bit =	   1'b0;
	
	case(state) 		
			/* The values will be high when they land 
				on their specific states */
			ONE_SHOT:	one_shot_bit = 1'b1;									
			FIRST:		first_bit = 	1'b1;							 									
			READY:		ready_bit =	   1'b1;	
			
			default:	;
	endcase

end

/* The bit values are assigned to the outputs */
assign one_shot = one_shot_bit;
assign first = first_bit;
assign ready = ready_bit;


endmodule
