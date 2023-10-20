`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:24:51 10/29/2022 
// Design Name: 
// Module Name:    apb_slave 
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

module apb_slave(
	input wire PCLK,
	input wire PRESETn,
	input wire PSEL,
	input wire PENABLE,
	input wire PWrite,
	input wire [31:0] PADDR,
	input wire [31:0] PWDATA,
	input wire [31:0] Dout,
	
	input wire ready,
	input wire [7:0] i2c_stat,
	
	output PREADY,
	output reg PSLVERR = 0,
	output reg [31:0] PRDATA = 0,
	output reg [31:0] Din = 0,
	output reg [7:0] i2c_con1 = 0,
	output reg [7:0] i2c_con2 = 0
    );
	 
	localparam         ////states declaration
		IDLE = 0,
		SETUP = 1,
		ACCESS = 2;
	
	reg [1:0] state = 0;
	reg [1:0] nxt_state = 0;
	
	assign PREADY = (PENABLE | ready) ? 1'b1 : 1'b0;  // PREADY signal 
	
	always @(posedge PCLK) begin
		if (!PRESETn) begin
			state <= IDLE;
		end
		else begin
			state <= nxt_state;
		end
	end
	
	always @(negedge PCLK) 
	begin
        if (PADDR[7:0] == 8'h00) begin 
			if (PWrite == 1) begin //config write
                i2c_con1 <= PWDATA[7:0];
                i2c_con2 <= PWDATA[15:8];
                PSLVERR <= (!ready) ? 1'b1 : 1'b0;
		    end
					
		    else begin //status read 
                PRDATA[7:0] <= i2c_con1;
                PRDATA[15:8] <= i2c_con2;
                PRDATA[23:16] <= i2c_stat;
                PSLVERR <= 1'b0;
			end
					
		end
				
		else if (PADDR[7:0] == 8'h04 && PWrite == 1) begin //data write
			 Din <= PWDATA;
			 PSLVERR <= (!ready) ? 1'b1 : 1'b0;
		    end
					
		else if(PADDR[7:0] == 8'h08 && PWrite == 0)
                begin     //data read
                  PRDATA <= Dout;
                  PSLVERR <= (!ready) ? 1'b1 : 1'b0;
                end
		else begin
			if (i2c_stat[7] == 1 && i2c_stat[0] == 0) begin
				i2c_con1 <= 0;
			end
	end
end
endmodule
