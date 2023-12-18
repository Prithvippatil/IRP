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
    sda                   : inout std_logic;
    
    sclk                    : out std_logic;
    miso                    : in std_logic;
    mosi                    : out std_logic;
    ss                      : out std_logic;
		
    st_pin1                  : inout STD_LOGIC;
    st_pin2                  : inout STD_LOGIC;
    st_pin3                  : inout STD_LOGIC;
    st_pin4                  : inout STD_LOGIC;
    st_pin5                  : inout STD_LOGIC;
    st_pin6                  : inout STD_LOGIC;
    st_pin7                  : inout STD_LOGIC;
    st_pin8                  : inout STD_LOGIC;
   st_pin9                  : inout STD_LOGIC;
   st_pin10                  : inout STD_LOGIC;
   st_pin11                 : inout STD_LOGIC;
   st_pin12                  : inout STD_LOGIC;
   st_pin13                  : inout STD_LOGIC;
   st_pin14                  : inout STD_LOGIC;
   st_pin15                  : inout STD_LOGIC;
   st_pin16                  : inout STD_LOGIC;
    TX                    : out   std_logic;
    RX                     : in    std_logic;
    TICK                     : out   std_logic 
    
    );
end Soc_top;

architecture Behavioral of Soc_top is

  component Sys_top
  	port (
  	  clk_p                 : in  std_logic;  
  	  rst_in                : in  std_logic; 
      proc_beat			    : out std_logic; 
      
      scl                   : inout std_logic;
      sda                   : inout std_logic;
      
      sclk                    : out std_logic;
      miso                    : in std_logic;
      mosi                    : out std_logic;
      ss                      : out std_logic;
		
      st_pin1                  : inout STD_LOGIC;
      st_pin2                  : inout STD_LOGIC;
      st_pin3                 : inout STD_LOGIC;
      st_pin4                  : inout STD_LOGIC;
      st_pin5                  : inout STD_LOGIC;
      st_pin6                  : inout STD_LOGIC;
      st_pin7                  : inout STD_LOGIC;
      st_pin8                  : inout STD_LOGIC;
      st_pin9                  : inout STD_LOGIC;
   st_pin10                  : inout STD_LOGIC;
   st_pin11                 : inout STD_LOGIC;
   st_pin12                  : inout STD_LOGIC;
   st_pin13                  : inout STD_LOGIC;
   st_pin14                  : inout STD_LOGIC;
   st_pin15                  : inout STD_LOGIC;
   st_pin16                  : inout STD_LOGIC;
   
      TX                    : out   STD_LOGIC;
      RX                     : in    std_logic;
      TICK                     : out   std_logic 
    
      
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
                          sda       => sda,
                          
                          sclk      => sclk,                 
                          miso      => miso,      
                          mosi      => mosi,              
                          ss        => ss,              
		
                          st_pin1   => st_pin1,               
                          st_pin2   => st_pin2,               
                          st_pin3   => st_pin3,   
                          st_pin4   => st_pin4, 
                          st_pin5   => st_pin5,           
                          st_pin6   => st_pin6,            
                          st_pin7   => st_pin7,           
                          st_pin8   => st_pin8,
                          st_pin9   => st_pin9,               
                          st_pin10   => st_pin10,               
                          st_pin11   => st_pin11,   
                          st_pin12   => st_pin12, 
                          st_pin13   => st_pin13,           
                          st_pin14   => st_pin14,            
                          st_pin15   => st_pin15,           
                          st_pin16   => st_pin16,           
   
                          TX        => TX,                  
                          RX        => RX,        
                          TICK      => TICK           
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
