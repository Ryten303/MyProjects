`timescale 1ns/1ps
module tb(); 

reg clk;
reg reset;
reg [7:0] data_bus;
reg enable; 

wire q;
wire tx_done;

initial begin

clk 		<= 1'b0;
reset 	<= 1'b1;
enable 	<= 1'b0;
data_bus <= 8'b10010011;

end

always begin

#10;
clk<=~clk;

end


initial begin

#50
enable 	<= 1'b1;
//#18000
//enable 	<= 1'b0;
#8800
reset 	<= 1'b0;

#1000
reset 	<= 1'b1;

end

UART_TX UART_TX(
						.clk(clk),
						.reset(reset),
						.data_bus(data_bus),
						.enable(enable),
						.q(q),
						.tx_done(tx_done)
);

endmodule