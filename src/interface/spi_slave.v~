
//*****************************
// name: spi_slave.v
// module: spi_slave
// author: caijun.Li
// description:
//
// date: 2015-03-18
// version:
// ****************************
//
module spi_slave
	(
	 spi_clk	,
	 spi_cs_n	,
 	 spi_mosi	,
	 spi_miso	,
 		
	 spi_redy	,
	 spi_start	,
	 spi_reg_addr	,
	 spi_wr_data	,
	 spi_rd_data	,
	 spo_rw		
	 	 
	 
	);

input spi_clk	;
input spi_mosi	;
input spi_cs_n	;

output spi_miso	;

output	spi_redy	;
input	spi_start	;
input	spi_rw		;
input	[7:0]	spi_reg_addr	;
input	[7:0]	spi_wr_data	;
output	[7:0]	spi_rd_data	;


//-------------------------
// Define parmeters
//-------------------------
parameter	UDLY	=2;
		IDLE	=6'b00_0001,
		CHIP_SEL	=6'b00_0010,
		REG_ADDR	=6'b00_0100,
		WR_DATA		=6'b00_1000,
		RD_DATA		=6'b01_0000,
		CHIP_DESEL	=6'b10_0000;
