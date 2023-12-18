`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2023 11:58:10
// Design Name: 
// Module Name: gpio_chip
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gpio_chip(
input wire PCLK,
input wire PRESETn,
input wire PWrite,
input wire [7:0] PADDR,
input wire [15:0] PWDATA,
input wire PSEL,
input wire PENABLE,

output reg [15:0]PRDATA=0,
inout  pin1,pin2,pin3,pin4,pin5,pin6,pin7,pin8,pin9,pin10,pin11,pin12,pin13,pin14,pin15,pin16
);
wire PREADY;
reg  state,next;
integer i;
localparam IDLE=1'b0 ,SETUP=1'b1;
reg [15:0] pin=0,dir=0,set=0,clr=0,out=0,in=0;

assign PREADY = (PSEL && PENABLE) ? 1'b1 : 1'b0;
assign pin1=  out[0] ;
assign pin2=  out[1]  ;
assign pin3=  out[2]  ;
assign pin4=  out[3]  ;
assign pin5=  out[4]  ;
assign pin6=  out[5]  ;
assign pin7=  out[6] ;
assign pin8=  out[7]  ;
assign pin9=  out[8]  ;
assign pin10=  out[9]  ;
assign pin11=  out[10]  ;
assign pin12=  out[11]  ;
assign pin13=  out[12]  ;
assign pin14=  out[13]  ;
assign pin15=  out[14]  ;
assign pin16=  out[15]  ;

always @(posedge PCLK)
begin
if(PRESETn) 
    state<=IDLE;
else
    state<=next;
end

always @(posedge PCLK)
begin
next <=IDLE;
case(state)
IDLE:begin
    if(PREADY)
        next <=SETUP;
    else
        next <=IDLE;
end

SETUP:begin
    if(!PREADY)
      next <=IDLE;
    	
		
	if (PADDR[7:0] == 8'h00 && PWrite == 1 ) begin //data write
			 pin <=PWDATA[15:0];
			
		    end	
	else if (PADDR[7:0] == 8'h04 && PWrite == 1 ) begin //data write
        	dir <=PWDATA[15:0];
		    end		
	else if (PADDR[7:0] == 8'h08 && PWrite == 1 ) begin //data write
			 set <=PWDATA[15:0];
			
		    end
	else if (PADDR[7:0] == 8'h0c && PWrite == 1 ) begin //data write
			 
			 clr <=PWDATA[15:0];
			 	  
		    end		 
	 else if(PADDR[7:0] == 8'h00 && PWrite == 0 )begin	//data read                    
	       PRDATA[15:0] <= in;
      end 
	
  	 
	 
	 next<=SETUP;
    end


endcase

end
always @(*)
begin
if (PADDR[7:0] == 8'h00 && PWrite == 1 )begin
for(i=0;i<16;i=i+1)begin 
			 if(pin[i] )
		     out[i] <=1'b1;
		     else
		     out[i] <=1'b0;
		    end	
		  end
		  
if(PADDR[7:0] == 8'h08 && PWrite == 1 )	begin
 for(i=0;i<16;i=i+1)begin 
	       if((set[i] && dir[i]) )
		     out[i] <=1'b1;
         end
         end
 
if(PADDR[7:0] == 8'h0c && PWrite == 1 )begin         		  	    
for(i=0;i<16;i=i+1)begin 
	     if((clr[i] && dir[i]))
		  out[i] <=1'b0;
        end
        end			    
end


always @(negedge PCLK)
begin
    
	     	  
	 in[0]<=pin1;
	 in[1]<=pin2;
	 in[2]<=pin3;
	 in[3]<=pin4;
	 in[4]<=pin5;
	 in[5]<=pin6;
	 in[6]<=pin7;
	 in[7]<=pin8;
     in[8]<=pin9;
	 in[9]<=pin10;
	 in[10]<=pin11;
	 in[11]<=pin12;
	 in[12]<=pin13;
	 in[13]<=pin14;
	 in[14]<=pin15;
	 in[15]<=pin16;
     
end



	    
 
endmodule
