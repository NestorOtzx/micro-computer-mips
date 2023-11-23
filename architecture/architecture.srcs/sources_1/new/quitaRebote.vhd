library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
 
entity quitaRebote is

    Port ( boton : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           pulso : out STD_LOGIC);

end quitaRebote;

architecture Behavioral of quitaRebote is
    signal currentState, nextState : std_logic_vector (19 downto 0);
    signal iclock : std_logic; -- divided clock
begin
    process (clock)
    begin
        if (clock'event and clock='1') then
            if (reset ='1') then
                currentState <= "00000000000000000000";
            else
                currentState <= currentState + '1';
            end if;
        end if;
    end process;

    iclock <= currentState(10);

    process (iclock, reset)
    begin
        if (reset = '1') then
            pulso <= '0';
        elsif (iclock'event and iclock='1') then
            pulso <= boton;
        end if;
        
    end process;
end Behavioral;