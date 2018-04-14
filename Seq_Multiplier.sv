/**********************************************************
Module Name: 
	Seq_Multiplier.sv
Description: 
	Instance module to create the Sequential Multiplier
Inputs:
	- clk
	- reset
	- start
	- multiplier
	- multiplicand
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
 module Seq_Multiplier
#(
	parameter NBits = 8 , 
	parameter N2Bits = 2*NBits
)
(
	/* Inputs */
	input clk,
	input reset,
	input start,
	input [NBits-1:0] multiplier,
	input [NBits-1:0] multiplicand,
	
	
	/* Outputs */
	output [N2Bits-1:0] product,
	output readyBit,
	output signBit
);

/* Wires for the Control Unit */
wire one_shot;
wire first;
wire ready;

/* Wire for the Nor instnance */
wire shift_ctl;

wire [NBits-1:0] parallel_output_multiplier;
wire serial_output_multiplier;

wire shift_ctl_multiplicand;

wire [N2Bits-1:0] parallel_output_multiplicand;
wire serial_output_multiplicand;

wire [N2Bits-1:0] acc_input;
wire [N2Bits-1:0] acc_output;

wire [NBits-1:0] multiplier_a2;
wire [NBits-1:0] multiplicand_a2;

wire sign_multiplier;
wire sign_multiplicand;
wire out_sign;

wire readyBitmultiplier;
wire readyBitmultiplicand;
wire readyBitAcc;

/* Instance for the Control Unit*/
Ctl_Unit CU1 (
	
	.start(start),
	.reset(reset),
	.clk(clk),
	.one_shot(one_shot),
	.first(first),
	.ready(ready)

);

/* Instance for the Nor module */
Nor_M NG1(

	.A(one_shot),
	.B(ready),
	.C(shift_ctl)

);

/* Instance for the Shift Register of the Multiplier
	here we need to always be moving right */
ShiftRegisterLoR #(NBits) Multiplier
(
	.clk(clk),
	.reset(reset),
	.load(one_shot),
	.shift(shift_ctl),
	.parallelInput(multiplier_a2),
	.LoR(1'b1),	
	.ready(ready),
	.serialOutput(serial_output_multiplier),
	.parallelOutput(parallel_output_multiplier),
	.readyFlag(readyBitmultiplier)

);

/* Instance of the Multiplexer for the Multiplicand */
Multiplexer2to1 #(1) MUX_Nor
(
	.Selector(first),
	.MUX_Data0(shift_ctl),
	.MUX_Data1(1'b0),
	.MUX_Output(shift_ctl_multiplicand)

);

/* Instance for the Shift Register of the Multiplicand
	here we need to always be moving left */
ShiftRegisterLoR #(N2Bits) Multiplicand
(
	.clk(clk),
	.reset(reset),
	.load(one_shot),
	.shift(shift_ctl_multiplicand),
	.parallelInput({8'b0, multiplicand_a2}),
	.LoR(1'b0),	
	.ready(ready),
	.serialOutput(serial_output_multiplicand),
	.parallelOutput(parallel_output_multiplicand),
	.readyFlag(readyBitmultiplicand)
);

/* Instance of the Multiplexer for the Multiplier */
Multiplexer2to1 #(N2Bits) MUX_Multiplier
(
	.Selector(serial_output_multiplier),
	.MUX_Data0(16'b0),
	.MUX_Data1(parallel_output_multiplicand),
	.MUX_Output(acc_input)

);

/* Instance of the Accumulator module */
Accumulator #(N2Bits) acc1
(
	.clk(clk),
	.reset(reset),
	.sys_reset(one_shot),
	.in(acc_input),
	.ready(readyBitmultiplier),
	.acc(acc_output),
	.readBit(readyBitAcc)
	
);

/* Instance of the complement 2 of the multiplier */
Binary_a2_complement_converter A2C1
(
	.In_Bits(multiplier),
   .Out_Bits(multiplier_a2),
	.Sign(sign_multiplier)
);

/* Instance of the complement 2 of the multiplicand */
Binary_a2_complement_converter A2C2
(
	.In_Bits(multiplicand),
   .Out_Bits(multiplicand_a2),
	.Sign(sign_multiplicand)
);

/* Instance of the Xor Module */
Xor_M XG1(

	.A(sign_multiplier),
	.B(sign_multiplicand),
	.C(out_sign)

);

/* The local values are assigned to the outputs */
assign product = acc_output;
assign readyBit = readyBitAcc;
assign signBit = out_sign;

endmodule
