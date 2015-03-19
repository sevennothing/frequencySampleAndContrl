
//*****************************
// name: spi.v
// module: spi
// author: caijun.Li
// description:
//
// date: 2015-03-18
// version:
// ****************************
//
module spi
	(
	 sys_clk_25m	,
	 sys_rstn	,

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
parameter	SPI_DATA_WIDTH	=8;
parameter	SPI_DATA_BITS	=3;
parameter	IDLE	=6'b00_0001,
		CHIP_SEL	=6'b00_0010,
		REG_ADDR	=6'b00_0100,
		WR_DATA		=6'b00_1000,
		RD_DATA		=6'b01_0000,
		CHIP_DESEL	=6'b10_0000;

reg [5:0]			current_spi_state	;
reg [5:0]			next_spi_state	;
reg [7:0]			spi_addr_reg	;
reg [SPI_DATA_WIDTH-1:0]	spi_wdata_reg	;
reg 				spi_rw		;	
reg [7:0]			spi_start_reg	;
reg				spi_start_wide	;

reg [4:0]			reg_addr_state_cnt	;
reg [SPI_DATA_BITS:0]		wdata_state_cnt	;
reg [SPI_DATA_BITS:0]		rdata_state_cnt	;



reg [15:0]			reg_addr_shift	;
reg [SPI_DATA_WIDTH-1:0]	wr_data_shift	;
reg [SPI_DATA_WIDTH-1:0]	spi_rd_data	;

reg				spi_cs_n	;
reg				spi_clk		;
reg				spi_redy	;
reg				spi_mosi	;



