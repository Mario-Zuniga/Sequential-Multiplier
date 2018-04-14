module SegmentSign
(
	// Inputs
	input SignValue,
	input [15:0] Value,
	
	// Outputs
	output [6:0]Seg_Result
);

logic Seg0_log;
logic Seg1_log;
logic Seg2_log;
logic Seg3_log;
logic Seg4_log;
logic Seg5_log;
logic Seg6_log;

always_comb begin: SegDis
	
	if (Value==16'b0)
		begin
			Seg0_log = 1'b1;
			Seg1_log = 1'b1;
			Seg2_log = 1'b1;
			Seg3_log = 1'b1;
			Seg4_log = 1'b1;
			Seg5_log = 1'b1;
			Seg6_log = 1'b1;
		end
	else 
		begin
		
		// Sign
		if (SignValue == 1'b1)
			begin
				Seg0_log = 1'b1;
				Seg1_log = 1'b1;
				Seg2_log = 1'b1;
				Seg3_log = 1'b1;
				Seg4_log = 1'b1;
				Seg5_log = 1'b1;
				Seg6_log = 1'b0;
			end
		else
			begin
				Seg0_log = 1'b1;
				Seg1_log = 1'b1;
				Seg2_log = 1'b1;
				Seg3_log = 1'b1;
				Seg4_log = 1'b1;
				Seg5_log = 1'b1;
				Seg6_log = 1'b1;
			end
		end


end

//We assign our Logic value to the output
assign Seg_Result = {Seg6_log, Seg5_log, Seg4_log, Seg3_log, Seg2_log, Seg1_log, Seg0_log};

endmodule 
