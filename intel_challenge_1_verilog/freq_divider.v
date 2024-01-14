
module freq_divider(clk,count,reset_enable);

//INPUTS:
input clk,reset_enable;
//clk - WIRE FROM OUTPUT OF THE PLL TO THE FREQUENCY DIVIDER 

//OUTPUTS:
output reg [23:0] count;
//count - REGISTER THAT DIVIDES THE PLL OUTPUT SIGNAL AND PRODUCES 1 Hz SIGNAL

//////////////////////////////FREQUENCY DIVIDER//////////////////////////////////////////////////////////////////
always @(posedge clk)
begin
	if (reset_enable)
		count <= 0;
	count <=count + 1;
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////