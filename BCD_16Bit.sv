/**********************************************************
Module Name: 
	BCD_16Bit.sv
Description: 
	Transforms 16 bit values from binary to BCD
Inputs:
	- bits_in
Outputs:
	- uni
	- dec
	- cen
	- thou
	- thou2
Version:
	1.0
Authors:
	- Oscar Alejandro Cortes Acosta
	- Mario Eugenio Zuñiga Carrillo
Date:
	24/02/18
**********************************************************/

module BCD_16Bit
(
	/* Inputs */
	input [15:0]bits_in,
	
	/* Outputs */
	output [3:0]uni,
	output [3:0]dec,
	output [3:0]cen,
	output [3:0]thou,
	output [3:0]thou2
);

/* Variables for the generate cycles */
genvar i;			// For cycle Binaries
genvar j;			// For cycle Binaries_2
genvar k;			// For cycle Binaries_3
genvar l;			// For cycle Binaries_4


/* Wires for the interconections between modules */
wire [56:0]For0_wire;		// Conections in Binaries
wire [56:0]For1_wire;		// Conections in Binaries_2
wire [56:0]For2_wire;		// Conections in Binaries_3
wire [56:0]For3_wire;		// Conections in Binaries_4

/* Wire to catch the values for the outputs*/
wire [19:0]bits_out;



//								Specific Instances
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
/* First module of first stage has an specific instance declaration  */
Binary_shift_three_adder
C1
(
	.In_Bits({1'b0,bits_in[15:13]}),
	.Out_Bits({For0_wire[3:0]})
);

/* First module of second stage has an specific instance declaration  */
Binary_shift_three_adder
C14
(
	.In_Bits({1'b0,For0_wire[3],For0_wire[7],For0_wire[11]}),
	.Out_Bits({For1_wire[3:0]})
);


/* First module of third stage has an specific instance declaration  */
Binary_shift_three_adder
C24
(
	.In_Bits({1'b0,For1_wire[3],For1_wire[7],For1_wire[11]}),
	.Out_Bits({For2_wire[3:0]})
);


/* First module of fourth stage has an specific instance declaration  */
Binary_shift_three_adder
C31
(
	.In_Bits({1'b0,For2_wire[3],For2_wire[7],For2_wire[11]}),
	.Out_Bits({bits_out[19],For3_wire[2:0]})
);

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////




/* Generation of instances for the Binary Shift Three Adder */
generate
	
	/* Binary cycle 1 */
	for(i = 0; i < 48; i = i + 4) begin:Binaries
	
	/* We check if it's the last one */
	if(i == 44) begin
		Binary_shift_three_adder
		C_Stage1
		(
			.In_Bits({For0_wire[i+2:i+0],bits_in[12-(i/4)]}),
			.Out_Bits({bits_out[4:1]})
		);
	end
	else
	
	/* If not, continue with the regular instance */
	begin
		Binary_shift_three_adder
		C_Stage1
		(
			.In_Bits({For0_wire[i+2:i+0],bits_in[12-(i/4)]}),
			.Out_Bits({For0_wire[i+7:i+4]})
		);
	end
	end:Binaries
	
	
	
	/* Binary cycle 2 */
	for(j = 0; j < 36; j = j + 4) begin:Binaries_2
	
	/* We check if it's the last one */
	if(j == 32) begin
		Binary_shift_three_adder
		C_Stage2
		(
			.In_Bits({For1_wire[j+2:j+0],For0_wire[15+j]}),
			.Out_Bits({bits_out[8:5]})
		);
	end
	else
	
	/* If not, continue with the regular instance */
	begin
		Binary_shift_three_adder
		C_Stage2
		(
			.In_Bits({For1_wire[j+2:j+0],For0_wire[15+j]}),
			.Out_Bits({For1_wire[j+7:j+4]})
		);
	end
	end:Binaries_2
	
	
	
	/* Binary cycle 3 */
	for(k = 0; k < 24; k = k + 4) begin:Binaries_3
	
	/* We check if it's the last one */
	if(k == 20) begin
		Binary_shift_three_adder
		C_Stage3
		(
			.In_Bits({For2_wire[k+2:k+0],For1_wire[15+k]}),
			.Out_Bits({bits_out[12:9]})
		);
	end
	else
	
	/* If not, continue with the regular instance */
	begin
		Binary_shift_three_adder
		C_Stage3
		(
			.In_Bits({For2_wire[k+2:k+0],For1_wire[15+k]}),
			.Out_Bits({For2_wire[k+7:k+4]})
		);
	end
	end:Binaries_3
	
	
	
	
	/* Binary cycle 4 */
	/* Due that every instance of this cycle has different outputs, each 
		cycle will have an if to specify those outputs */
	for(l = 0; l < 12; l = l + 4) begin:Binaries_4
	
	/* First case */
	if(l == 0)
	begin
		Binary_shift_three_adder
		C_Stage4
		(
			.In_Bits({For3_wire[l+2:l+0],For2_wire[15+l]}),
			.Out_Bits({bits_out[18-l],For3_wire[l+6:l+4]})
		);
	end
	
	/* Second case */
	if(l == 4)
	begin
	Binary_shift_three_adder
	C_Stage4
	(
		.In_Bits({For3_wire[l+2:l+0],For2_wire[15+l]}),
		.Out_Bits({bits_out[17],For3_wire[l+6:l+4]})
	);
	end
	
	/* Third case */
	if(l == 8) begin
		Binary_shift_three_adder
		C_Stage4
		(
			.In_Bits({For3_wire[l+2:l+0],For2_wire[15+l]}),
			.Out_Bits({bits_out[16:13]})
		);
	end
	
	end:Binaries_4
	
endgenerate

/* The bit 0 goes directly to the output */
assign bits_out[0] = bits_in[0];

/* The output values are assigned */
assign uni = bits_out[3:0];
assign dec = bits_out[7:4];
assign cen = bits_out[11:8];
assign thou = bits_out[15:12];
assign thou2 = bits_out[19:16];

endmodule
