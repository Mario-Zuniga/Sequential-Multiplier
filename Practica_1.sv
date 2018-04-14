/**********************************************************
Module Name: 
	Practica_1.sv
Description: 
	Instance of the Sequential Multiplier with PLL & BCD
Inputs:
	- clk,
	- reset
	- start
	- multiplier
	- multiplicand
Outputs:
	- uni_Seg_out
	- dec_Seg_out
	- cen_Seg_out
	- thou_Seg_out
	- thou2_Seg_out
	- sign_Seg_out
Version:
	1.0
Authors:
	- Oscar Alejandro Cortes Acosta
	- Mario Eugenio Zuñiga Carrillo
Date:
	24/02/18
**********************************************************/
module Practica_1
#(
	parameter NBits = 8,
	parameter N2Bits = NBits*2
)
(
	/* Input */
	input clk,
	input reset,
	input start,
	input [NBits-1:0] multiplier,
	input [NBits-1:0] multiplicand,
	
	
	/* Outputs */
	output [6:0]uni_Seg_out,
	output [6:0]dec_Seg_out,
	output [6:0]cen_Seg_out,
	output [6:0]thou_Seg_out,
	output [6:0]thou2_Seg_out,
	output [6:0]sign_Seg_out
);

/* Wires of the result product */
wire [15:0] product;
wire [15:0] product_mux;
wire readyBit;
wire signBit;

/* Wires for the units of the BCD */
wire  [3:0] uni;
wire  [3:0] dec;
wire  [3:0] cen;
wire  [3:0] thou;
wire  [3:0] thou2;

/* Wires for the assigment for the segment display */
wire [19:0] seg_In;
wire [34:0] seg_Out;

/* Wire for the sign */
wire [6:0] sign_Seg;

/* The input of the segment is alligned with the values of the BCD output */
assign seg_In = {thou2, thou, cen, dec, uni};

/* Variable for the generate section */
genvar i;	


	/* Instance of the Sequential Multiplier */
 Seq_Multiplier SM1
(
	.clk(clk),
	.reset(reset),
	.start(start),
	.multiplier(multiplier),
	.multiplicand(multiplicand),
	.product(product),
	.readyBit(readyBit),
	.signBit(signBit)
);

/* Instance of the Multiplexer for the result output */
Multiplexer2to1 #(N2Bits) MUX_Seq_Out
(
	.Selector(readyBit),
	.MUX_Data0(16'b0),
	.MUX_Data1(product),
	.MUX_Output(product_mux)
);


/* Instance of the 16 bit BCD */
 BCD_16Bit BCD1
(
	
	.bits_in(product_mux),
	.uni(uni),
	.dec(dec),
	.cen(cen),
	.thou(thou),
	.thou2(thou2)
);

/* Instance of the Segment Sign */
 SegmentSign SS1
(
	.SignValue(signBit),
	.Value(product_mux),
	.Seg_Result(sign_Seg)
);

/* The following generate is instancing the segment displays
	for the numerical values */
generate
	for(i = 4; i < 21; i = i + 4) begin :Seg7
	
			SegmentDisplay SD
			(
				.value(seg_In[(i-1):(i-4)]),
				.Seg_Result(seg_Out[((7*(i/4))-1):((7*(i/4))-7)])
			);
			
	end: Seg7
endgenerate

/* The units are assigned to the specific numerical values */
assign uni_Seg_out = seg_Out[6:0];
assign dec_Seg_out = seg_Out[13:7];
assign cen_Seg_out = seg_Out[20:14];
assign thou_Seg_out = seg_Out[27:21];
assign thou2_Seg_out = seg_Out[34:28];
assign sign_Seg_out = sign_Seg;


endmodule
