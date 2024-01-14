
module BCD_counter(clk,reset,decimals,units,start_stop_reg,count,count_enable);

//INPUTS:
input start_stop_reg;
input clk;
input reset;
input count_enable;
input wire [23:0] count;
//start_stop_reg - WIRE FROM (FLIP-FLOP THAT KEEPS STATE OF START/STOP) TO (BCD COUNTER)
//clk - WIRE FROM (PLL OUTPUT) TO (BCD COUNTER)
//reset - WIRE FROM (PUSH-BUTTON INPUT) TO (BCD COUNTER)
//count - BUS OF WIRES FROM (FREQ_DIVIDER) TO (BCD_COUNTER)

//OUTPUTS:
output reg  [2:0] decimals;
output reg [3:0] units;
//decimals - REGISTER THAT STORES NUMBER OF DECIMALS
//units -  REGISTER THAT STRORES NUMBER OF UNITS


//////////////////////////////BCD COUNTER////////////////////////////////////////////////////////////////////////
always @(posedge(clk))
		begin
		if(count_enable)
		begin
/////////RESET
			if(reset == 0)
				begin
					decimals <= 0;
					units <= 0;
				end
/////////START/STOP
			
///////////////WHEN ONE SECOND PASSES THE COUNT REGISTER HAS VALUE 0
					if (count == 0)
/////////////////////RESET COUNTER AFTER VALUE 59
							if (decimals == 3'b101 && units == 4'b1001)
								begin
									decimals <= 0;
									units <= 0;
								end
/////////////////////IF UNITS HAS VALUE 9, RESET UNITS AND ADD 1 TO DECIMALS
							else if (units == 4'b1001)
								begin
									units <= 0;
									decimals <= decimals + 1;
								end
/////////////////////ELSE ADD 1 TO UNITS
							else
								begin
									units <= units + 1;
								end
					end	
				end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////