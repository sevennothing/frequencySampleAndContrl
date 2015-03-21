//*****************************
// name: crc8.v
// module: crc8
// author: caijun.Li
// description:
//
// date: 2015-03-21
// version:
// ****************************
//
`timescale 1ns/100ps
module crc8(
	rstn		,
	mdata_bit		,
	en			,
	clk	,
	crc
);
input rstn		;
input mdata_bit	;
input	en			;
input clk	;
output[7:0] crc		;

reg [7:0] crc;

wire bitval;

assign bitval = mdata_bit^crc[7];

always @(posedge clk or negedge rstn)
begin
	if (!rstn)
		crc = 0;
	else
	begin
		if(en == 1) 
		begin
		crc[7] = crc[6];
		crc[6] = crc[5];
		crc[5] = crc[4];
		crc[4] = crc[3] ^ bitval;
		crc[3] = crc[2];
		crc[2] = crc[1];
		crc[1] = crc[0];
		crc[0] = bitval;
		end
	end
end

endmodule



/*
module crc8(
	rstn		,
	mdata		,
	en			,
	clk	,
	crc
);
input rstn		;
input [15:0]	mdata	;
input	en			;
input clk	;
output[7:0] crc		;

reg [7:0] crc;
reg [7:0] crc_tmp;

wire bitval;

reg feedback	;

always @(posedge clk or negedge rstn)
begin
	if(!rstn)
		crc <= 7'b00000000;
	else if(en == 1'b0)
		crc <= 7'b00000000;
	else
		crc <= crc_tmp;
end

always @(posedge mdata or crc)
begin
	crc_tmp = crc;
	for(i=7; i>=0; i=i-1)
	begin
		feedback = crc_tmp[7] ^ mdata[i];
		crc_tmp[7] = crc_tmp[6];
		crc_tmp[6] = crc_tmp[5];
		crc_tmp[5] = crc_tmp[4];
		crc_tmp[4] = crc_tmp[3] ^ feedback;
		crc_tmp[3] = crc_tmp[2];
		crc_tmp[2] = crc_tmp[1];
		crc_tmp[1] = crc_tmp[0];
		crc_tmp[0] = feedback;
	end
end



endmodule
*/