module Binary_shift_three_adder
(
	// Input Ports
	input [3:0] In_Bits,

	// Output Ports
	output [3:0] Out_Bits
);
	//Logic Local Elements
	logic [3:0] Out_Bits_Logic;
	
always_comb
	begin	

		// 0		 0	       0             0 			   #0		
		if(~(In_Bits[3])&~(In_Bits[2])&~(In_Bits[1])&~(In_Bits[0]))
			Out_Bits_Logic = 4'b0000;

		//	0	      0             0             1		   #1	
		else if(~(In_Bits[3])&~(In_Bits[2])&~(In_Bits[1])&(In_Bits[0]))    
			Out_Bits_Logic = 4'b0001;

		//	0	      0             1             0		   #2
		else if(~(In_Bits[3])&~(In_Bits[2])&(In_Bits[1])&~(In_Bits[0]))
			Out_Bits_Logic = 4'b0010;
 
		//      0             0             1             1                #3
		else if(~(In_Bits[3])&~(In_Bits[2])&(In_Bits[1])&(In_Bits[0]))
			Out_Bits_Logic = 4'b0011;
		
		//      0             1           0             0                  #4
		else if(~(In_Bits[3])&(In_Bits[2])&~(In_Bits[1])&~(In_Bits[0]))
			Out_Bits_Logic = 4'b0100;
		
		//      0              1           0             1                 #5
		else if(~(In_Bits[3])&(In_Bits[2])&~(In_Bits[1])&(In_Bits[0]))
			Out_Bits_Logic = 4'b1000;
		
		//      0             1            1           0                   #6
		else if(~(In_Bits[3])&(In_Bits[2])&(In_Bits[1])&~(In_Bits[0]))
			Out_Bits_Logic = 4'b1001;
		
		//      0             1            1            1		   #7
		else if(~(In_Bits[3])&(In_Bits[2])&(In_Bits[1])&(In_Bits[0]))
			Out_Bits_Logic = 4'b1010;
		
		//       1           0             0             0		   #8
		else if((In_Bits[3])&~(In_Bits[2])&~(In_Bits[1])&~(In_Bits[0]))
			Out_Bits_Logic = 4'b1011;
		
		//       1           0            0              1                 #9
		else if((In_Bits[3])&~(In_Bits[2])&~(In_Bits[1])&(In_Bits[0]))
			Out_Bits_Logic = 4'b1100;
		
		//	X	     X            X              X		  	 #10, 11, 12, 13, 14, 15
		else
			Out_Bits_Logic = 4'b0000;
	 end
	 
	//We assign our Logic value to the output
	 assign Out_Bits = Out_Bits_Logic;
	 
endmodule
