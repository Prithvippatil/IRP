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

      sclk                  : out std_logic;
      miso                  : in std_logic;
      mosi                  : out std_logic;
      ss                    : out std_logic
      
   st_pin1                  : inout STD_LOGIC;
   st_pin2                  : inout STD_LOGIC;
   st_pin3                 : inout STD_LOGIC;
   st_pin4                  : inout STD_LOGIC;
   st_pin5                  : inout STD_LOGIC;
   st_pin6                  : inout STD_LOGIC;
   st_pin7                  : inout STD_LOGIC;
   st_pin8                  : inout STD_LOGIC
      );
  end component;
  

  

  signal clk_in    : std_logic := '1';
  signal rst_in   : std_logic := '0';
  signal proc_beat: std_logic;
  
  signal scl      : std_logic ;
  signal sda      : std_logic;

  signal ss        : std_logic;
  signal sclk      : std_logic;
  signal  miso     : std_logic;
  signal mosi      : std_logic;


begin

  uut: SOC_top port map ( clk_in     => clk_in,
                          rst_in    => rst_in,
                          proc_beat => proc_beat,
                          
                          scl       => scl,
                          sda       => sda,

                          ss        => ss,
                          sclk      => sclk,         
                          miso      => miso ,       
                          mosi      => mosi,
                         
                          st_pin1    =>   st_pin1,         
                          st_pin2    =>   st_pin2,
                          st_pin3    =>   st_pin3,         
                          st_pin4    =>   st_pin4,
                          st_pin5    =>   st_pin5,         
                          st_pin6    =>   st_pin6,
                          st_pin7    =>   st_pin7,         
                          st_pin8    =>   st_pin8
                        );
                        

  stimulus: process(clk_in)
  begin
    
clk_in <= not clk_in after 5 ns;

  end process;
  rst_in <= '1' after 200 ns;

end;
