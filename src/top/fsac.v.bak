module fsac
(
	 sys_clk_25m	,
	 sys_rstn		,
	 
	 spi_clk		,
	 spi_cs_n	,
 	 spi_mosi	,
	 spi_miso	,	
	 filter_switch
 
);
input sys_clk_25m ;
input sys_rstn		;
input spi_clk		;
input spi_mosi		;
input spi_cs_n		;
output spi_miso	;

output[7:0]	filter_switch	;


wire	 spi_out_oe ;
wire	 spi_rw		;
wire 	 spi_data_start	;
wire	 spi_sel_end	;
wire [7:0]	 spi_rd_data	;
wire [7:0]	 spi_wr_data	;
wire [7:0]	 spi_reg_addr	;

wire [7:0]	 crc_data	;

spi_slave spi_interface(
// port map - connection between master ports and signals/registers   
	.sys_clk_25m(sys_clk_25m),
	.sys_rstn(sys_rstn),
	.spi_clk(spi_clk),
	.spi_cs_n(spi_cs_n),
	.spi_miso(spi_miso),
	.spi_mosi(spi_mosi),
	
	.spi_out_oe(spi_out_oe),
	.spi_rd_data(spi_rd_data),
	.spi_wr_data(spi_wr_data),
	.spi_reg_addr(spi_reg_addr),
	.spi_data_start(spi_data_start),
	.spi_rw(spi_rw),
	.spi_sel_end(spi_sel_end)
);

crc8 get_crc(
	.rstn(sys_rstn),
	.mdata_bit(spi_mosi),
	.en(spi_sel_start),
	.clk(spi_clk),
	.crc(crc_data)
);

reg_interface reg_if(
	.sys_clk_25m(sys_clk_25m)	,
	.sys_rstn(sys_rstn)	,
	.reg_addr(spi_reg_addr)	,
	.reg_wr_data(spi_wr_data)	,
	.reg_rd_data(spi_rd_data)	,
	.reg_rw_start(spi_data_start)	,
	.reg_rw_end(spi_sel_end)	,
	.reg_out_oe(spi_out_oe)	,
	.reg_rw(spi_rw)
);



endmodule
