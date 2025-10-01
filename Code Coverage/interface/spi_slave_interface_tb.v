module spi_slave_interface_tb;

/******************************************************************************
* DECLARATION OF REG AND WIRES *********************************************/
reg PCLK,PRESET_n,PWRITE_i,PSEL_i,PENABLE_i,ss_i,recieve_data_i,tip_i;
reg [2:0] PADDR_i;
reg [7:0] PWDATA_i,miso_data_i;


wire [2:0] sppr_o,spr_o;
wire [1:0] spi_mode_o;
wire [7:0] PRDATA_o;
wire PREADY_o;
wire mstr_o, cpol_o, cpha_o, lsbfe_o, spiswai_o, spi_interrupt_request_o;
wire PSLVERR_o, send_data_o;
wire [7:0] mosi_data_o;

/****************************************************************************
* INSTANTIATION OF DUT 
* **************************************************************************/

spi_slave_interface DUT(.PCLK(PCLK),.PRESET_n(PRESET_n),.PWRITE_i(PWRITE_i),.PSEL_i(PSEL_i),.PENABLE_i(PENABLE_i),.ss_i(ss_i),.recieve_data_i(recieve_data_i),.tip_i(tip_i),.PADDR_i(PADDR_i),.PWDATA_i(PWDATA_i),.miso_data_i(miso_data_i),.mstr_o(mstr_o),.cpol_o(cpol_o),.cpha_o(cpha_o),.lsbfe_o(lsbfe_o),.spiswai_o(spiswai_o),.spi_interrupt_request_o(spi_interrupt_request_o),.PREADY_o(PREADY_o),.PSLVERR_o(PSLVERR_o),.send_data_o(send_data_o),.mosi_data_o(mosi_data_o),.spi_mode_o(spi_mode_o),.sppr_o(sppr_o),.spr_o(spr_o),.PRDATA_o(PRDATA_o));

/******************************************************************************
* CLOCK GENERATION
* **************************************************************************/

always begin
	#10 PCLK=1'b1;
	#10 PCLK=1'b0;
end

/****************************************************************************
* TASK FOR RESET
* **************************************************************************/

task reset;
	begin
		@(posedge PCLK)
		PRESET_n=1'b0;
		@(posedge PCLK)
		PRESET_n=1'b1;
	end
endtask

/***************************************************************************
* TASK FOR CONFIGURING CR1 CR2 AND BR
* ****************************************************************************/

task config1(input [7:0]  a,b,c);	
	begin
		@(posedge PCLK)
		PSEL_i=1'b1;
		PWRITE_i=1'b1;
		PENABLE_i=1'b0;
		PADDR_i=3'b000;
		PWDATA_i=a;

		@(posedge PCLK)
	   PENABLE_i=1'b1;

		@(posedge PCLK)
		wait(PREADY_o);
		PENABLE_i=1'b0;

		@(posedge PCLK)
      PSEL_i=1'b1;
	   PWRITE_i=1'b1;
		PENABLE_i=1'b0;
		PADDR_i=3'b001;
		PWDATA_i=b;
		
		@(posedge PCLK)
	   PENABLE_i=1'b1;
		
		@(posedge PCLK)
		wait(PREADY_o);
		PENABLE_i=1'b0;

		@(posedge PCLK)
		PSEL_i=1'b1;
	   PWRITE_i=1'b1;
		PENABLE_i=1'b0;
	   PADDR_i=3'b010;
		PWDATA_i=c;
		
		@(posedge PCLK)
	   PENABLE_i=1'b1;
		
	   @(posedge PCLK)
		wait(PREADY_o);
		PENABLE_i=1'b0;


	end
endtask

/***************************************************************************
* TASK FOR CONFIGURING DR
* ****************************************************************************/

task config2(input [7:0]  a);
        begin
                @(posedge PCLK)
                PSEL_i=1'b1;
                PWRITE_i=1'b1;
                PENABLE_i=1'b0;
                PADDR_i=3'b100;
                PWDATA_i=a;

                @(posedge PCLK)
                PENABLE_i=1'b1;

                @(posedge PCLK)
                wait(PREADY_o);
                PENABLE_i=1'b0;
end
endtask

/***************************************************************************
* TASK FOR READING THE REGISTERS
* ****************************************************************************/

task read_reg(input [2:0]  z);
        begin
                @(posedge PCLK)
                PSEL_i=1'b1;
                PWRITE_i=1'b0;
                PENABLE_i=1'b0;
                PADDR_i=z;
					 
		@(posedge PCLK)
		PENABLE_i=1'b1;
					 
		@(posedge PCLK)
		PENABLE_i=1'b0;
					 
          
end
endtask
/*****************************************************************************
* TASK FOR MISO DATA , RECIEVE DATA, SS AND TIP
* ***************************************************************************/
integer i;
task drive_miso(input [7:0] p);
	begin
		@(posedge PCLK)
		recieve_data_i=1'b0;
		ss_i=1'b0;
		tip_i=1'b1;
		miso_data_i=8'b0;
		wait(~ss_i);
		for(i=0;i<=7;i=i+1)
		begin
		     @(posedge PCLK)
		     miso_data_i=p[i];
	   end
	end
endtask
/**************************************************************************
	TASK FOR WRITING SPE AND SPISWAI FOR FSM OPERATION
**************************************************************************/
task write_reg(input [2:0] addr, input [7:0] data);
    begin
        @(posedge PCLK);
        PSEL_i    = 1'b1;
        PWRITE_i  = 1'b1;
        PENABLE_i = 1'b0;
        PADDR_i   = addr;
        PWDATA_i  = data;
        @(posedge PCLK);
        PENABLE_i = 1'b1;
        @(posedge PCLK);
        PSEL_i    = 1'b0;
        PENABLE_i = 1'b0;
    end
endtask

/*****************************************************************************
* CALL THE TASK IN THE INITIAL PROCESS
* ****************************************************************************/
integer j;
initial begin
	reset;
	config1(8'b0011_1001,8'b1100_1111,8'b0000_0001);
	config2(8'b1010_1010);
	drive_miso(8'b1111_1010);
	read_reg(3'b000);
	read_reg(3'b001);
	read_reg(3'b010);
	read_reg(3'b011);
	read_reg(3'b100);
	read_reg(3'b111);
	
	reset;
	config1(8'b0011_1001,8'b1100_1111,8'b0000_0001);
	config2(8'b1010_1010);
	drive_miso(8'b1111_1010);
	PSEL_i = 1'b1;
  @(posedge PCLK); 
  PSEL_i = 1'b0;
  @(posedge PCLK); 
  #20;

  PSEL_i    = 1'b1;
  PENABLE_i = 1'b0;
  @(posedge PCLK); 
  PENABLE_i = 1'b1;
  @(posedge PCLK); 
  PSEL_i = 1'b0;
  PENABLE_i = 1'b0;
  @(posedge PCLK); 
  #20;

  DUT.state = 2'b11;
  @(posedge PCLK); 
  @(posedge PCLK);
  #50;
	
	write_reg(3'b000, 8'b0000_0000); 
   #20;
  write_reg(3'b000, 8'b0100_0000); 
  #20;
  write_reg(3'b000, 8'b0000_0000); 
	#20;
  write_reg(3'b001, 8'b0000_0010); 
  #20; 
  write_reg(3'b001, 8'b0000_0000); 
  #20;
  write_reg(3'b001, 8'b0000_0010); 
  #20;
  write_reg(3'b000, 8'b0100_0000); 
  #20;
	$display("mode=%b",spi_mode_o);
	write_reg(3'b001, 8'b0000_0000); 
  #20;
	write_reg(3'b000, 8'b0000_0000); 
  #20;
	$display("mode=%b",spi_mode_o);
	write_reg(3'b000, 8'b0100_0000); 
  #20;
	$display("mode=%b",spi_mode_o);
	
  DUT.spi_mode_o = 2'b11;
  @(posedge PCLK);
  #20;

	PSEL_i = 0; PENABLE_i = 0; PWRITE_i = 0;
  PADDR_i = 3'b000; PWDATA_i = 8'd0; miso_data_i = 8'd0;
  #20;
	@(posedge PCLK);
  write_reg(3'b100, 8'hA5);
  @(posedge PCLK); @(posedge PCLK);
  write_reg(3'b000, 8'h40);
  @(posedge PCLK); @(posedge PCLK);
  PWDATA_i = 8'hA5;
  miso_data_i = 8'h5A;
  PSEL_i = 1'b0; PENABLE_i = 1'b0; PWRITE_i = 1'b0;
  @(posedge PCLK);
	
	PSEL_i = 0; PENABLE_i = 0; PWRITE_i = 0;
  PADDR_i = 3'b000; PWDATA_i = 8'd0; miso_data_i = 8'd0;
	recieve_data_i=1'b1;
  #20;
	@(posedge PCLK);
  write_reg(3'b100, 8'hA5);
  @(posedge PCLK); @(posedge PCLK);
  write_reg(3'b000, 8'h40);
  @(posedge PCLK); @(posedge PCLK);
  PWDATA_i = 8'hAA;
  miso_data_i = 8'h5A;
  PSEL_i = 1'b0; PENABLE_i = 1'b0; PWRITE_i = 1'b0;
  @(posedge PCLK);
	write_reg(3'b000, 8'b0100_0000); 
  #20;
	write_reg(3'b000, 8'b0000_0000); 
  #20;
	write_reg(3'b001, 8'b0000_0010); 
  #20;
	$display("mode=%b",spi_mode_o);
	recieve_data_i=1'b0;

	write_reg(3'b000, 8'b1010_0000);
	@(posedge PCLK);
	write_reg(3'b000, 8'b1000_0000);
	@(posedge PCLK);
	write_reg(3'b000, 8'b0010_0000);
	@(posedge PCLK);
	write_reg(3'b000, 8'b0000_0000);
	@(posedge PCLK);

	write_reg(3'b000, 8'b0001_0000);
	@(posedge PCLK);
	write_reg(3'b001, 8'b0001_0000);
	@(posedge PCLK);
	ss_i=1'b0;
	#20;

	write_reg(3'b000, 8'b0001_0000);
	@(posedge PCLK);
	write_reg(3'b001, 8'b0001_0000);
	@(posedge PCLK);
	ss_i=1'b1;
	#20;

	write_reg(3'b000, 8'b0000_0000);
	@(posedge PCLK);
	write_reg(3'b001, 8'b0001_0000);
	@(posedge PCLK);
	ss_i=1'b0;
	#20;

	write_reg(3'b000, 8'b0001_0010);
	@(posedge PCLK);
	write_reg(3'b001, 8'b0001_0000);
	@(posedge PCLK);
	ss_i=1'b0;
	#20;
	
	write_reg(3'b000, 8'b0000_0000);
	@(posedge PCLK);
	
	write_reg(3'b000, 8'b0101_0000); 
	#20;
	write_reg(3'b000, 8'b0100_1101); 
	#20;
	write_reg(3'b000, 8'b1100_0000); 
	#20;

	write_reg(3'b001, 8'b0101_0000); 
	#20;
	write_reg(3'b001, 8'b0100_1101); 
	#20;
	write_reg(3'b001, 8'b1100_0000); 
	#20;

	
	write_reg(3'b010, 8'b0101_0000); 
	#20;
	write_reg(3'b010, 8'b0100_1101); 
	#20;
	write_reg(3'b010, 8'b1100_0000); 
	#20;

	write_reg(3'b010, 8'b1111_1111); 
	#20;
	write_reg(3'b010, 8'b0000_0000); 
	#20;
	write_reg(3'b010, 8'b1111_1111); 
	#20;



	write_reg(3'b100, 8'b0101_0000); 
	#20;
	write_reg(3'b100, 8'b0100_1101); 
	#20;
	write_reg(3'b100, 8'b1100_0000); 
	#20;

	miso_data_i = 8'h00; @(posedge PCLK);
  miso_data_i = 8'hFF; @(posedge PCLK);
  miso_data_i = 8'hA5; @(posedge PCLK);
  miso_data_i = 8'h5A; @(posedge PCLK);

	tip_i = 1; @(posedge PCLK); tip_i = 0; @(posedge PCLK);tip_i = 1; @(posedge PCLK);
	write_reg(3'b111, 8'hDE);
 	@(posedge PCLK); @(posedge PCLK);

	PADDR_i = 3'b101; PWRITE_i = 0; PSEL_i = 1; PENABLE_i = 0; @(posedge PCLK);
  PENABLE_i = 1; @(posedge PCLK);
 	PSEL_i = 0; PENABLE_i = 0; @(posedge PCLK);


	$display("-------Simulation Completed-----------");
	$finish;
end
endmodule
