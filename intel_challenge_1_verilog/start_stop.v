
module start_stop(clk,start_stop,count_enable);

//INPUTS
input clk;
input start_stop;
//clk - WIRE FROM (OUTPUT OF PLL) TO (START_STOP SHIFT REGISTER)
//start_stop - WIRE FROM (START_STOP PUSH-BUTTON) TO (START_STOP SHIFT REGISTER) 

//OUTPUTS:
output reg count_enable;
//count_enable - REGISTER THAT KEEPS THE STATE OF START_STOP

//OTHER NETS AND VARIABLES:
reg [1:0] start_stop_shift;
//start_stop_shift - REGISTER THAT PRODUCES ASYNCHRONOUS SIGNAL FOR COUNT_ENABLE

//////////////////////////////START_STOP////////////////////////////////////////////////////////////////////////
always @(posedge clk)
 begin
		start_stop_shift <= {start_stop_shift,start_stop};
	if (start_stop_shift[0] & ~start_stop_shift[1])
		count_enable <= ~count_enable;
 end
endmodule 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////