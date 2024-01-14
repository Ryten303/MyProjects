
module BCD_2x7_units(units,units_seg,clk);

//INPUTS:
input [3:0] units;
input clk;
//units - BUS OF WIRES FROM (REGISTER THAT LATCHES THE NUMBER OF UNITS) TO (BCD_2X7_UNITS_DECODER)
//clk - WIRE FROM OUTPUT OF THE PLL TO THE BCD_2X7_UNITS_DECODER

//OUTPUT: 
output reg [6:0] units_seg;
//units_seg - REGISTER THAT LATCHES THE VALUE FOR 7-SEGMENT DISPLAY FOR UNITS


//////////////////////////////BCD_2X7_UNITS_DECODER/////////////////////////////////////////////////////////////
always @ (posedge clk)
begin
	case(units)
		0:	units_seg = 8'b1000000;
		1:	units_seg = 8'b1111001;
		2:	units_seg = 8'b0100100;
		3:	units_seg = 8'b0110000;
		4:	units_seg = 8'b0011001;
		5:	units_seg = 8'b0010010;
		6:	units_seg = 8'b0000010;
		7:	units_seg = 8'b1111000;
		8:	units_seg = 8'b0000000;
		9:	units_seg = 8'b0010000;
	endcase
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////