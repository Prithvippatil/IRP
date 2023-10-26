`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:12 03/30/2023 
// Design Name: 
// Module Name:    BGEN 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
`define BITWIDTH 8
module BGEN(
    input clk,
    input reset_n,
    input enable,
    input [`BITWIDTH - 1:0] FINAL_VALUE,
    output done
    );
  
    reg [`BITWIDTH - 1:0] Q_reg=0, Q_next=0;
    
always @(posedge clk)
 begin
 if(Q_reg==FINAL_VALUE)
 begin
 Q_next=1;
 Q_reg=0;
 end
 else
 begin    
 Q_next=0;
 Q_reg=Q_reg+1;
 end
end
   
assign done = Q_next == 1;
        
endmodule





