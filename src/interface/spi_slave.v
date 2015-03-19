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
	 sys_rstn	,

	 spi_clk	,
	 spi_cs_n	,
 	 spi_mosi	,
	 spi_miso	,

	 spi_out_oe	,
 		
	 spi_reg_addr	,
	 spi_wr_data	,
	 spi_rd_data	,
	 spi_rw		
	 	 
	 
	);

input spi_clk	;
input spi_mosi	;
input spi_cs_n	;

output spi_miso	;

output	[7:0]	spi_reg_addr	;
output	[7:0]	spi_wr_data	;
input	[7:0]	spi_rd_data	;
output		spi_rw		;
input		spi_out_oe	;

//-------------------------
// Define parmeters
//-------------------------
parameter	UDLY	=2;

reg [2:0]	spi_clk_reg	;
reg [2:0]	spi_csn_reg	;
reg [1:0]	spi_mosi_reg	;
reg [2:0]	spi_bitcnt	;
reg [7:0]	spi_data_fifo	;
reg 		spi_recved_byte	;
reg [1:0]	spi_data_cnt	;
reg [7:0]	spi_addr_reg	;


//
// sync SCK to the FPGA clock using a 3-bits shift register
wire sck_risingedge = (spi_clk_reg[2:1]==2'b01);
wire sck_fallingedge = (spi_clk_reg[2:1]==2'b10);
wire spi_sel_active = ~spi_csn_reg[1];
wire spi_sel_start = (spi_csn_reg[2:1]==2'b10);
wire spi_sel_end = (spi_csn_reg[2:1]==2'b01);
wire spi_mosi_data = spi_mosi_reg[1];


always @(posedge spi_clk)
	spi_csn_reg <= {spi_csn_reg[1:0],spi_cs_n};
	

always @(posedge spi_clk)
	spi_clk_reg <= {spi_clk_reg[1:0],spi_clk};


always @(posedge spi_clk)
	spi_mosi_reg <= {spi_mosi_regi[0],spi_mosi};

always @(posedge spi_clk)
begin
  if(~spi_sel_active)
	  spi_bitcnt <= 3'b000;
  else
  if(sck_risingedge)
  begin
	  spi_bitcnt <= spi_bitcnt + 3'b001;
	  spi_data_fifo	<= {spi_data_fifo[6:0],spi_mosi};
  end
end


always @(posedge spi_clk)
	spi_recved_byte <= spi_sel_active && sck_risingedge && (spi_bitcnt == 3'b111);

always @(posedge spi_clk)
begin
  if(spi_receved_byte)
	  spi_data_cnt <= spi_data_cnt + 2'b01;
end

always @(posedge spi_clk)
begin
  if(spi_data_cnt==2'b01)
	  spi_addr_reg <={1'b0,spi_data_fifo[6:0]};
  	  spi_rw <= spi_data_fifo[7];
  else
  if(spi_data_cnt==2'b10)
	  spi_data





