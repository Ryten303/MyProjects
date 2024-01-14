module Top_module(

input [7:0] data,
input clk,
input transmit,
input btn,
output TxD
//output TxD_debug,
//output transmit_debug,
//output btn_debug,
//output clk_debug
);

wire transmitting_out;

UART_transmitter T1(clk,reset,transmit,data,TxD);
Debounce_Signals DB(clk,btn,transmit_out);

//assign TxD_debug = TxD;
//assign transmit_debug = transmit_out;
//assign btn_debug = reset;
//assign clk_debug = clk;

endmodule 