/**********************************************************
Module Name: 
	Accumulator.sv
Description: 
	Accumulates values of the Sequential Multiplier
Inputs:
	- clk
	- reset
	- sys_reset
	- in
	- ready
Outputs:
	- acc
	- readBit
Version:
	1.0
Authors:
	- Oscar Alejandro Cortes Acosta
	- Mario Eugenio Zuñiga Carrillo
Date:
	24/02/18
**********************************************************/
module Accumulator
#(
	parameter NBits=16
)
(
	/* Inputs */
	input clk,
	input reset,
	input sys_reset,
	input [NBits-1:0]in,
	input ready,	
	/* Outputs */
	output [NBits-1:0]acc,
	output readBit
);

/* Local parameters */
logic [NBits-1:0]acc_logic;	// Saves values accumulated in the module 
bit readyLogic;					// Saves the current state of ready

/* Always cycle for the accumulation process */
always @ (posedge clk, negedge reset) begin

	/* Condition for the general reset */
	if(reset == 1'b0)
		acc_logic = 16'b0000000000000000;

	/* System reset for when there are new values to accumulate */
	else if(sys_reset == 1'b1)
		acc_logic = 16'b0000000000000000;
	
	else
	/* If not, we begin to accumulate the values that are coming */
	begin
	
		/* We check if the system is not ready */
		if(!ready)
			/* If it's not, we keep saving the values that are entering */
			acc_logic = acc_logic + in;
			
		/* We update the ready logic value with ready */
		readyLogic <= ready;
	end
end

/* The logic values are assigned to the outputs */
assign acc = acc_logic;
assign readBit = readyLogic;

endmodule
