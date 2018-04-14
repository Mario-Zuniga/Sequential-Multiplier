module Binary_a2_complement_converter
(
	// Input Ports
	input [7:0] In_Bits,

	// Output Ports
	output [7:0] Out_Bits,
	output Sign
);
	//Logic Local Elements
	logic [7:0] Out_Bits_Logic;
	logic Sign_Logic;

	always_comb
	begin	
		
		//We check if the sign in the MSB to identify if its a postive or negative number 
		if((In_Bits[7]))
		begin
			Out_Bits_Logic = ~In_Bits+8'b00000001;
			Sign_Logic = 1'b1;
		end
		else
		begin
			Out_Bits_Logic = In_Bits;
			Sign_Logic = 1'b0;
		end
	
	end
	
	//We assign our Logic value to the output
	assign Out_Bits = Out_Bits_Logic;
	assign Sign = Sign_Logic;
	
endmodule
