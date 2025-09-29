module spi_shift_reg(
    input PCLK,PRESET_n,ss_i,send_data_i,lsbfe_i,cpha_i,cpol_i,miso_recieve_sclk_i,miso_recieve_sclk0_i,mosi_send_sclk_i,mosi_send_sclk0_i,
    input [7:0]  data_mosi_i,input miso_i,recieve_data_i,output reg  mosi_o,output reg [7:0] data_miso_o
);

/***************************************************************************
REG AND WIRE FOR INTERNAL COUNTERS AND TEMPERORY REGISTERS FOR SHIFTING
****************************************************************************/

reg [7:0] shift_register,temp_reg;
reg [2:0] counter,counter1,counter2,counter3;


/****************************************************************************
OUTPUT RECIEVED DATA
*****************************************************************************/

always@(*)
begin
    if(recieve_data_i)
        data_miso_o=temp_reg;
    else 
        data_miso_o=8'h00;
end

/*****************************************************************************
TRANSMIT DATA REGISTER LOGIC(SHIFT REGISTER LOAD)
******************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin
    if(PRESET_n==1'b0)
        shift_register<=8'b0;
    else if(send_data_i)
         shift_register<=data_mosi_i;
       
end

/***************************************************************************
TRANSMIT DATA BIT BY BIT MOSI
****************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin

if(PRESET_n==1'b0)
begin
     counter<=3'd0;
     counter1<=3'd7;
     mosi_o<=1'b0;
end
else 
  begin
     if(!ss_i) begin
    if((!cpha_i && cpol_i) ||( cpha_i && !cpol_i))
    begin
         if(lsbfe_i) begin
        if(counter<=3'd7) begin
           if(mosi_send_sclk0_i) begin
            mosi_o<=shift_register[counter];
            counter<=counter+1'b1;
                   end
						 else
						 counter<=counter;
        end
                else
            counter<=3'd0;
          end
          else begin
          if(counter1>=3'd0) begin
            if(mosi_send_sclk0_i) begin
                mosi_o<=shift_register[counter1];
                counter1<=counter1-1'b1;
            end
				else
				counter1<=counter1;
        end
        else
            counter1<=3'd7;
            end
       end
       else
       begin
         if(lsbfe_i) begin
        if(counter<=3'd7) begin
           if(mosi_send_sclk_i) begin
            mosi_o<=shift_register[counter];
            counter<=counter+1'b1;
                   end
				else
						counter<=counter;
        end
                else
            counter<=3'd0;
          end
          else begin
          if(counter1>=3'd0) begin
            if(mosi_send_sclk_i) begin
                mosi_o<=shift_register[counter1];
                counter1<=counter1-1'b1;
            end
				else
				   counter1<=counter1;
        end
        else
            counter1<=3'd7;
              end
       end
    end
 end
end

/***************************************************************************
RECIEVE DATA BIT BY BIT(MISO)
****************************************************************************/

always@(posedge PCLK or negedge PRESET_n)
begin

if(PRESET_n==1'b0)
begin
     counter2<=3'd0;
     counter3<=3'd7;
     temp_reg<=8'b0;
end
else 
  begin
     if(!ss_i) begin
    if((!cpha_i && cpol_i )||( cpha_i && !cpol_i))
    begin
         if(lsbfe_i) begin
        if(counter2<=3'd7) begin
           if(miso_recieve_sclk0_i) begin
            temp_reg[counter2]<=miso_i;
            counter2<=counter2+1'b1;
                   end
						 else
						 counter2<=counter2;
        end
                else
            counter2<=3'd0;
          end
          else begin
          if(counter3>=3'd0) begin
            if(miso_recieve_sclk0_i) begin
                temp_reg[counter3]<=miso_i;
                counter3<=counter3-1'b1;
            end
				else
				counter3<=counter3;
        end
        else
            counter3<=3'd7;
              end
       end
       else
       begin
         if(lsbfe_i) begin
        if(counter2<=3'd7) begin
           if(miso_recieve_sclk_i) begin
            temp_reg[counter2]<=miso_i;
            counter2<=counter2+1'b1;
                   end
						 else
						 counter2<=counter2;
        end
                else
            counter2<=3'd0;
          end
          else begin
          if(counter3>=3'd0) begin
            if(miso_recieve_sclk_i) begin
                temp_reg[counter3]<=miso_i;
                counter3<=counter3-1'b1;
            end
				else
				counter3<=counter3;
        end
        else
            counter3<=3'd7;
              end
     end
  end
 end        
end
endmodule
