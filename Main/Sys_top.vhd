library ieee ;
use ieee.std_logic_1164.all ;  
use ieee.numeric_std.all; 
use work.constants.all;   
use ieee.std_logic_unsigned.all;
use STD.textio.all;
use ieee.std_logic_textio.all;  

entity Sys_top is
	
	port (
	clk_p                 : in  std_logic;  
	rst_in                : in  std_logic ; 
    proc_beat			  : out std_logic; 
    
    scl                   : inout std_logic;  -- i2c scl line
    sda                   : inout std_logic;  -- i2c sda line

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
   
   TX                       : out   STD_LOGIC;
   RX                       : in    std_logic;
   TICK                     : out   std_logic   	
    );
  
end Sys_top ;       
   

                                                        

architecture Sys_top_a of Sys_top is  

    
    component ET1032 
    port ( 
	  clk                 : in std_logic ;              
	  rst                 : in std_logic ;              
	  wait_n              : in std_logic ; 
	  
	  reset_addr          : in std_logic_vector(31 downto 0); 
      
	  imem_req			  : out std_logic;     
      imem_seq			  : out std_logic; 
	  imem_addr 	  	  : out std_logic_vector(31 downto 0);
	  imem_data_in 	  	  : in std_logic_vector(31 downto 0); 	  
	  imem_access_fault   : in std_logic;
	  
	  dmem_req			  : out std_logic;     
	  dmem_rw			  : out std_logic;
	  dmem_size		  	  : out std_logic_vector(2 downto 0);
	  dmem_addr 	  	  : out std_logic_vector(31 downto 0);
	  dmem_data_in 	  	  : in std_logic_vector(31 downto 0);
	  dmem_data_out	  	  : out std_logic_vector(31 downto 0);    
	  
	  load_access_fault   : in std_logic;
	  load_addr_mis_align : in std_logic; 
	  
	  store_access_fault  : in std_logic;
	  store_addr_mis_align: in std_logic;
	  	  
	  timer_interrupt     : in std_logic;
	  ext_interrupt		  : in std_logic
	  
         ) ;   
	end component ; 
	
	
	component apb_i2c_ic is
	port (
	   PCLK              : in std_logic ;
	   PRESETn           : in std_logic ; 
	   PSEL              : in std_logic ;
	   PENABLE           : in std_logic ; 
	   PWrite            : in std_logic ; 
	   PADDR             : in std_logic_vector(31 downto 0) ; 
	   PWDATA            : in std_logic_vector(31 downto 0) ;
	   
	   PRDATA            : out std_logic_vector(31 downto 0) ;
	   PREADY            : out std_logic;
	   PSLVERR           : out std_logic ;
	   
	   i2c_sda           : inout std_logic ;
	   i2c_scl           : inout std_logic       
	
	); 
end component ; 
	
	component gpio_chip is
	port (
	   PCLK              : in std_logic ;
	   PRESETn           : in std_logic ; 
	   PSEL              : in std_logic ;
	   PENABLE           : in std_logic ; 
	   PWrite            : in std_logic ; 
	   PADDR             : in std_logic_vector(7 downto 0) ; 
	   PWDATA            : in std_logic_vector(15 downto 0) ;

	   PRDATA            : out std_logic_vector(15 downto 0);     
	   pin1              : inout std_logic ;
	   pin2              : inout std_logic ;
	   pin3              : inout std_logic ;
	   pin4              : inout std_logic ;
	   pin5              : inout std_logic ;
	   pin6              : inout std_logic ;
	   pin7              : inout std_logic ;
	   pin8             : inout std_logic ;
	   pin9             : inout std_logic ;
	   pin10              : inout std_logic ;
	   pin11              : inout std_logic ;
	   pin12              : inout std_logic ;
	   pin13              : inout std_logic ;
	   pin14              : inout std_logic ;
	   pin15              : inout std_logic ;
	   pin16             : inout std_logic 
	); 
    end component ; 

	component spi_top is
	 port(
	 PCLK               : in std_logic;
	 PRESETn            : in std_logic ;
	 PSEL               : in std_logic ;
     	 PENABLE            : in std_logic ;   
     	 PWrite             : in std_logic ;
      	 PADDR              : in std_logic_vector(31 downto 0) ;      
      	 PWDATA             : in std_logic_vector(31 downto 0) ;  
      	 miso               : in std_logic ;
      	 PRDATA             : out std_logic_vector(31 downto 0) ;
      	 --PREADY           : out std_logic ;
      	 ss                 : out std_logic ;
      	 sclk               : out std_logic ;
      	 mosi               : out std_logic 
	 );
	 end component;

	component UAPBCORE is
    port (
	
	 PCLK     :IN STD_LOGIC;
	 PRESETN  :IN STD_LOGIC;
	 PSEL     :IN STD_LOGIC;
	 PENABLE  :IN STD_LOGIC;
	 PADDR    :in std_logic_vector(31 downto 0) ;
	 PWRITE   :IN STD_LOGIC;
	 PWDATA   :in std_logic_vector(7 downto 0) ;
	 PRDATA   :out std_logic_vector(7 downto 0) ;
	 PREADY   :out std_logic;
	 RX       :IN STD_LOGIC;
	 TX       :OUT STD_LOGIC;
	DATAOUT   :out std_logic_vector(7 downto 0);
	tick1     :out std_logic
	
	
	 ) ;
	end component ; 
	
	
	COMPONENT mem_0
  	PORT (

	    clka 			  : IN STD_LOGIC;
	    ena               : IN STD_LOGIC;    
	    wea               : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	    addra             : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	    dina              : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	    douta             : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	    clkb              : IN STD_LOGIC;
	    enb               : IN STD_LOGIC;
	    web               : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	    addrb             : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	    dinb              : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	    doutb             : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

  );
	END COMPONENT;

	COMPONENT mem_1 is
	  Port ( 
	    clka 			  : in STD_LOGIC;
	    ena 			  : in STD_LOGIC;
	    wea               : in STD_LOGIC_VECTOR ( 3 downto 0 );
	    addra             : in STD_LOGIC_VECTOR ( 13 downto 0 );
	    dina              : in STD_LOGIC_VECTOR ( 31 downto 0 );
	    douta             : out STD_LOGIC_VECTOR ( 31 downto 0 );
	    clkb              : in STD_LOGIC;
	    enb               : in STD_LOGIC;
	    web               : in STD_LOGIC_VECTOR ( 3 downto 0 );
	    addrb             : in STD_LOGIC_VECTOR ( 13 downto 0 );
	    dinb              : in STD_LOGIC_VECTOR ( 31 downto 0 );
	    doutb             : out STD_LOGIC_VECTOR ( 31 downto 0 )
	  );
	
	end COMPONENT;
	
	
    
    -- new signals
        
    
	signal dmem_size	: std_logic_vector(2 downto 0);
	signal web_rw 		: STD_LOGIC;
    signal addra 		: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal douta 		: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal inst_data	: STD_LOGIC_VECTOR(31 DOWNTO 0);
        
    signal web 			: STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal addrb 		: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal addrb1 		: STD_LOGIC_VECTOR(31 DOWNTO 0);    
    signal addrb2 		: STD_LOGIC_VECTOR(31 DOWNTO 0);    

    
    signal dinb 		: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal doutb 		: STD_LOGIC_VECTOR(31 DOWNTO 0); 
    
    signal din_mux 		: STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal data_out		: STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal uart_dout0   : std_logic_vector(7 downto 0) ;      
    signal uart_dout1   : std_logic_vector(7 downto 0) ;      
   -- signal uart_dout2   : std_logic_vector(7 downto 0) ;      


    signal i2c_dout   : std_logic_vector(31 downto 0) ;      
    signal gpio_dout  : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
    signal spi_dout   : std_logic_vector(31 downto 0) ;

  
  
    
    signal PSEL         : STD_LOGIC;
    signal i2c_wr0      : STD_LOGIC;
    signal uart_wr2     : STD_LOGIC;
    
    
   
    signal dmem_cs  	: STD_LOGIC;                                   
    
    signal i2c_cs0      : STD_LOGIC;
    signal gpio_cs1  	: STD_LOGIC; 
    signal spi_cs       : STD_LOGIC;
    signal uart_cs2     : STD_LOGIC; 
    signal uart_dout2   : std_logic_vector(7 downto 0);

    signal plic_cs  	: STD_LOGIC; 
    signal rom_cs  		: STD_LOGIC;
    signal pm_mem_cs    : STD_LOGIC;     
        
    signal clk_n        : STD_LOGIC; 
    signal wait_n       : STD_LOGIC; 
    signal uart_intr0   : STD_LOGIC; 
    
     
    

    signal mtime_intr   : STD_LOGIC;  
    
    signal ena  		: STD_LOGIC;
	signal enb		    : STD_LOGIC;   
  
	signal pm_web       : STD_LOGIC_VECTOR(3 DOWNTO 0);        
	signal pm_douta     : STD_LOGIC_VECTOR(31 DOWNTO 0);   
	signal pm_doutb     : STD_LOGIC_VECTOR(31 DOWNTO 0);  
	
	signal prdata_plic  : STD_LOGIC_VECTOR(31 DOWNTO 0);         
	   
	signal ext_intr     : std_logic;  
	signal raw_interrupt    : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	signal enable_interrupt : STD_LOGIC_VECTOR(31 DOWNTO 0);                      
	signal status_interrupt : STD_LOGIC_VECTOR(31 DOWNTO 0); 	

    signal mtime_ext    : STD_LOGIC_VECTOR(63 DOWNTO 0); 
    signal mtimecmp_ext : STD_LOGIC_VECTOR(63 DOWNTO 0); 
    signal mtime_count  : STD_LOGIC_VECTOR(11 DOWNTO 0); 
    signal reset        : STD_LOGIC; 
	
	signal fromhost_rd	: STD_LOGIC;
	
	signal reset_n      : STD_LOGIC;   
	
	signal reset_signal : STD_LOGIC;          
	
	
	--------------- FILE WRITE ----------
  	file out_file_RESULTS : text;
	
	signal boot : std_logic;
	
    
	begin   
    
	u_processor: ET1032 port map ( 
	
	  clk                 => clk_p,               
	  rst                 => reset,               
	  wait_n              => wait_n,    
	  
	  reset_addr          => x"00010000",
      
	  imem_req			  => ena,
      imem_seq			  => open,
	  imem_addr 		  => addra,
	  imem_data_in 	  	  => inst_data, 
	  imem_access_fault   => '0',
	  
	  dmem_req			  => enb,
	  dmem_rw			  => web_rw,--
	  dmem_size		  	  => dmem_size,
	  dmem_addr  	  	  => addrb,
	  dmem_data_in 	  	  => din_mux,
	  dmem_data_out	  	  => data_out,    
	  
	  load_access_fault   => '0',
	  load_addr_mis_align => '0',
	                      
	  store_access_fault  => '0',
	  store_addr_mis_align=> '0',
 	  
	  timer_interrupt     => mtime_intr,
	  ext_interrupt		  => ext_intr  
	  
      );   
      clk_n <= not(clk_p);
      wait_n <= '1';
	
         
    -- I2C port mapping
	i2c_top: apb_i2c_ic port map (
	
      PCLK                 => clk_p,             
      PRESETn              => reset,                            
      PSEL                 => i2c_cs0,                            
      PADDR                => addrb(31 downto 0),          
      PWrite               => web_rw,                                   
      PWDATA               => dinb,

      PRDATA               => i2c_dout, 
      PENABLE              => enb  ,
      PREADY               => open,
      PSLVERR              => open,
      i2c_scl              => scl,
      i2c_sda              => sda                  
         ) ;
            
      gpio_top: gpio_chip port map (
	
      PCLK                 => clk_p,             
      PRESETn              => reset,                            
      PSEL                 => gpio_cs1,                            
      PADDR                => addrb(7 downto 0),          
      PWrite               => web_rw,                                   
      PWDATA               => dinb(15 downto 0),
      PRDATA               => gpio_dout(15 downto 0), 
      PENABLE              => enb, 
       pin1                => st_pin1,
       pin2                => st_pin2,
       pin3                => st_pin3,
       pin4                => st_pin4, 
       pin5                => st_pin5,
       pin6                => st_pin6,
       pin7                => st_pin7,
       pin8                => st_pin8,
       pin9                => st_pin9,
       pin10                => st_pin10,
       pin11                => st_pin11,
       pin12                => st_pin12, 
       pin13                => st_pin13,
       pin14                => st_pin14,
       pin15                => st_pin15,
       pin16                => st_pin16          
         ) ;

u_spi : spi_top port map ( 
         
           PRESETn    => reset,    
           PCLK       => clk_p,
           PENABLE    => enb,
           PSEL       => spi_cs,    
           PADDR      => addrb(31 downto 0),    
           PWrite     => web_rw,   
           PWDATA     => dinb,    
           miso       => miso,    
       
           PRDATA     => spi_dout,    
        --   PREADY     => open,
            ss        => ss,             
           sclk       => sclk,   
           mosi       =>  mosi   
         );

u_uart_2: UAPBCORE
	 port map (
	
      PCLK                  => clk_p ,             
      PRESETN               => reset,                            
      PSEL                  => uart_cs2,                            
      PENABLE               => enb,         
      PADDR                 => addrb(31 downto 0),
                                         
      PWRITE                => uart_wr2,     
      PWDATA                => dinb(7 downto 0),              
      PRDATA                => uart_dout2,
      PREADY                => open,
      RX                    => RX,
      TX                    => TX,                  
      DATAOUT               => uart_dout2,
      tick1                 => TICK      
         );


	      
     -- NEW UART
     	
         
--     	u_uart_2: uart_top port map (
	
--      clk                 => clk_n,             
--      mr                  => reset,                            
--      cs                  => uart_cs2,                            
--      a                   => addrb(4 downto 2),          
--      rd                  => uart_rd2,           
--      wr                  => uart_wr2,           
--      sin                 => sin2,               
--      din                 => dinb(7 downto 0),

--      dout                => uart_dout2,             
--      sout                => sout2,        
--      ddis                => open,        
--      intr                => uart_intr2,   
--      baudout_n           => open,        
--      rxrdy_n             => open,        
--      txrdy_n             => open         
--         ) ;  
         
 	boot_mem : mem_0                                                                             
                                                                           
  	PORT MAP (                                                             
      clka 	           	  => clk_n,--(not clk),                            
      wea 	              => "0000",
      ena		          => rom_cs,                                          
      addra 	          => addra(14 downto 2),                           
      dina 	              => x"00000000",          
      douta 	          => douta,                                        
      clkb 	              => clk_n,--(not clk),                            
      web 	              => "0000",
      enb		          => dmem_cs,
      addrb 	          => addrb(14 downto 2),
      dinb 	              => x"00000000",
      doutb 	          => doutb
  	);       
  	
  	program_mem :	mem_1 
  	
	  PORT MAP ( 
	    clka 			  => clk_n,--(not clk),        
	    ena 			  => ena,                      
	    wea               => "0000",                   
	    addra             => addra(15 downto 2),       
	    dina              => x"00000000",              
	    douta             => pm_douta,                 
	    clkb              => clk_n,                     
	    enb               => pm_mem_cs,                
	    web               => pm_web,                    
	    addrb             => addrb(15 downto 2),        
	    dinb              => data_out,                 
	    doutb             => pm_doutb                  
	  );
	         
	 rom_cs <= '1' when ( (addra(31 downto 16)= "0000000000000001" ) and (ena='1')) else '0';	     
      
     proc_beat <= scl;  
	 dinb      <= data_out ;     
	 inst_data <= pm_douta 				when addra(31 downto 18)= "00000000001000" else   --00200000-0023ffff  --256KB program memory	             
                                        douta;	
	 pm_web <="1111" 	when web_rw ='1' and dmem_size ="010" else
			  "0011"		when web_rw ='1' and dmem_size ="001" and addrb(1 downto 0)="00" else 
			  "1100"		when web_rw ='1' and dmem_size ="001" and addrb(1 downto 0)="10" else		
	 		  "0001"		when web_rw ='1' and dmem_size ="000" and addrb(1 downto 0)="00"  else 
	 		  "0010"		when web_rw ='1' and dmem_size ="000" and addrb(1 downto 0)="01"  else
	 		  "0100"		when web_rw ='1' and dmem_size ="000" and addrb(1 downto 0)="10"  else
	 		  "1000"		when web_rw ='1' and dmem_size ="000" and addrb(1 downto 0)="11"  else "0000";
	 		 			 
	reset_genr: process(clk_p,rst_in)
   
    begin 
     	
     	if rst_in='0' then
     	
     		reset		<=	'1';  
     		
     		reset_signal <= '1';    
          	
     	else     	
     	    if clk_p'event and clk_p = '1' then 
       	           	      
     	    	reset_signal <= '0';  
     	    	
     	    	reset        <= reset_signal;
     	                 	         
     	    end if;
     	    
       	end if;     
    end process;    
		
	reset_n <= not reset; 
	
	din_mux 	<=  pm_doutb 										  when (pm_mem_cs = '1') else  				   
					
					i2c_dout when (i2c_cs0  = '1') else 
					gpio_dout when (gpio_cs1   = '1') else
					spi_dout  when (spi_cs   = '1') else


					prdata_plic                                       when (plic_cs   = '1') else
				    doutb 											  when (dmem_cs   =  '1') else ("00000000000000000000000000000000");
				    
	pm_mem_cs     <= '1' when ((addrb(31 downto 18)  = "00000000001000") and (enb = '1')) else '0';    -- 00200000-0023ffff   --program memory              
	
    i2c_cs0 	  <= '1' when addrb(31 downto 8)   = x"300007"  and enb = '1' else '0';                -- 10000100- 100001ff  --I2C0  
    gpio_cs1 	  <= '1' when addrb(31 downto 8)   = x"300008"  and enb = '1' else '0';                -- 30000800- 300008ff  --gpio1
    spi_cs        <= '1' when addrb(31 downto 8)   = x"300006"  and enb = '1' else '0'; 
    uart_cs2      <='1' when  addrb(31 downto 8)   =x"300009"  else '0';
    uart_wr2      <= '1' when uart_cs2 = '1' else '0';
						
	dmem_cs 	  <= '1' when addrb(31 downto 16)  = x"0001"    and enb = '1' else '0';                -- 00010000-00017fff   --Boot Memory 
    plic_cs  	  <= '1' when addrb(31 downto 12)  = x"20010"	and enb = '1' else '0';  -- 20010000- 200100ff    --20010000-raw interrupt  , 20010008- interrupt enables  , 20010010- interrupt status   
    
   
	
	
    
   
	int_controller: process(clk_n,reset)
   
    begin 
     	
     	if reset='1' then
     	
     	  	enable_interrupt <=x"00000000";
			status_interrupt <=x"00000000"; 
			prdata_plic      <=x"00000000";
			
     	  	mtime_ext   	<=x"0000000000000000";
			mtimecmp_ext	<=x"ffffffffffffffff";
			mtime_count 	<=x"000";
			mtime_intr		<='0';
     	
     	else
     	      if clk_n'event and clk_n = '1' then    
     	      	
     	      	mtime_count<= mtime_count+1;           	      	   
     	      	      
     	      	if (mtime_count=x"f9f" )then
     	        		mtime_ext <= mtime_ext+1;
     	        		mtime_count 	<=x"000";
     	        end if;
     	        
	     	    if (mtime_ext > mtimecmp_ext) then  
	     	    		mtime_intr <= '1';
	     	    else
	     	    	    mtime_intr <= '0';			       
	     	    end if;         	      	            
  
     	      	if plic_cs ='1' and enb='1' and web_rw='1' and 	addrb  = x"20010008" then  
     	      		
     	      		enable_interrupt <= data_out;  
     	      	
     	      	elsif plic_cs ='1' and enb='1' and web_rw='1' and 	addrb  = x"20010580" then  
     	      		
     	      		mtime_ext(31 downto 0) <= data_out; 
     	      			
     	      	elsif plic_cs ='1' and enb='1' and web_rw='1' and 	addrb  = x"20010584" then  
     	      		
     	      		mtime_ext(63 downto 32) <= data_out; 
     	      	
     	      	elsif plic_cs ='1' and enb='1' and web_rw='1' and 	addrb  = x"20010480" then  
     	      		
     	      		mtimecmp_ext(31 downto 0) <= data_out; 
     	      			
     	      	elsif plic_cs ='1' and enb='1' and web_rw='1' and 	addrb  = x"20010484" then  
     	      		
     	      		mtimecmp_ext(63 downto 32) <= data_out;     	      	
     	      	
     	      	end if;	
     	      	
     	      	status_interrupt <= enable_interrupt and raw_interrupt;
     	      	
     	      	if plic_cs ='1' and enb='1' and web_rw='0' and 	addrb  = x"20010000" then  
     	      	
     	      		prdata_plic <= raw_interrupt;      
     	      		
     	      	elsif plic_cs ='1' and enb='1' and web_rw='0' and 	addrb  = x"20010008" then 
     	      		
     	      		prdata_plic <= enable_interrupt;                                                       
     	      		                                                                                       
     	      	elsif plic_cs ='1' and enb='1' and web_rw='0' and 	addrb  = x"20010010" then              
     	      		                                                                                       
     	      		prdata_plic <= status_interrupt;    
     	      		
     	      	elsif plic_cs ='1' and enb='1' and web_rw='0' and 	addrb  = x"20010580" then              
     	      		                                                                                       
     	      		prdata_plic <= mtime_ext(31 downto 0); 
     	      		
     	      	elsif plic_cs ='1' and enb='1' and web_rw='0' and 	addrb  = x"20010584" then              
     	      		                                                                                       
     	      		prdata_plic <= mtime_ext(63 downto 32); 		      
     	      		            
     	      	elsif plic_cs ='1' and enb='1' and web_rw='0' and 	addrb  = x"20010480" then              
     	      		                                                                                       
     	      		prdata_plic <= mtimecmp_ext(31 downto 0); 
     	      		
     	      	elsif plic_cs ='1' and enb='1' and web_rw='0' and 	addrb  = x"20010484" then              
     	      		                                                                                       
     	      		prdata_plic <= mtimecmp_ext(63 downto 32); 	                  
                                                                           
     	      	end if;		                                                                               
     	      	                                                                                           
              end if;                                                                                      
       	end if;                                                                                            
    end process;                                                                                           
	                                                                                                       
	raw_interrupt <=	"0000000000000000000000000000000"& uart_intr0;                                                 
	                                                                                                        
    ext_intr <= '0' when status_interrupt = x"00000000" else '1';  
                       
	end Sys_top_a ;        
	  
 