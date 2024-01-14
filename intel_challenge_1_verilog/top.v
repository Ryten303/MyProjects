
module top(reset,board_clk,units_seg,decimals_seg,start_stop);

//INPUTS:
input wire start_stop;
input wire board_clk;
input wire reset;
//start_stop - WIRE FROM (PUSH-BUTTON THAT STARTS AND HOLDS THE SECOND COUNTER) TO (START_STOP SHIFT REGISTER)
//board_clk - WIRE FROM (50 MHz CLOCK) TO (THE PLL INPUT)
//reset - WIRE FROM (PUSH-BUTTON THAT RESETS THE SECOND COUNTER) TO (RESET SHIFT REGISTER)

//OUTPUTS:
output wire [6:0] units_seg;
output wire [6:0] decimals_seg;
//units_seg - BUS OF WIRES FROM (REGISTER THAT LATCHES VALUE FOR 7-SEGMENT DISPLAY FOR UNITS) TO (7-SEGMENT DISPLAY FOR UNITS) 
//units_seg - BUS OF WIRES FROM (REGISTER THAT LATCHES VALUE FOR 7-SEGMENT DISPLAY FOR DECIMALS) TO (7-SEGMENT DISPLAY FOR DECIMALS) 

//OTHER NETS AND VARIABLES:
wire  clk;
wire  [3:0] units;
wire  [2:0] decimals;
wire  [23:0] count;
wire reset_enable;
wire count_enable; 
//clk - WIRE FROM (OUTPUT OF THE PLL) TO (FREQ_DIVIDER, BCD_2X7_UNITS_DECODER, BCD_2X7_DECIMALS_DECODER,RESET,START_STOP,BCD_COUNTER)
//units - BUS OF WIRES FROM (REGISTER THAT LATCHES THE NUMBER OF UNITS IN BCD_COUNTER) TO (BCD_2X7_UNITS_DECODER)
//decimals - BUS OF WIRES FROM (REGISTER THAT LATCHES THE NUMBER OF DECIMALS IN BCD_COUNTER) TO (BCD_2X7_DECIMALS_DECODER)
//reset_enable - WIRE FROM (RESET SHIFT REGISTER) TO (BCD COUNTER AND FREQ_DIVIDER)
//count_enable - WIRE FROM (START_STOP SHIFT REGISTER) TO (BCD COUNTER)

/////////////////////////////////MAIN MODULE///////////////////////////////////////////////////////////////////////////////////////////////

//PLL:
pll_0002 pll_inst (
		.refclk   (board_clk),   //  refclk.clk
		.rst      (),      //   reset.reset
		.outclk_0 (clk), // outclk0.clk
		.locked   ()          // (terminated)
	);
//START/STOP BUTTON:
start_stop u0(
	.clk(clk),
	.start_stop(start_stop),
	.count_enable(count_enable)
	);
//RESET BUTTON:
reset u1(
	.clk(clk),
	.reset(reset),
	.reset_enable(reset_enable)
	);	 
//FREQUENCY DIVIDER
freq_divider u2(
	.clk(clk),
	.count(count),
	.reset_enable(reset_enable)
	);
//BCD COUNTER
BCD_counter u3(
	.count(count),
	.clk(clk),
	.decimals(decimals),
	.units(units),
	.count_enable(count_enable),
	.reset(reset)
	);
//BCD_2X7_UNITS_DECODER		
BCD_2x7_units u4(
	.units(units),
	.units_seg(units_seg),
	.clk(clk)
	);
//BCD_2X7_DECIMALS_DECODER
BCD_2x7_decimals u5(
	.decimals(decimals),
	.decimals_seg(decimals_seg),
	.clk(clk)
	);			
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
