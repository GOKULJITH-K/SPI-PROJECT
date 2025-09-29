module top_mod(
	input PCLK,PRESET_n,PWRITE_i,PSEL_i,PENABLE_i,miso_i,
	input [2:0] PADDR_i,
	input [7:0] PWDATA_i,
	output ss_o,sclk_o,spi_interrupt_request_o,mosi_o,PREADY_o,PSLVERR_o,
	output [7:0] PRDATA_o
);

wire ss,tip,recieve_data,spiswai,cpol,cpha,send_data,lsbfe,miso_recieve_sclk,miso_recieve_sclk0,mosi_send_sclk,mosi_send_sclk0,mstr;
wire [11:0] Baudratedivisor;
wire [1:0] spi_mode;
wire [2:0] sppr,spr;
wire [7:0] data_mosi,data_miso;


spi_slave_interface B1(.PCLK(PCLK),.PRESET_n(PRESET_n),.PWRITE_i(PWRITE_i),.PSEL_i(PSEL_i),.PENABLE_i(PENABLE_i),.ss_i(ss),.recieve_data_i(recieve_data),.tip_i(tip),.PADDR_i(PADDR_i),.PWDATA_i(PWDATA_i),.miso_data_i(data_miso),.mstr_o(mstr),.cpol_o(cpol),.cpha_o(cpha),.lsbfe_o(lsbfe),.spiswai_o(spiswai),.spi_interrupt_request_o(spi_interrupt_request_o),.PREADY_o(PREADY_o),.PSLVERR_o(PSLVERR_o),.send_data_o(send_data),.mosi_data_o(data_mosi),.spi_mode_o(spi_mode),.sppr_o(sppr),.spr_o(spr),.PRDATA_o(PRDATA_o));

spi_baud_generator B2(.PCLK(PCLK),.PRESET_n(PRESET_n),.cpol_i(cpol),.cpha_i(cpha),.spiswai_i(spiswai),.sppr_i(sppr),.ss_i(ss),.spr_i(spr),.BaudRateDivisor_o(Baudratedivisor),.sclk_o(sclk_o),.spi_mode_i(spi_mode),.miso_recieve_sclk_o(miso_recieve_sclk),.miso_recieve_sclk0_o(miso_recieve_sclk0),.mosi_send_sclk_o(mosi_send_sclk),.mosi_send_sclk0_o(mosi_send_sclk0));

spi_slave_select B3(.PCLK(PCLK),.PRESET_n(PRESET_n),.mstr_i(mstr),.spiswai_i(spiswai),.send_data_i(send_data),.spi_mode_i(spi_mode),.BaudRateDivisor_i(Baudratedivisor),.recieve_data_o(recieve_data),.ss_o(ss),.tip_o(tip));

spi_shift_reg B4(.PCLK(PCLK),.PRESET_n(PRESET_n),.ss_i(ss),.send_data_i(send_data),.lsbfe_i(lsbfe),.cpha_i(cpha),.cpol_i(cpol),.miso_recieve_sclk_i(miso_recieve_sclk),.miso_recieve_sclk0_i(miso_recieve_sclk0),.mosi_send_sclk_i(mosi_send_sclk),.mosi_send_sclk0_i(mosi_send_sclk0),.data_mosi_i(data_mosi),.miso_i(miso_i),.recieve_data_i(recieve_data),.mosi_o(mosi_o),.data_miso_o(data_miso));

assign ss_o=ss;

endmodule
