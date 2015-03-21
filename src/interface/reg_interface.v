//*****************************
// name: reg_interface.v
// module: reg_interface
// author: caijun.Li
// description:
//
// date: 2015-03-20
// version:
// ****************************
module reg_interface(
	sys_clk_25m	,
	sys_rstn	,
	reg_addr	,
	reg_wr_data	,
	reg_rd_data ,
	reg_rw_start	,
	reg_rw_end	,
	reg_out_oe	,
	reg_rw	
);
input sys_clk_25m	;
input sys_rstn	;
input [7:0] reg_addr	;
input	[7:0] reg_wr_data	;
input reg_rw	;
input reg_rw_start	;
input reg_rw_end	;
output reg_out_oe	;
output [7:0] reg_rd_data	;

//parameter  Define
parameter REG_WIDTH = 8;

//
`define FILTER_CONTROL_ADDR	7'h10
// register define
reg [REG_WIDTH-1:0] fiter_ctrl	;
reg [REG_WIDTH-1:0] reg_rd_data_buf	;
reg reg_out_oe	;

assign reg_rd_data = reg_rd_data_buf;


always @(posedge sys_clk_25m)
begin
	if(~sys_rstn)
	begin
		fiter_ctrl = 7'h00;
		reg_rd_data_buf = 7'h00;
	end
	else
	if(reg_rw_start && reg_rw)
	//read
	begin
	case(reg_addr)
	`FILTER_CONTROL_ADDR:
		begin
			reg_rd_data_buf = fiter_ctrl;
		end
	
	
	endcase
	reg_out_oe = 1;
	end
	else
	if(reg_rw_start && ~reg_rw)
	//write
	begin
	case(reg_addr)
	`FILTER_CONTROL_ADDR:
		begin
			fiter_ctrl = reg_wr_data;
		end
	
	endcase
	end
	else
	if(reg_rw_end)
		reg_out_oe = 0;
end

endmodule
