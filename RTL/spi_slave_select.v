module spi_slave_select(
input PCLK,PRESET_n,mstr_i,spiswai_i,send_data_i,
input [1:0]  spi_mode_i,
input [11:0] BaudRateDivisor_i,
output reg recieve_data_o,ss_o,
output tip_o
);

reg [15:0] count_s;
wire [15:0] target_s;
reg rcv_s;

assign target_s=(BaudRateDivisor_i/2)*16;
assign tip_o=~ss_o;

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
	recieve_data_o<=1'b0;
	else
	recieve_data_o<=rcv_s;
end

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
	rcv_s<=1'b0;
	else if(~(!spiswai_i && (spi_mode_i==2'b00||spi_mode_i==2'b01)&&mstr_i))
	rcv_s<=1'b0;
	else if(send_data_i)
	rcv_s<=1'b0;
	else if(~(count_s<=target_s-1'b1))
	rcv_s<=1'b0;
	else if(count_s==target_s-1'b1)
	rcv_s<=1'b1;
	else
	rcv_s<=1'b0;
end

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
	ss_o<=1'b1;
	else if(~(!spiswai_i && (spi_mode_i==2'b00||spi_mode_i==2'b01)&&mstr_i))
	ss_o<=1'b1;
	else if(send_data_i)
	ss_o<=1'b0;
	else if(count_s<=target_s-1'b1)
	ss_o<=1'b0;
	else
	ss_o<=1'b1;
end

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
	count_s<=16'hffff;
	else if(~(!spiswai_i && (spi_mode_i==2'b00||spi_mode_i==2'b01)&&mstr_i))
	count_s<=16'hffff;
	else if(send_data_i)
	count_s<=16'b0;
	else if(~(count_s<=target_s-1'b1))
	count_s<=16'hffff;
	else
	count_s<=count_s+1'b1;
end

endmodule

