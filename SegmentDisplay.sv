module SegmentDisplay
(
	// Inputs
	input [3:0]value,
	
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

	// Number 0
	if (value == 4'b0000)
		begin
			Seg0_log = 1'b0;
			Seg1_log = 1'b0;
			Seg2_log = 1'b0;
			Seg3_log = 1'b0;
			Seg4_log = 1'b0;
			Seg5_log = 1'b0;
			Seg6_log = 1'b1;
		end
	else
		
	// Number 1
	if (value == 4'b0001)
		begin
			Seg0_log = 1'b1;
			Seg1_log = 1'b0;
			Seg2_log = 1'b0;
			Seg3_log = 1'b1;
			Seg4_log = 1'b1;
			Seg5_log = 1'b1;
			Seg6_log = 1'b1;
		end
	else
		
	// Number 2
	if (value == 4'b0010)
		begin
			Seg0_log = 1'b0;
			Seg1_log = 1'b0;
			Seg2_log = 1'b1;
			Seg3_log = 1'b0;
			Seg4_log = 1'b0;
			Seg5_log = 1'b1;
			Seg6_log = 1'b0;
		end
	else
	
	// Number 3
	if (value == 4'b0011)
		begin
			Seg0_log = 1'b0;
			Seg1_log = 1'b0;
			Seg2_log = 1'b0;
			Seg3_log = 1'b0;
			Seg4_log = 1'b1;
			Seg5_log = 1'b1;
			Seg6_log = 1'b0;
		end
	else	
		
	// Number 4
	if (value == 4'b0100)
		begin
			Seg0_log = 1'b1;
			Seg1_log = 1'b0;
			Seg2_log = 1'b0;
			Seg3_log = 1'b1;
			Seg4_log = 1'b1;
			Seg5_log = 1'b0;
			Seg6_log = 1'b0;
		end
	else
		
	// Number 5
	if (value == 4'b0101)
		begin
			Seg0_log = 1'b0;
			Seg1_log = 1'b1;
			Seg2_log = 1'b0;
			Seg3_log = 1'b0;
			Seg4_log = 1'b1;
			Seg5_log = 1'b0;
			Seg6_log = 1'b0;
		end
	else
		
	// Number 6
	if (value == 4'b0110)
		begin
			Seg0_log = 1'b0;
			Seg1_log = 1'b1;
			Seg2_log = 1'b0;
			Seg3_log = 1'b0;
			Seg4_log = 1'b0;
			Seg5_log = 1'b0;
			Seg6_log = 1'b0;
		end
	else
		
	// Number 7
	if (value == 4'b0111)
		begin
			Seg0_log = 1'b0;
			Seg1_log = 1'b0;
			Seg2_log = 1'b0;
			Seg3_log = 1'b1;
			Seg4_log = 1'b1;
			Seg5_log = 1'b1;
			Seg6_log = 1'b1;
		end
	else
		
	// Number 8
	if (value == 4'b1000)
		begin
			Seg0_log = 1'b0;
			Seg1_log = 1'b0;
			Seg2_log = 1'b0;
			Seg3_log = 1'b0;
			Seg4_log = 1'b0;
			Seg5_log = 1'b0;
			Seg6_log = 1'b0;
		end
	else	
		
	// Number 9
	if (value == 4'b1001)
		begin
			Seg0_log = 1'b0;
			Seg1_log = 1'b0;
			Seg2_log = 1'b0;
			Seg3_log = 1'b0;
			Seg4_log = 1'b1;
			Seg5_log = 1'b0;
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

//We assign our Logic value to the output
assign Seg_Result = {Seg6_log, Seg5_log, Seg4_log, Seg3_log, Seg2_log, Seg1_log, Seg0_log};

endmodule 