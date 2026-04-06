/* TODO
	- Continue Adapting the UART sample
	- Connect the UART to the CPU interrupt
	- I stopped in the middle of adapting the uart example. So it is best to go over all of it. I mainly copied the important files and started (though not finished) adapting them.
	
*/

module UART(
	input clk_120mhz,
	input ftdi_txd, // from the ftdi chip
	output ftdi_rxd, // to the ftdi chip
);

    // send/recv data at on the FTDI port
    // 120 MHz / 40 == 3 megabaud
    wire uart_txd_ready;
    reg [7:0] uart_txd;
    reg uart_txd_strobe;
    wire uart_rxd_strobe;
    wire [7:0] uart_rxd;

    uart #(
		.DIVISOR(12500)
	) 
	uart_i
	(
	.clk_120mhz(clk_120mhz),
	.reset(reset),
	// physical interface
	.serial_txd(ftdi_rxd), // fpga --> ftdi
	.serial_rxd(ftdi_txd), // fpga <-- ftdi
	// logical interface
	.txd(uart_txd),
	.txd_ready(uart_txd_ready),
	.txd_strobe(uart_txd_strobe),
	.rxd(uart_rxd),
	.rxd_strobe(uart_rxd_strobe),
    );

    always @(posedge clk_120mhz) begin
		uart_txd_strobe <= 0;
	
		if (uart_rxd_strobe)
		begin
			// echo any input on the serial port back to the serial port
			led_reg <= uart_rxd;
			uart_txd <= uart_rxd;
			uart_txd_strobe <= 1;
		end 
    end
endmodule
