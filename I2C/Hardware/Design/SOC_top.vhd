----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.09.2023 23:13:29
-- Design Name: 
-- Module Name: Soc_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;  
use ieee.numeric_std.all; 
use work.constants.all;   
use ieee.std_logic_unsigned.all;
use STD.textio.all;
use ieee.std_logic_textio.all; 


entity SOC_top is
  Port (
    clk_in                : in std_logic; 	
    rst_in                : in  std_logic ; 
    proc_beat			  : out std_logic; 
    locked                : out std_logic;
    scl                   : inout std_logic;
    sda                   : inout std_logic);
end Soc_top;

architecture Behavioral of Soc_top is

  component Sys_top
  	port (
  	  clk_p                 : in  std_logic;  
  	  rst_in                : in  std_logic; 
      proc_beat			    : out std_logic; 
      
      scl                   : inout std_logic;
      sda                   : inout std_logic
      );
  end component;
  
  
  component clk_wiz_0
    port
     (-- Clock in ports
      -- Clock out ports
      clk_out1          : out    std_logic;
      -- Status and control signals
      reset             : in     std_logic;
      locked            : out    std_logic;
      clk_in1           : in     std_logic
     );
    end component;
    
  signal clk_out :std_logic;
  signal rstp    :std_logic;


begin

  uut: Sys_top port map ( clk_p     => clk_out,
                          rst_in    => rst_in,
                          proc_beat => proc_beat,
                          scl       => scl,
                          sda       => sda
                        );

clock_divider : clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out1 => clk_out,
  -- Status and control signals                
   reset => rstp,
   locked => locked,
   -- Clock in ports
   clk_in1 => clk_in
 );
 
 rstp <= not(rst_in);
 
 
end Behavioral;
