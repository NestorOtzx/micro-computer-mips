library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity extensor_uart is
  Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        send_word: in STD_LOGIC;
        word: in STD_LOGIC_VECTOR(7 downto 0);
        out_send_word: out STD_LOGIC;
        out_word: out STD_LOGIC_VECTOR(7 downto 0)
  );
end extensor_uart;

architecture Behavioral of extensor_uart is

signal ucounter: std_logic_vector(31 downto 0);
signal divide: STD_LOGIC := '0'; -- Controla si estamos extendiendo o no un pulso

begin

process (clk, reset, send_word)
begin
        if (reset = '1') then
            ucounter <= (others => '0');
            out_word <= (others => '0');
            out_send_word <= '0';
            divide <= '0';
        else
            if (send_word'event and send_word ='1' and divide = '0') then
                ucounter <= (others => '0');
                out_word <= word;
                out_send_word <= '1';
                divide <= '1';
            end if;
            if (clk'event and clk ='1' and divide = '1') then
                ucounter <= (ucounter + '1');
                if (ucounter = "00000000000000000000001000000000") then -- mas rapido
                    ucounter <= (others => '0');
                    if (send_word = '0') then
                        out_send_word <= '0';
                        out_word <= (others => '0');
                        divide <= '0';
                    end if;        
                end if;
            end if;
        end if;    
end process;

end Behavioral;
