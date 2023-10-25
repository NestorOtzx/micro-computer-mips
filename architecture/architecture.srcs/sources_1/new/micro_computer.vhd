library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity micro_computer is
  Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        leds: out std_logic_vector(15 downto 0)
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
          --salidas--
           main_out : out STD_LOGIC_VECTOR (31 downto 0);

           --otros--
           main_clk: in STD_LOGIC;
           main_reset: in STD_LOGIC;       
           
           pcOut: out std_logic_vector(31 downto 0 );
           testMemOut: out std_logic_vector(31 downto 0);
           testInstruction: out std_logic_vector(31 downto 0);
           testALUUP: out std_logic_vector(31 downto 0);
           testALUDOWN: out std_logic_vector(31 downto 0);
           testSignExtend: out std_logic_vector(31 downto 0)       

           );
end component;

signal divisor_counter: STD_LOGIC_VECTOR (31 downto 0); 
signal signal_aluout: STD_LOGIC_VECTOR (31 downto 0);
signal signal_pcTest: STD_LOGIC_VECTOR (31 downto 0);
begin

divisor: count_32bit
    port map(
        clk => clk,
        reset => reset,
        count => divisor_counter
    );

arquitecture: main_arquitecture
    port map(
        main_out        => signal_aluout,
        main_clk        => clk,
        main_reset      => reset,
        pcOut           => signal_pcTest
--      testMemOut      => testMemOut,
--      testInstruction => testInstruction,
--      testALUUP       => testALUUP,
--      testALUDOWN     => testALUDOWN,
--      testSignExtend  => testSignExtend
    );

--testIRWRITE <= signal_ir_write;
leds(15) <= divisor_counter(26);
leds (14 downto 11) <= signal_pcTest(3 downto 0);
leds (10 downto 0) <= signal_aluout(10 downto 0);
--pcOut <= signal_pcTest;


--aluout<= signal_aluout;
end Behavioral;
