library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity SOC_top_tb is
end;

architecture bench of SOC_top_tb is

  component SOC_top
  	port (
  	  clk_in                 : in  std_logic;  
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
  

  

  signal clk_in    : std_logic := '1';
  signal rst_in   : std_logic := '0';
  signal proc_beat: std_logic;
  
  signal scl      : std_logic ;
  signal sda      : std_logic;
  
  signal miso     : std_logic;
  signal mosi     : std_logic;
  signal sclk     : std_logic;
  signal ss     : std_logic;
  
  signal st_pin1     : std_logic;
  signal st_pin2     : std_logic;
  signal st_pin3     : std_logic;
  signal st_pin4     : std_logic;
  signal st_pin5     : std_logic;
  signal st_pin6     : std_logic;
  signal st_pin7     : std_logic;
  signal st_pin8     : std_logic;
  signal st_pin9     : std_logic;
  signal st_pin10     : std_logic;
  signal st_pin11     : std_logic;
  signal st_pin12     : std_logic;
  signal st_pin13     : std_logic;
  signal st_pin14     : std_logic;
  signal st_pin15     : std_logic;
  signal st_pin16     : std_logic;
  
  signal TX     : std_logic;
  signal RX     : std_logic;
  signal TICK    : std_logic;
  
  
  
  


begin

  uut: SOC_top port map ( clk_in     => clk_in,
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
                        

  stimulus: process(clk_in)
  begin
    
clk_in <= not clk_in after 5 ns;

  end process;
  rst_in <= '1' after 200 ns;
end;