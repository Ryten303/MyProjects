
module reset(clk,reset,reset_enable);

//INPUTS:
input clk;
input reset;
//clk - WIRE FROM (OUTPUT OF PLL) TO (RESET SHIFT REGISTER)
//reset - WIRE FROM (RESET PUSH-BUTTON) TO (RESET SHIFT REGISTER)

//OUTPUT:
output reg reset_enable;
//reset_enable - REGISTER THAT KEEPS THE STATE OF RESET

//OTHER NETS AND VARIABLES
reg [1:0] reset_shift;
//reset_shift - REGISTER THAT PRODUCES ASYNCHRONOUS SIGNAL FOR RESET_ENABLE

//////////////////////////////RESET/////////////////////////////////////////////////////////////////////////////
always @(posedge clk)
 begin
		reset_shift <= {reset_shift,reset};
	if (reset_shift[0] & ~reset_shift[1])
		reset_enable <= 1;
 end
endmodule 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////