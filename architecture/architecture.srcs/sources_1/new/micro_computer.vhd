library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity micro_computer is
  Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        leds: out std_logic_vector(15 downto 0);
        memout: out std_logic_vector(31 downto 0)
  );
end micro_computer;

architecture Behavioral of micro_computer is

component count_32bit
    Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        count: out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

component main_arquitecture
    Port ( 
           mem_data: in STD_LOGIC_VECTOR( 31 downto 0 );
           
           --salidas--
           iord_out: out STD_LOGIC_VECTOR (31 downto 0);
           main_out : out STD_LOGIC_VECTOR (31 downto 0);
           registerBout: out STD_LOGIC_VECTOR (31 downto 0);
           
           mem_rd: out STD_LOGIC;
           mem_wr: out STD_LOGIC;           

           --otros--
           main_clk: in STD_LOGIC;
           main_reset: in STD_LOGIC               
           );
end component;

component ram
    port (    dir       : in std_logic_vector (31 downto 0);
              data      : in std_logic_vector (31 downto 0);
              mem_read  : in std_logic;
              mem_write : in std_logic;
              mem_data  : out std_logic_vector (31 downto 0);
              clk       : in std_logic;
              reset     : in std_logic);
end component;

signal divisor_counter: STD_LOGIC_VECTOR (31 downto 0); 
signal signal_aluout: STD_LOGIC_VECTOR (31 downto 0);
signal signal_pcTest: STD_LOGIC_VECTOR (31 downto 0);

-- ARQUITECTURE SIGNALS --

signal signal_iord, signal_memout, signal_memin: STD_LOGIC_VECTOR (31 downto 0);
signal singal_memwr, singal_memrd: STD_LOGIC; 

begin

U_MEMORY: ram
port map (    dir => signal_iord, --direccion de la instruccion
              data => signal_memin,
              mem_read => singal_memrd,
              mem_write => singal_memwr,
              mem_data => signal_memout,
              clk => clk,
              reset => reset
         );

memout<=signal_memout;

divisor: count_32bit
    port map(
        clk => clk,
        reset => reset,
        count => divisor_counter
    );

arquitecture: main_arquitecture
    port map(
    
        mem_data => signal_memout,
        iord_out => signal_iord,
        main_out => signal_aluout,
        registerBout => signal_memin,
        mem_rd => singal_memrd,
        mem_wr => singal_memwr,   
        --testInstruction =>  
        
        main_clk        => clk,
        main_reset      => reset
    );

--testIRWRITE <= signal_ir_write;

leds (15 downto 11) <= signal_iord(4 downto 0);
leds (10 downto 0) <= signal_aluout(10 downto 0);
--pcOut <= signal_pcTest;


--aluout<= signal_aluout;
end Behavioral;
