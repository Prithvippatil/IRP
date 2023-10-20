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
      sda                   : inout std_logic
      );
  end component;
  

  

  signal clk_in    : std_logic := '1';
  signal rst_in   : std_logic := '0';
  signal proc_beat: std_logic;
  
  signal scl      : std_logic ;
  signal sda      : std_logic;


begin

  uut: SOC_top port map ( clk_in     => clk_in,
                          rst_in    => rst_in,
                          proc_beat => proc_beat,
                          
                          scl       => scl,
                          sda       => sda
                        );
                        

  stimulus: process(clk_in)
  begin
    
clk_in <= not clk_in after 5 ns;

  end process;
  rst_in <= '1' after 200 ns;

end;
