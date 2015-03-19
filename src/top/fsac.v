module fsac
(
	 sys_clk_25m	,
	 sys_rstn		,
	 
	 spi_clk		,
	 spi_cs_n	,
 	 spi_mosi	,
	 spi_miso	,
	 
	 spi_out_oe,
	 spi_rd_data,
	 spi_wr_data,
	 spi_reg_addr,
	 spi_rw,
	 spi_sel_end,
	
	 filter_switch

);
input sys_clk_25m ;
input sys_rstn		;
input spi_clk		;
input spi_mosi		;
input spi_cs_n		;

output spi_miso	;

input	[7:0]	spi_reg_addr	;
input	[7:0]	spi_wr_data		;
output[7:0]	spi_rd_data		;
input			spi_rw			;
output		spi_out_oe		;
input			spi_sel_end		;


output[7:0]	filter_switch	;

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
	.spi_rw(spi_rw),
	.spi_sel_end(spi_sel_end)
);




endmodule
