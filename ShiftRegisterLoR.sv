/**********************************************************
Module Name: 
	ShiftRegisterLoR.sv
Description: 
	Accumulates values of the Sequential Multiplier
Inputs:
	- clk
	- reset
	- load
	- shift
	- parallelInput
	- LoR
	- ready
Outputs:
	- serialOutput
	- parallelOutput
	- readyFlag
Version:
	1.0
Authors:
	- Oscar Alejandro Cortes Acosta
	- Mario Eugenio Zuñiga Carrillo
Date:
	24/02/18
**********************************************************/
module ShiftRegisterLoR
#(
	parameter WORD_LENGTH = 8
)
(
	/* Inputs */
	input clk,
	input reset,
	input load,
	input shift,
	input [WORD_LENGTH - 1 : 0] parallelInput,
	input LoR,
	input ready,
	
	/* Outputs */
	output serialOutput,
	output [WORD_LENGTH - 1 : 0] parallelOutput,
	output readyFlag
);

/* Local parameters */
logic [WORD_LENGTH - 1 : 0] shiftRegister_logic;	// Internal value to save the parallel input
bit LoR_bit;		// Keeps the shift value that is beign taken away
bit readyBit;		// Keeps track of the ready value

/* Always cycle for the functions of the module */
always @ (posedge clk, negedge reset) begin
	
	/* Condition for the reset of the system */
	if(reset == 1'b0)
		shiftRegister_logic <= {WORD_LENGTH{1'b0}};
	else
	begin
		/* Load & shift are assigned to specify the cases */
		case ({load, shift})
		
			/* Case of load low & shift high */
			2'b01:
				/* We check if it's assigned to go left */
				if(LoR == 1'b0)
					begin
						/* The bit that will be moved is assigned to LoR_bit */
						LoR_bit = shiftRegister_logic[WORD_LENGTH - 1]; 
						/* The values of the shift register are moved to the left */
						shiftRegister_logic <= {shiftRegister_logic[WORD_LENGTH - 2 : 0], 1'b0};
					end
				
				/* If it isn't then it will go right */
				else
					begin
						/* The bit that will be moved is assigned to LoR_bit */
						LoR_bit = shiftRegister_logic[0]; 
						/* The values of the shift register are moved to the right */
						shiftRegister_logic <= {1'b0, shiftRegister_logic[WORD_LENGTH - 1 : 1]};
					end
			
			/* Case of load high & shift low */
			2'b10:
				/* If this condition is true, the parallel input will load
					to the logic of the shift register */
				shiftRegister_logic <= parallelInput;
				
			/* Default case */
			default:
				/* Internal values stay the same */
				shiftRegister_logic <= shiftRegister_logic;
		endcase
		
		/* The ready bit is updated */
		readyBit <= ready;
		
	end
end

/* The logic & bit values are assigned to the outputs */
assign serialOutput = LoR_bit;
assign parallelOutput = shiftRegister_logic;
assign readyFlag = readyBit;


endmodule
