module spi_shift_reg_tb;

reg PCLK,PRESET_n,ss_i,lsbfe_i,send_data_i,cpol_i,cpha_i,miso_recieve_sclk_i,miso_recieve_sclk0_i,mosi_send_sclk_i,mosi_send_sclk0_i,miso_i,recieve_data_i;
reg [7:0] data_mosi_i;
wire [7:0] data_miso_o;
wire mosi_o;

reg [11:0] BaudRateDivisor;
reg [7:0] sample_miso;
reg [7:0] sample_mosi;

spi_shift_reg DUT(.PCLK(PCLK),.PRESET_n(PRESET_n),.ss_i(ss_i),.miso_i(miso_i),.lsbfe_i(lsbfe_i),.cpol_i(cpol_i),.send_data_i(send_data_i),.cpha_i(cpha_i),.miso_recieve_sclk_i(miso_recieve_sclk_i),.miso_recieve_sclk0_i(miso_recieve_sclk0_i),.mosi_send_sclk_i(mosi_send_sclk_i),.mosi_send_sclk0_i(mosi_send_sclk0_i),.recieve_data_i(recieve_data_i),.data_mosi_i(data_mosi_i),.mosi_o(mosi_o),.data_miso_o(data_miso_o));

always begin
	#10 PCLK=1'b1;
	#10 PCLK=1'b0;
end

task reset;
	begin
		@(posedge PCLK)
		PRESET_n = 1'b0;
		@(posedge PCLK)
		PRESET_n = 1'b1;
		@(posedge PCLK);
	end
endtask
integer i;
integer k;
task test_case1;
	begin
		ss_i=1'b0;
		data_mosi_i=8'b1111_1111;
		lsbfe_i=1'b1;
		cpha_i=1'b0;
		cpol_i=1'b0;
		BaudRateDivisor=12'd4;
		miso_recieve_sclk0_i=1'b0;
		miso_recieve_sclk_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;

		send_data_i=1'b1;
		@(posedge PCLK);
		send_data_i=1'b0;
		
		for (k=0; k<8; k=k+1) begin
      			  
			@(posedge PCLK);
			mosi_send_sclk_i = 1'b1;
			#3 sample_mosi[k] = mosi_o;   
      			mosi_send_sclk_i = 1'b0;
			
      
    		end
		
		@(posedge PCLK);
		ss_i=1'b1;

		if(sample_mosi!=data_mosi_i)
		begin
			$display("mosi is not working");
			$display("mosi stopped working at %t",$time);
			$display("mosi in =%b,mosi out =%b",data_mosi_i,sample_mosi);
			$stop;
		end
		$display("mosi is working fine");

		DUT.counter = 3'bxxx; 
		mosi_send_sclk_i <= 1'b1;
        	@(posedge PCLK);
        	mosi_send_sclk_i <= 1'b0;

		
	end
endtask
task test_case2;
        begin
                ss_i=1'b0;
		data_mosi_i=8'b0000_0000;
                send_data_i=1'b1;
                lsbfe_i=1'b1;
                cpha_i=1'b0;
                cpol_i=1'b0;
		BaudRateDivisor=12'd4;
                miso_recieve_sclk_i=1'b0;
		miso_recieve_sclk0_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;
		
		sample_miso=8'b0000_0000;
		for(k=0;k<8;k=k+1)
		begin
			
			miso_i = sample_miso[k];
			repeat (BaudRateDivisor/2) @(posedge PCLK);
			miso_recieve_sclk_i = 1'b1;
      			@(posedge PCLK);                
     			miso_recieve_sclk_i = 1'b0;
     			repeat (BaudRateDivisor/2) @(posedge PCLK);
		end
		
		recieve_data_i=1'b1;
		@(posedge PCLK);
		@(posedge PCLK);
                  
                if(sample_miso!=data_miso_o)
                begin
                        $display("miso is not working");
                        $display("miso stopped working at %t",$time);
                        $display("miso out =%b,miso in =%b",data_miso_o,sample_miso);
                        $stop;
                end
                $display("miso is working fine");

		DUT.counter2 = 3'bxxx; 
		mosi_send_sclk_i <= 1'b1;
        	@(posedge PCLK);
        	mosi_send_sclk_i <= 1'b0;

		ss_i=1'b1;
		send_data_i=1'b0;
		recieve_data_i=1'b0;
        end
endtask

task test_case3;
	begin
		ss_i=1'b0;
		data_mosi_i=8'b1111_1111;
		lsbfe_i=1'b0;
		cpha_i=1'b0;
		cpol_i=1'b0;
		BaudRateDivisor=12'd4;
		miso_recieve_sclk0_i=1'b0;
		miso_recieve_sclk_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;

		send_data_i=1'b1;
		@(posedge PCLK);
		send_data_i=1'b0;
		
		for (k=7; k>=0; k=k-1) begin
      			  
			@(posedge PCLK);
			mosi_send_sclk_i = 1'b1;
			#3 sample_mosi[k] = mosi_o;   
      			mosi_send_sclk_i = 1'b0;
			
      
    		end
		
		@(posedge PCLK);
		ss_i=1'b1;

		if(sample_mosi!=data_mosi_i)
		begin
			$display("mosi is not working");
			$display("mosi stopped working at %t",$time);
			$display("mosi in =%b,mosi out =%b",data_mosi_i,sample_mosi);
			$stop;
		end
		$display("mosi is working fine");

		DUT.counter1 = 3'bxxx; 
		mosi_send_sclk_i <= 1'b1;
        	@(posedge PCLK);
        	mosi_send_sclk_i <= 1'b0;

		
	end
endtask
task test_case4;
        begin
                ss_i=1'b0;
		data_mosi_i=8'b1111_0000;
                send_data_i=1'b1;
                lsbfe_i=1'b0;
                cpha_i=1'b0;
                cpol_i=1'b0;
		BaudRateDivisor=12'd4;
                miso_recieve_sclk_i=1'b0;
		miso_recieve_sclk0_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;
		
		sample_miso=8'b1111_1111;
		for(k=7;k>=0;k=k-1)
		begin
			
			miso_i = sample_miso[k];
			repeat (BaudRateDivisor/2) @(posedge PCLK);
			miso_recieve_sclk_i = 1'b1;
      			@(posedge PCLK);                
     			miso_recieve_sclk_i = 1'b0;
     			repeat (BaudRateDivisor/2) @(posedge PCLK);
		end
		
		
		recieve_data_i=1'b1;
		@(posedge PCLK);
		@(posedge PCLK);
                  
                if(sample_miso!=data_miso_o)
                begin
                        $display("miso is not working");
                        $display("miso stopped working at %t",$time);
                        $display("miso out =%b,miso in =%b",data_miso_o,sample_miso);
                        $stop;
                end
                $display("miso is working fine");
		
		DUT.counter3 = 3'bxxx; 
		mosi_send_sclk_i <= 1'b1;
        	@(posedge PCLK);
        	mosi_send_sclk_i <= 1'b0;

		ss_i=1'b1;
		send_data_i=1'b0;
		recieve_data_i=1'b0;
        end
endtask
task test_case5;
	begin
		ss_i=1'b0;
		data_mosi_i=8'b0000_0000;
		lsbfe_i=1'b1;
		cpha_i=1'b0;
		cpol_i=1'b1;
		BaudRateDivisor=12'd4;
		miso_recieve_sclk0_i=1'b0;
		miso_recieve_sclk_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;

		send_data_i=1'b1;
		@(posedge PCLK);
		send_data_i=1'b0;
		
		for (k=0; k<8; k=k+1) begin
      			  
			@(posedge PCLK);
			mosi_send_sclk0_i = 1'b1;
			#3 sample_mosi[k] = mosi_o;   
      			mosi_send_sclk0_i = 1'b0;
			
      
    		end
		
		@(posedge PCLK);
		ss_i=1'b1;

		if(sample_mosi!=data_mosi_i)
		begin
			$display("mosi is not working");
			$display("mosi stopped working at %t",$time);
			$display("mosi in =%b,mosi out =%b",data_mosi_i,sample_mosi);
			$stop;
		end
		$display("mosi is working fine");

		DUT.counter = 3'bxxx; 
		mosi_send_sclk0_i <= 1'b1;
        	@(posedge PCLK);
        	mosi_send_sclk0_i <= 1'b0;
		
	end
endtask
task test_case6;
        begin
                ss_i=1'b0;
		data_mosi_i=8'b1111_0000;
                send_data_i=1'b1;
                lsbfe_i=1'b1;
                cpha_i=1'b0;
                cpol_i=1'b1;
		BaudRateDivisor=12'd4;
                miso_recieve_sclk_i=1'b0;
		miso_recieve_sclk0_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;
		
		sample_miso=8'b0000_0000;
		for(k=0;k<8;k=k+1)
		begin
			
			miso_i = sample_miso[k];
			repeat (BaudRateDivisor/2) @(posedge PCLK);
			miso_recieve_sclk0_i = 1'b1;
      			@(posedge PCLK);                
     			miso_recieve_sclk0_i = 1'b0;
     			repeat (BaudRateDivisor/2) @(posedge PCLK);
		end
		
		recieve_data_i=1'b1;
		@(posedge PCLK);
		@(posedge PCLK);
                  
                if(sample_miso!=data_miso_o)
                begin
                        $display("miso is not working");
                        $display("miso stopped working at %t",$time);
                        $display("miso out =%b,miso in =%b",data_miso_o,sample_miso);
                        $stop;
                end
                $display("miso is working fine");

		DUT.counter2 = 3'bxxx; 
		mosi_send_sclk_i <= 1'b1;
        	@(posedge PCLK);
        	mosi_send_sclk_i <= 1'b0;

		ss_i=1'b1;
		send_data_i=1'b0;
		recieve_data_i=1'b0;
        end
endtask

task test_case7;
	begin
		ss_i=1'b0;
		data_mosi_i=8'b1111_1111;
		lsbfe_i=1'b0;
		cpha_i=1'b0;
		cpol_i=1'b1;
		BaudRateDivisor=12'd4;
		miso_recieve_sclk0_i=1'b0;
		miso_recieve_sclk_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;

		send_data_i=1'b1;
		@(posedge PCLK);
		send_data_i=1'b0;
		
		for (k=7; k>=0; k=k-1) begin
      			  
			@(posedge PCLK);
			mosi_send_sclk0_i = 1'b1;
			#3 sample_mosi[k] = mosi_o;   
      			mosi_send_sclk0_i = 1'b0;
			
      
    		end
		
		@(posedge PCLK);
		ss_i=1'b1;

		if(sample_mosi!=data_mosi_i)
		begin
			$display("mosi is not working");
			$display("mosi stopped working at %t",$time);
			$display("mosi in =%b,mosi out =%b",data_mosi_i,sample_mosi);
			$stop;
		end
		$display("mosi is working fine");

		DUT.counter1 = 3'bxxx; 
		mosi_send_sclk0_i <= 1'b1;
        	@(posedge PCLK);
        	mosi_send_sclk0_i <= 1'b0;
		
	end
endtask
task test_case8;
        begin
                ss_i=1'b0;
		data_mosi_i=8'b0000_0000;
                send_data_i=1'b1;
                lsbfe_i=1'b0;
                cpha_i=1'b0;
                cpol_i=1'b1;
		BaudRateDivisor=12'd4;
                miso_recieve_sclk_i=1'b0;
		miso_recieve_sclk0_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;
		
		sample_miso=8'b0000_1111;
		for(k=7;k>=0;k=k-1)
		begin
			
			miso_i = sample_miso[k];
			repeat (BaudRateDivisor/2) @(posedge PCLK);
			miso_recieve_sclk0_i = 1'b1;
      			@(posedge PCLK);                
     			miso_recieve_sclk0_i = 1'b0;
     			repeat (BaudRateDivisor/2) @(posedge PCLK);
		end
		
		recieve_data_i=1'b1;
		@(posedge PCLK);
		@(posedge PCLK);
                  
                if(sample_miso!=data_miso_o)
                begin
                        $display("miso is not working");
                        $display("miso stopped working at %t",$time);
                        $display("miso out =%b,miso in =%b",data_miso_o,sample_miso);
                        $stop;
                end
                $display("miso is working fine");

		DUT.counter3 = 3'bxxx; 
		mosi_send_sclk_i <= 1'b1;
        	@(posedge PCLK);
        	mosi_send_sclk_i <= 1'b0;

		ss_i=1'b1;
		send_data_i=1'b0;
		recieve_data_i=1'b0;
        end
endtask
task test_case9;
	begin
		ss_i=1'b0;
		data_mosi_i=8'b1111_1111;
		lsbfe_i=1'b1;
		cpha_i=1'b1;
		cpol_i=1'b1;
		BaudRateDivisor=12'd4;
		miso_recieve_sclk0_i=1'b0;
		miso_recieve_sclk_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;

		send_data_i=1'b1;
		@(posedge PCLK);
		send_data_i=1'b0;
		
		for (k=0; k<8; k=k+1) begin
      			  
			@(posedge PCLK);
			mosi_send_sclk_i = 1'b1;
			#3 sample_mosi[k] = mosi_o;   
      			mosi_send_sclk_i = 1'b0;
			
      
    		end
		
		@(posedge PCLK);
		ss_i=1'b1;

		if(sample_mosi!=data_mosi_i)
		begin
			$display("mosi is not working");
			$display("mosi stopped working at %t",$time);
			$display("mosi in =%b,mosi out =%b",data_mosi_i,sample_mosi);
			$stop;
		end
		$display("mosi is working fine");
		
	end
endtask
task test_case10;
        begin
                ss_i=1'b0;
		data_mosi_i=8'b1111_0000;
                send_data_i=1'b1;
                lsbfe_i=1'b1;
                cpha_i=1'b1;
                cpol_i=1'b1;
		BaudRateDivisor=12'd4;
                miso_recieve_sclk_i=1'b0;
		miso_recieve_sclk0_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;
		
		sample_miso=8'b0000_1111;
		for(k=0;k<8;k=k+1)
		begin
			
			miso_i = sample_miso[k];
			repeat (BaudRateDivisor/2) @(posedge PCLK);
			miso_recieve_sclk_i = 1'b1;
      			@(posedge PCLK);                
     			miso_recieve_sclk_i = 1'b0;
     			repeat (BaudRateDivisor/2) @(posedge PCLK);
		end
		
		recieve_data_i=1'b1;
		@(posedge PCLK);
		@(posedge PCLK);
                  
                if(sample_miso!=data_miso_o)
                begin
                        $display("miso is not working");
                        $display("miso stopped working at %t",$time);
                        $display("miso out =%b,miso in =%b",data_miso_o,sample_miso);
                        $stop;
                end
                $display("miso is working fine");

		ss_i=1'b1;
		send_data_i=1'b0;
		recieve_data_i=1'b0;
        end
endtask

task test_case11;
	begin
		ss_i=1'b0;
		data_mosi_i=8'b0000_1111;
		lsbfe_i=1'b0;
		cpha_i=1'b1;
		cpol_i=1'b1;
		BaudRateDivisor=12'd4;
		miso_recieve_sclk0_i=1'b0;
		miso_recieve_sclk_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;

		send_data_i=1'b1;
		@(posedge PCLK);
		send_data_i=1'b0;
		
		for (k=7; k>=0; k=k-1) begin
      			  
			@(posedge PCLK);
			mosi_send_sclk_i = 1'b1;
			#3 sample_mosi[k] = mosi_o;   
      			mosi_send_sclk_i = 1'b0;
			
      
    		end
		
		@(posedge PCLK);
		ss_i=1'b1;

		if(sample_mosi!=data_mosi_i)
		begin
			$display("mosi is not working");
			$display("mosi stopped working at %t",$time);
			$display("mosi in =%b,mosi out =%b",data_mosi_i,sample_mosi);
			$stop;
		end
		$display("mosi is working fine");
		
	end
endtask
task test_case12;
        begin
                ss_i=1'b0;
		data_mosi_i=8'b1111_0000;
                send_data_i=1'b1;
                lsbfe_i=1'b0;
                cpha_i=1'b1;
                cpol_i=1'b1;
		BaudRateDivisor=12'd4;
                miso_recieve_sclk_i=1'b0;
		miso_recieve_sclk0_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;
		
		sample_miso=8'b0000_1111;
		for(k=7;k>=0;k=k-1)
		begin
			
			miso_i = sample_miso[k];
			repeat (BaudRateDivisor/2) @(posedge PCLK);
			miso_recieve_sclk_i = 1'b1;
      			@(posedge PCLK);                
     			miso_recieve_sclk_i = 1'b0;
     			repeat (BaudRateDivisor/2) @(posedge PCLK);
		end
		
		recieve_data_i=1'b1;
		@(posedge PCLK);
		@(posedge PCLK);
                  
                if(sample_miso!=data_miso_o)
                begin
                        $display("miso is not working");
                        $display("miso stopped working at %t",$time);
                        $display("miso out =%b,miso in =%b",data_miso_o,sample_miso);
                        $stop;
                end
                $display("miso is working fine");

		ss_i=1'b1;
		send_data_i=1'b0;
		recieve_data_i=1'b0;
        end
endtask
task test_case13;
	begin
		ss_i=1'b0;
		data_mosi_i=8'b1010_1010;
		lsbfe_i=1'b1;
		cpha_i=1'b1;
		cpol_i=1'b0;
		BaudRateDivisor=12'd4;
		miso_recieve_sclk0_i=1'b0;
		miso_recieve_sclk_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;

		send_data_i=1'b1;
		@(posedge PCLK);
		send_data_i=1'b0;
		
		for (k=0; k<8; k=k+1) begin
      			  
			@(posedge PCLK);
			mosi_send_sclk0_i = 1'b1;
			#3 sample_mosi[k] = mosi_o;   
      			mosi_send_sclk0_i = 1'b0;
			
      
    		end
		
		@(posedge PCLK);
		ss_i=1'b1;

		if(sample_mosi!=data_mosi_i)
		begin
			$display("mosi is not working");
			$display("mosi stopped working at %t",$time);
			$display("mosi in =%b,mosi out =%b",data_mosi_i,sample_mosi);
			$stop;
		end
		$display("mosi is working fine");
		
	end
endtask
task test_case14;
        begin
                ss_i=1'b0;
		data_mosi_i=8'b0101_0101;
                send_data_i=1'b1;
                lsbfe_i=1'b1;
                cpha_i=1'b1;
                cpol_i=1'b0;
		BaudRateDivisor=12'd4;
                miso_recieve_sclk_i=1'b0;
		miso_recieve_sclk0_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;
		
		sample_miso=8'b0000_1111;
		for(k=0;k<8;k=k+1)
		begin
			
			miso_i = sample_miso[k];
			repeat (BaudRateDivisor/2) @(posedge PCLK);
			miso_recieve_sclk0_i = 1'b1;
      			@(posedge PCLK);                
     			miso_recieve_sclk0_i = 1'b0;
     			repeat (BaudRateDivisor/2) @(posedge PCLK);
		end
		
		recieve_data_i=1'b1;
		@(posedge PCLK);
		@(posedge PCLK);
                  
                if(sample_miso!=data_miso_o)
                begin
                        $display("miso is not working");
                        $display("miso stopped working at %t",$time);
                        $display("miso out =%b,miso in =%b",data_miso_o,sample_miso);
                        $stop;
                end
                $display("miso is working fine");

		ss_i=1'b1;
		send_data_i=1'b0;
		recieve_data_i=1'b0;
        end
endtask

task test_case15;
	begin
		ss_i=1'b0;
		data_mosi_i=8'b1010_1010;
		lsbfe_i=1'b0;
		cpha_i=1'b1;
		cpol_i=1'b0;
		BaudRateDivisor=12'd4;
		miso_recieve_sclk0_i=1'b0;
		miso_recieve_sclk_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;

		send_data_i=1'b1;
		@(posedge PCLK);
		send_data_i=1'b0;
		
		for (k=7; k>=0; k=k-1) begin
      			  
			@(posedge PCLK);
			mosi_send_sclk0_i = 1'b1;
			#3 sample_mosi[k] = mosi_o;   
      			mosi_send_sclk0_i = 1'b0;
			
      
    		end
		
		@(posedge PCLK);
		ss_i=1'b1;

		if(sample_mosi!=data_mosi_i)
		begin
			$display("mosi is not working");
			$display("mosi stopped working at %t",$time);
			$display("mosi in =%b,mosi out =%b",data_mosi_i,sample_mosi);
			$stop;
		end
		$display("mosi is working fine");
		
	end
endtask
task test_case16;
        begin
                ss_i=1'b0;
		data_mosi_i=8'b1111_0000;
                send_data_i=1'b1;
                lsbfe_i=1'b0;
                cpha_i=1'b1;
                cpol_i=1'b0;
		BaudRateDivisor=12'd4;
                miso_recieve_sclk_i=1'b0;
		miso_recieve_sclk0_i=1'b0;
		mosi_send_sclk0_i=1'b0;
		mosi_send_sclk_i=1'b0;
		recieve_data_i=1'b0;
		
		sample_miso=8'b0000_1111;
		for(k=7;k>=0;k=k-1)
		begin
			
			miso_i = sample_miso[k];
			repeat (BaudRateDivisor/2) @(posedge PCLK);
			miso_recieve_sclk0_i = 1'b1;
      			@(posedge PCLK);                
     			miso_recieve_sclk0_i = 1'b0;
     			repeat (BaudRateDivisor/2) @(posedge PCLK);
		end
		
		recieve_data_i=1'b1;
		@(posedge PCLK);
		@(posedge PCLK);
                  
                if(sample_miso!=data_miso_o)
                begin
                        $display("miso is not working");
                        $display("miso stopped working at %t",$time);
                        $display("miso out =%b,miso in =%b",data_miso_o,sample_miso);
                        $stop;
                end
                $display("miso is working fine");

		ss_i=1'b1;
		send_data_i=1'b0;
		recieve_data_i=1'b0;
        end
endtask

initial begin
	
	PCLK=0; PRESET_n=1; ss_i=1; send_data_i=0; lsbfe_i=1; cpha_i=0; cpol_i=0;
  	miso_recieve_sclk_i=0; miso_recieve_sclk0_i=0; mosi_send_sclk_i=0; mosi_send_sclk0_i=0;
 	miso_i=0; recieve_data_i=0; data_mosi_i=8'h00;	
	
	reset;
	
	test_case1;
	test_case2;
	test_case3;
	test_case4;
	test_case5;
	test_case6;
	test_case7;
	test_case8;
	test_case9;
	test_case10;
	test_case11;
	test_case12;
	test_case13;
	test_case14;
	test_case15;
	test_case16;

	cpha_i=1'b0;
	#20;
	cpha_i=1'b1;
	#20;
	cpha_i=1'b0;
	#20;
	BaudRateDivisor=12'b1111_1111_1111;
	#20;
	BaudRateDivisor=12'b0000_0000_0000;
	#20;
	BaudRateDivisor=12'b1111_1111_1111;
	#20;

	$display("------------Simulation Completed----------------");
	$finish;
end
endmodule
