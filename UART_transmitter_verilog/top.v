module top (
input clk,
input reset,
input data_bus,
output q,
output tx_done

);

wire tick_wire;

BAUD_RATE_GEN BAUD_RATE_GEN(
						.clk(clk),
						.out_tick(tick_wire)
);

UART_TX UART_TX(
						.clk(clk),
						.reset(reset),
						.data_bus(data_bus),
						.tick(tick_wire),
						//.enable(enable),
						.q(q),
						.tx_done(tx_done)
);
endmodule