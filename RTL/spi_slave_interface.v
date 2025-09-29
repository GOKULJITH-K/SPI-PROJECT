module spi_slave_interface(
	input PCLK,PRESET_n,PWRITE_i,PSEL_i,PENABLE_i,ss_i,recieve_data_i,tip_i,
	input [2:0] PADDR_i,input [7:0] PWDATA_i,miso_data_i,
	output mstr_o,cpol_o,cpha_o,lsbfe_o,spiswai_o,spi_interrupt_request_o,PREADY_o,PSLVERR_o,output reg send_data_o, output reg [7:0] mosi_data_o,
	output reg  [1:0] spi_mode_o,output [2:0] sppr_o,spr_o,output reg [7:0] PRDATA_o);

/*****************************************************************************                            DEFINE PARAMTER MACROS
******************************************************************************/

localparam SPI_APB_DATA_WIDTH=8,SPI_REG_WIDTH=8,SPI_APB_ADDR_WIDTH=3;
localparam [1:0]  IDLE=2'b00,SETUP=2'b01,ENABLE=2'b10;
localparam [1:0] spi_run=2'b00,spi_wait=2'b01,spi_stop=2'b10;

/*****************************************************************************                            DECLARE REGISTERS,WIRES,INTERNAL SIGNALS
******************************************************************************/

reg [1:0] state,next_state;
reg [1:0] next_mode;

reg [7:0] SPI_CR_1,SPI_CR_2,SPI_BR,SPI_DR, SPI_SR;

wire spif,sptef,modf,modfen,spe,ssoe;
wire wr_enb,rd_enb;

localparam [7:0] cr2_mask=8'b00011011;
localparam [7:0] br_mask=8'b01110111;



/*****************************************************************************                            FSM FOR DIFFERENT MODES OF OPERATIONS
******************************************************************************/
always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
		state<=IDLE;
	else
		state<=next_state;
end

always@(*)
begin
	next_state=IDLE;
	case(state)
		IDLE:begin
		   if(PSEL_i&&!PENABLE_i)
			next_state=SETUP;
			else
			next_state=IDLE;
			end
		SETUP: 
			begin
			if(PSEL_i&&!PENABLE_i)
			    next_state=SETUP;
			else if(PSEL_i&&PENABLE_i)
			next_state=ENABLE;
		        else
			    next_state=IDLE;
		        end
		ENABLE: begin
			if(PSEL_i)
				next_state=SETUP;
			else
				next_state=IDLE;
		      end
				default:next_state=IDLE;
         endcase

end
 /*****************************************************************************                            FSM FOR FOR APB STATES
******************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
		spi_mode_o<=spi_run;
	else
		spi_mode_o<=next_mode;
end

always@(*)
begin
	next_mode=spi_run;
	case(spi_mode_o)
		spi_run: begin 
		   if(!spe)
			next_mode=spi_wait;
			else
			next_mode=spi_run;
			end
		spi_wait: 
			begin
			    if(spe)
			    next_mode=spi_run;
				 else if(spiswai_o)
			    next_mode=spi_stop;
		        else
			    next_mode=spi_wait;
		        end
		spi_stop: begin
			if(spe)
				next_mode=spi_run;
			else if(!spiswai_o)
				next_mode=spi_wait;
			else 
				next_mode=spi_stop;
		      end
				default:next_mode=spi_run;
         endcase
 end
/*****************************************************************************                            GENERATE APB CONTROL SIGNALS
******************************************************************************/

 assign PREADY_o=(state==ENABLE);
 assign PSLVERR_o=(state==ENABLE)? ~tip_i:1'b0;
/*****************************************************************************                            GENERATE WRITE AND READ ENABLES
******************************************************************************/

 assign wr_enb=(PWRITE_i && state==ENABLE);
 assign rd_enb=(!PWRITE_i && state==ENABLE);

/*****************************************************************************                            CONFIGURING SPI_CR_1
******************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
		SPI_CR_1<=8'h04;
	else if(wr_enb) begin
		if(PADDR_i==3'b000)
			SPI_CR_1<=PWDATA_i;
		else
			SPI_CR_1<=SPI_CR_1;
       end
end
/*****************************************************************************                            CONFIGURING SPI_CR_2
******************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin
        if(!PRESET_n)
                SPI_CR_2<=8'h00;
        else if(wr_enb) begin
                if(PADDR_i==3'b001)
                        SPI_CR_2<=PWDATA_i&cr2_mask;
                else
                        SPI_CR_2<=SPI_CR_2;
                end
         else
                        SPI_CR_2<=SPI_CR_2;
end
/*****************************************************************************                            CONFIGURING SPI_BR
******************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin
        if(!PRESET_n)
                SPI_BR<=8'h00;
        else if(wr_enb) begin
                if(PADDR_i==3'b010)
                        SPI_BR<=PWDATA_i&br_mask;
                else
                        SPI_BR<=SPI_BR;
                end
        else
                        SPI_BR<=SPI_BR;
end

/*****************************************************************************                            CONFIGURING SPI_DR
******************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
		SPI_DR<=8'd0;
	else if(wr_enb)
	        begin
		if(PADDR_i==3'b100)
			SPI_DR<=PWDATA_i;
		else
			SPI_DR<=SPI_DR;
	        end
	else begin
			if(SPI_DR==PWDATA_i &&SPI_DR!=miso_data_i &&(spi_mode_o==spi_run ||spi_mode_o==spi_wait))
					SPI_DR<=8'd0;
			else begin
				if(spi_mode_o==spi_run || spi_mode_o==spi_wait&&recieve_data_i)
				 SPI_DR<=miso_data_i;
				else 
				 SPI_DR<=SPI_DR;
		   end
         end
	  
 

end

/*****************************************************************************                            DECODE CONTROL REGISTER FIELDS
******************************************************************************/


assign mstr_o=SPI_CR_1[4];
assign cpol_o=SPI_CR_1[3];
assign cpha_o=SPI_CR_1[2];
assign ssoe=SPI_CR_1[1];
assign lsbfe_o=SPI_CR_1[0];
assign spie_o=SPI_CR_1[7];
assign spe=SPI_CR_1[6];
assign sptie_o=SPI_CR_1[5];


assign spiswai_o=SPI_CR_2[1];
assign modfen=SPI_CR_2[4];


assign sppr_o=SPI_BR[6:4];
assign spr_o=SPI_BR[2:0];

assign sptef=(SPI_DR==8'd0);
assign spif=(SPI_DR!=8'd0);

/*****************************************************************************                            DETECT MODE FAULT (MODF)
******************************************************************************/

assign modf=(!ss_i && mstr_o && modfen && !ssoe);

/*****************************************************************************                            SEQUENTIAL BLOCK FOR SEND_DATA_O
******************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
		send_data_o<=1'b0;
	else if(wr_enb)
		send_data_o<=send_data_o;
	else begin
		if((SPI_DR==PWDATA_i && SPI_DR!=miso_data_i) && (spi_mode_o==spi_run ||spi_mode_o==spi_wait))
			send_data_o<=1'd1;
		else begin
			if((spi_mode_o==spi_run ||spi_mode_o==spi_wait) && recieve_data_i)
				send_data_o<=1'd1;
			else
				send_data_o<=1'd0;
		end
	      end
end
/*****************************************************************************                            SEQUENTIAL BLOCK FOR MOSI_DATA_O
******************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin
	if(!PRESET_n)
		mosi_data_o<=0;
	else if(!wr_enb)
	begin
		if(SPI_DR==PWDATA_i && SPI_DR!=miso_data_i && (spi_mode_o==spi_run||spi_mode_o==spi_wait))
			mosi_data_o<=SPI_DR;
		else
			mosi_data_o<=mosi_data_o;
	end
end

/*****************************************************************************                            IMPLEMENT APB READ DATA PATH
******************************************************************************/


always@(*)
begin
	if(rd_enb)begin
		case(PADDR_i)
			3'b000: PRDATA_o=SPI_CR_1;
			3'b001: PRDATA_o=SPI_CR_2;
			3'b010: PRDATA_o=SPI_BR;
			3'b011: PRDATA_o=SPI_SR;
			3'b100: PRDATA_o=SPI_DR;
			default:PRDATA_o=8'b0;
		endcase
	end
		else
			PRDATA_o=8'b0;
end

/*****************************************************************************                            UPDATE SPI STATUS REGISTER(SPI_BR)
******************************************************************************/

always @(posedge PCLK or negedge PRESET_n) begin
  if (!PRESET_n)
    SPI_SR <= 8'b0010_0000;      
  else
    SPI_SR <= {spif, 1'b0, sptef, modf, 4'b0};
end

/*****************************************************************************                            DETECT SPI_INTERRUPT_REQUEST_O BASED ON SPI CONTROL BITS AND STATUS FLAGS
******************************************************************************/

assign spi_interrupt_request_o=(!spie_o&&!sptie_o)?1'b0:(!sptie_o&&spie_o)?(spif||modf):(!spie_o&&sptie_o)?sptef:(spif||modf||sptef);

endmodule
