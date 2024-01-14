
module BCD_2x7_decimals(decimals,decimals_seg,clk);

//INPUTS:
input [2:0] decimals;
input clk;
//decimals - BUS OF WIRES FROM (REGISTER THAT LATCHES THE NUMBER OF DECIMALS) TO (BCD_2X7_DECIMALS_DECODER)
//clk - WIRE FROM OUTPUT OF THE PLL TO THE BCD_2X7_DECIMALS_DECODER

//OUTPUTS:
output reg [6:0] decimals_seg;
//decimals_seg - REGISTER THAT LATCHES THE VALUE FOR 7-SEGMENT DISPLAY FOR DECIMALS


//////////////////////////////BCD_2X7_DECIMALS_DECODER/////////////////////////////////////////////////////////////
always @ (posedge clk)
begin
	case(decimals)
		0:	decimals_seg = 7'b1000000;
		1:	decimals_seg = 7'b1111001;
		2:	decimals_seg = 7'b0100100;
		3:	decimals_seg = 7'b0110000;
		4:	decimals_seg = 7'b0011001;
		5:	decimals_seg = 7'b0010010;
		default: decimals_seg = 7'b0000110;
	endcase
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////