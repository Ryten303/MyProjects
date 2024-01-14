module UART_TX(
	input clk,
	input [7:0]data_bus,
	input reset,
	input enable,
	output reg tx_done,
	output reg q
);

parameter Data_frame 		= 8;
parameter counter_border 	= 9'd435;
parameter IDLE					= 2'b00;
parameter TX_START			= 2'b01;
parameter DATA					= 2'b10;
parameter STOP					= 2'b11;


reg 			start_bit;
reg 			stop_bit;
reg [7:0]   data_reg;
reg [3:0]	data_index;
reg [8:0]	counter_clk;
reg 			tick;
reg [1:0]	state;
reg [1:0]	next_state;
/*
To achieve the requiered Baud rate of sending data we have to find
 the number of cycles of the clock after which to perform the operation of sending a byte of data.
 This number is stored in the counter_border parameter. It is calculated as such:
 
 Baud rate = 115200 bits/s = 14400 bytes/s
 T_bits = 1/14400 = 8680,6 ns
 
 f_clk = 50 MHz (reference clk for used FPGA)
 T_clk = 20 ns
 
 counter_border = T_bit/T_clk = 435;

 */
initial begin
tx_done   	<= 1'b0;
q         	<= 1'b1;
start_bit   <= 1'b0;
stop_bit  	<= 1'b0;
data_index	<= 4'b0000;
counter_clk	<= 9'b000000000;
tick 			<= 1'b0;
state 		<= IDLE;
end


always @(posedge clk) begin

if(!reset)  state<=IDLE;
else 			state<=next_state;

end

//next state combinational always
always @(*) begin

case (state)

IDLE: begin
if(enable) 		next_state <= TX_START;
else 				next_state <= IDLE;
end

TX_START: begin
if(tick) 		next_state <= DATA;
else 				next_state <= TX_START;
end

DATA: begin

if(stop_bit) 	next_state <= STOP;
else 				next_state <= DATA;

end

STOP: begin

if(tick) 		next_state <= IDLE;
else 				next_state <= STOP;

end
endcase

end 
// next_state clocked always
always @(posedge clk) begin


 
	 if(counter_clk < counter_border) begin
			counter_clk <= counter_clk+1'b1;
			tick			<= 1'b0;
	end

	else begin
			counter_clk	<= 9'b000000000;
			tick			<= 1'b1;
	end
 
	case (next_state)
		IDLE: begin
		
			tx_done   	<= 1'b0;
			q         	<= 1'b1;
			start_bit   <= 1'b0;
			stop_bit  	<= 1'b0;
			data_index	<= 4'b0000;
			counter_clk	<= 9'b000000000;
			tick 			<= 1'b0;
			tx_done		<= 1'b0;
		
		end
		
		TX_START: begin
		
			data_reg<=data_bus;
			q				<= 1'b0;
		
		end
		
		DATA: begin
		
		if(data_index<=4'b1000 && tick) begin
			stop_bit 	<=1'b0;
			q				<=data_reg[0];
			data_reg		<=data_reg>>1;
			data_index	<=data_index+3'b001;
			end
		else if(tick) 	begin
			stop_bit 	<=1'b1;
			data_index	<=3'b000;	
		end 
		end
		
		STOP: begin
		
		tx_done	<=1'b1;
		q			<=1'b1;
		
		end
		
	 endcase
 end



endmodule