library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity count_32bit is
  Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        count: out STD_LOGIC_VECTOR (31 downto 0)
  );
end count_32bit;

architecture Behavioral of count_32bit is

signal signal_count: STD_LOGIC_VECTOR(31 downto 0);

begin
    
process (clk, reset)
    begin
        if (reset = '1') then
            signal_count <= (others => '0');
        else
            if (clk'event and clk ='1') then
                signal_count <= (signal_count + '1');
            end if;
        end if;    
end process;
count <= signal_count;
end Behavioral;
