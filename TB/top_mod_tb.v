module top_mod_tb;

/******************************************************************************
* DECLARATION OF REG AND WIRES *********************************************/
reg PCLK,PRESET_n,PWRITE_i,PSEL_i,PENABLE_i,miso_data_i;
reg [2:0] PADDR_i;
reg [7:0] PWDATA_i;

wire [7:0] PRDATA_o;
wire PREADY_o,PSLVERR_o,mosi_o,spi_interrupt_request_o,ss_o,sclk_o;

/**************************************************************************
	SELF REFERENCIAL MEMORIES
***************************************************************************/


/****************************************************************************
* INSTANTIATION OF DUT 
* **************************************************************************/

top_mod DUT(.PCLK(PCLK),.PRESET_n(PRESET_n),.PSEL_i(PSEL_i),.PENABLE_i(PENABLE_i),.PADDR_i(PADDR_i),.PWDATA_i(PWDATA_i),.miso_i(miso_data_i),.PWRITE_i(PWRITE_i),.spi_interrupt_request_o(spi_interrupt_request_o),.PREADY_o(PREADY_o),.PSLVERR_o(PSLVERR_o),.ss_o(ss_o),.sclk_o(sclk_o),.PRDATA_o(PRDATA_o),.mosi_o(mosi_o));

/******************************************************************************
	CLOCK GENERATION
* *****************************************************************************/

always begin
	#8 PCLK=1'b1;
	#8 PCLK=1'b0;
end

/****************************************************************************
* TASK FOR RESET
* **************************************************************************/

task reset;
	begin
		@(negedge PCLK)
		PRESET_n=1'b0;
		@(negedge PCLK)
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
					 
	        @(posedge PCLK)
	        PWRITE_i=1'b0;
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
				
					 
		@(posedge PCLK)
                PENABLE_i=1'b1;
					 
                @(posedge PCLK)
		PENABLE_i=1'b0;
					 				       
end
endtask
/*****************************************************************************
* TASK FOR MISO DATA 
* ***************************************************************************/
integer i;
task drive_miso(input [7:0] p);
	begin
		
		wait(~ss_o);
		miso_data_i=1'b0;
		for(i=0;i<=7;i=i+1)
		begin
		     @(posedge sclk_o)
		     miso_data_i=p[i];
	        end
	end
endtask


/*****************************************************************************
* CALL THE TASK IN THE INITIAL PROCESS
* ****************************************************************************/

initial begin
	reset;
	config1(8'b0101_0101,8'b1100_1100,8'b0000_0001);
	config2(8'b0000_1111);
	drive_miso(8'b1001_1111);
	read_reg(3'b100);
	#1000 $finish;
end
endmodule
