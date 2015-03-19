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
`timescale 1ns/100ps

module spi_slave
	(
    sys_clk_25m	,
	 sys_rstn		,
	 
	 spi_clk		,
	 spi_cs_n	,
 	 spi_mosi	,
	 spi_miso	,

	 spi_out_oe	,
 	
	 spi_reg_addr	,
	 spi_wr_data	,
	 spi_rd_data	,
	 spi_rw			,
	 spi_sel_end
	 	  
	);
input sys_clk_25m ;
input sys_rstn		;
input spi_clk		;
input spi_mosi		;
input spi_cs_n		;

output spi_miso	;

output	[7:0]	spi_reg_addr	;
output	[7:0]	spi_wr_data		;
input		[7:0]	spi_rd_data		;
output			spi_rw			;
input				spi_out_oe		;
output			spi_sel_end		;

//-------------------------
// Define parmeters
//-------------------------
parameter	UDLY	=2;

reg [2:0]	spi_clk_reg			;
reg [2:0]	spi_csn_reg			;
reg [1:0]	spi_mosi_reg		; 
reg [2:0]	spi_bitcnt			; // receve bit counter
reg [7:0]	spi_data_fifo		; // receve fifo register
reg [7:0]	spi_wr_data			; // data register
reg 			spi_recved_byte	; // receved one byte
reg [1:0]	spi_data_cnt		; // receved byte counter
//reg [7:0]	spi_addr_reg		; // command and adress value
reg [7:0]	spi_reg_addr		; // command and adress value
reg			spi_rw				;

//
// sync SCK to the FPGA clock using a 3-bits shift register
wire sck_risingedge = (spi_clk_reg[2:1]==2'b01);
wire sck_fallingedge = (spi_clk_reg[2:1]==2'b10);
wire spi_sel_active = ~spi_csn_reg[1];
wire spi_sel_start = (spi_csn_reg[2:1]==2'b10);
wire spi_sel_end = (spi_csn_reg[2:1]==2'b01);
wire spi_mosi_data = spi_mosi_reg[1];


always @(posedge sys_clk_25m)
	spi_csn_reg <= {spi_csn_reg[1:0],spi_cs_n};
	

always @(posedge sys_clk_25m)
	spi_clk_reg <= {spi_clk_reg[1:0],spi_clk};


always @(posedge sys_clk_25m)
	spi_mosi_reg <= {spi_mosi_reg[0],spi_mosi};

always @(posedge sys_clk_25m)
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


always @(posedge sys_clk_25m)
	spi_recved_byte <= spi_sel_active && sck_risingedge && (spi_bitcnt == 3'b111);

always @(negedge sys_clk_25m)
begin
  if(~spi_sel_active)
	  spi_data_cnt <= 2'b00;
  else
  if(spi_recved_byte)
  begin
	  spi_data_cnt <= spi_data_cnt + 2'b01;
	  spi_wr_data <= spi_data_fifo[7:0];
  end
end

always @(posedge sys_clk_25m)
begin
  if(spi_data_cnt==2'b01)
  begin
	  //spi_addr_reg <={1'b0,spi_wr_data[6:0]};
	  //spi_reg_addr <= spi_addr_reg;
	  spi_reg_addr <= {1'b0,spi_wr_data[6:0]};
  	  spi_rw = spi_wr_data[7];
  end
  //else
  //if(spi_data_cnt==2'b10)
  //begin
	  //address and data receved
  //end
end
//assign spi_rw = spi_wr_data[7];
endmodule


