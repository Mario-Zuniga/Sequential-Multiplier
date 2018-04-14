
module Multiplexer2to1
#(
	parameter NBits=32
)
(
	input Selector,
	input [NBits-1:0] MUX_Data0,
	input [NBits-1:0] MUX_Data1,
	
	output [NBits-1:0] MUX_Output

);

	logic [NBits-1:0] Mux_Output_Logic;

	always_comb
	
	begin
		if(Selector)
			Mux_Output_Logic = MUX_Data1;
		else
			Mux_Output_Logic = MUX_Data0;
	end
	
	assign MUX_Output = Mux_Output_Logic;

endmodule
