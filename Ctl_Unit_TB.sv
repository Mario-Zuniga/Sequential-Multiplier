
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module Ctl_Unit_TB;


 // Input Ports
bit start=1;
bit reset;
bit clk = 0;


	
// Output Ports
wire one_shot;
wire first;
wire ready;


Ctl_Unit DUT
(
	//Inputs
	.start(start),
	.reset(reset),
	.clk(clk),
	
	//Outputs
	.one_shot(one_shot),
	.first(first),
	.ready(ready)

);	

/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset = 0;
	#5 reset = 1;
end



endmodule
