module spi_slave_select_tb;

reg PCLK,PRESET_n,mstr_i,spiswai_i,send_data_i;
reg [1:0] spi_mode_i;
reg [11:0] BaudRateDivisor_i;
wire recieve_data_o,ss_o,tip_o;

spi_slave_select DUT(.PCLK(PCLK),.PRESET_n(PRESET_n),.mstr_i(mstr_i),.spiswai_i(spiswai_i),.send_data_i(send_data_i),.spi_mode_i(spi_mode_i),.BaudRateDivisor_i(BaudRateDivisor_i),.recieve_data_o(recieve_data_o),.ss_o(ss_o),.tip_o(tip_o));

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

task inputs1(input a,input b,input [1:0] c);
	begin
		@(negedge PCLK)
		mstr_i=a;
		spiswai_i=b;
		spi_mode_i=c;
	end
endtask

task inputs2(input m,input [11:0] n);
	begin
		@(negedge PCLK)
		send_data_i=m;
		BaudRateDivisor_i=n;
	end
endtask

integer i;
initial begin
	
	mstr_i = 1'b1;
	spiswai_i = 1'b0;
	spi_mode_i = 2'b00;
	BaudRateDivisor_i = 12'd2;
	
	reset;
	inputs2(1'b1, 12'd2);
	@(posedge PCLK); 
	inputs2(1'b0, 12'd2);
	
	repeat (40) @(posedge PCLK);

	reset;
	inputs1(1'b0,1'b0,2'b00);
	inputs2(1'b0,12'd2);

	mstr_i = 1'b0;
        #20;
	mstr_i = 1'b1;
        #20;
	spiswai_i = 1'b0;
	#20;
	spiswai_i = 1'b1;
	#20;
	spiswai_i = 1'b0;
	#20;
	send_data_i=1'b0;
	#20;
	send_data_i=1'b1;
	#20;
	send_data_i=1'b0;
	#20;
	spi_mode_i = 2'b11;
	#20;
	spi_mode_i = 2'b00;
	#20;
	BaudRateDivisor_i =0;
	#20;
	BaudRateDivisor_i =12'b1111_1111_1111;
	#20;
	BaudRateDivisor_i =0;
	#20;
	
	for(i=0;i<4096;i=i+1) begin
		BaudRateDivisor_i=i[11:0];
		#100;
	end
	#20;
	
	reset;
	inputs1(1'b0,1'b0,2'b01);
	inputs2(1'b0,12'd2);


	$display("-----------Simulation Completed----------");
	$finish;
end
endmodule
