
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity counterDisplay is
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           countOut : out STD_LOGIC_VECTOR (20 downto 0));
end counterDisplay;

architecture Behavioral of counterDisplay is
    signal currentCount, nextCount : std_logic_vector (20 downto 0);
begin
    process (reset,clock)
    begin
        if (reset = '1') then 
            currentCount <= (others => '0');
        else
            if (clock'event and clock='1') then
                currentCount <= nextCount;
            end if;
        end if;
    end process;
    
    nextCount <= currentCount + 1;
    countOut <= currentCount;

end Behavioral;
