library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity uart_clockgen is
  Port ( clock: in STD_LOGIC;
         reset: in STD_LOGIC;
         output: out STD_LOGIC
  );
end uart_clockgen;

architecture Behavioral of uart_clockgen is

signal ucounter : STD_LOGIC_VECTOR(31 downto 0);
signal UART_CLK: STD_LOGIC := '0';

begin

process (clock, reset)
begin
            if (reset = '1') then
                ucounter <= (others => '0');
            else
                if (clock'event and clock ='1') then
                    ucounter <= (ucounter + '1');
                    --if (ucounter = "00000000000000000001010001010000") then
                    if (ucounter = "00000100000000000000000000000000") then --para probar con la tarjeta
                        UART_CLK <= not UART_CLK;
                        ucounter <= (others => '0');        
                    end if;
                end if;
            end if;    
    end process;
    
output <= UART_CLK;
    
end Behavioral;
