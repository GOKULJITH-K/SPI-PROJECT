module spi_baud_generator_tb;

reg PCLK,PRESET_n,cpol_i,cpha_i,spiswai_i,ss_i;
reg [2:0] sppr_i,spr_i;
reg [1:0] spi_mode_i;
wire [11:0] BaudRateDivisor_o;
wire sclk_o,miso_recieve_sclk_o,miso_recieve_sclk0_o,mosi_send_sclk_o,mosi_send_sclk0_o;

spi_baud_generator DUT(.PCLK(PCLK),.PRESET_n(PRESET_n),.cpol_i(cpol_i),.cpha_i(cpha_i),.spiswai_i(spiswai_i),.sppr_i(sppr_i),.ss_i(ss_i),.spr_i(spr_i),.BaudRateDivisor_o(BaudRateDivisor_o),.sclk_o(sclk_o),.spi_mode_i(spi_mode_i),.miso_recieve_sclk_o(miso_recieve_sclk_o),.miso_recieve_sclk0_o(miso_recieve_sclk0_o),.mosi_send_sclk_o(mosi_send_sclk_o),.mosi_send_sclk0_o(mosi_send_sclk0_o));

always begin
	#10 PCLK=1'b1;
	#10 PCLK=1'b0;
end

task reset;
	begin
		@(posedge PCLK)
		PRESET_n=1'b0;
		@(posedge PCLK)
		PRESET_n=1'b1;
	end
endtask

task inputs1(input a,input b);
	begin
		@(negedge PCLK)
		cpol_i=a;
		cpha_i=b;
	end
endtask

task inputs2(input[2:0]  m,input [2:0] n);
	begin
		@(negedge PCLK)
		sppr_i=m;
		spr_i=n;
	end
endtask
integer i,j,m,n;
initial begin

	PCLK=1'b0;
	PRESET_n=1'b1;
	
	reset;
	spi_mode_i=2'b00;
	inputs1(1'b1,1'b0);
	inputs2(3'b000,3'b010);
	spiswai_i=1'b0;
	ss_i=1'b0;
	#20;

	inputs1(1'b0,1'b0);
	#20;
	inputs1(1'b0,1'b1);
	#20;
	inputs1(1'b1,1'b0);
	#20;
	
	spi_mode_i=2'b01;
	spiswai_i=1'b1;
	#20;

	spiswai_i=1'b0;
	#20;

	spi_mode_i=2'b10;
	#20;

	inputs2(3'b001,3'b000);
	spi_mode_i=2'b00;
	ss_i=1'b0;
	#20;

	ss_i=1'b1;
	#20;

	reset;
	inputs2(3'b000,3'b000);
	inputs1(1'b0,1'b0);
	spi_mode_i=2'b00;
	ss_i=1'b0;
	spiswai_i=1'b0;
	#200

	reset;
	inputs2(3'b001,3'b000);
	inputs1(1'b0,1'b0);
	spi_mode_i=2'b00;
	ss_i=1'b0;
	spiswai_i=1'b0;
	#200

	reset;
	inputs2(3'b111,3'b111);
	inputs1(1'b0,1'b0);
	spi_mode_i=2'b00;
	ss_i=1'b0;
	spiswai_i=1'b0;
	#200
	
	reset;
	for(i=0;i<8;i=i+1) begin
	for(j=0;j<8;j=j+1) begin
	inputs2(i[2:0],j[2:0]);
	#500;
	end
	end
	inputs1(1'b0,1'b0);
	spi_mode_i=2'b00;
	ss_i=1'b0;
	spiswai_i=1'b0;
	#200

	reset;
	inputs2(3'b000,3'b000);
	inputs1(1'b0,1'b0);
	spi_mode_i=2'b00;
	ss_i=1'b0;
	spiswai_i=1'b0;
	#200

	
	reset;
	inputs2(3'b001,3'b000);
	inputs1(1'b0,1'b1);
	spi_mode_i=2'b00;
	ss_i=1'b0;
	spiswai_i=1'b0;
	#200
	
	reset;
	inputs2(3'b001,3'b000);
	inputs1(1'b1,1'b1);
	spi_mode_i=2'b00;
	ss_i=1'b0;
	spiswai_i=1'b0;
	#200
	
	reset;
	spi_mode_i=2'b00;
	ss_i=1'b0;
	spiswai_i=1'b0;
	for(m=0;m<2;m=m+1) begin
	for(n=0;n<2;n=n+1) begin
	inputs1(m[0],n[0]);
	inputs2(3'b000,3'b000);
	#400;
	inputs2(3'b001,3'b000);
	#400;
	end
	end
	
	#200

	$display("------------Simulation Ended ----------------");
	$finish;
	
end
endmodule
