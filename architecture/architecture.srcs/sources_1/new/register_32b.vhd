library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_32b is
    Port ( reg_input : in STD_LOGIC_VECTOR (31 downto 0);
           write_enable: in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           reg_output : out STD_LOGIC_VECTOR (31 downto 0));
end register_32b;

architecture Behavioral of register_32b is

begin
    process(clk, reset)
    begin 
        if reset = '1' then
            reg_output <= "00000000000000000000000000000000";
        elsif rising_edge(clk) then
            if write_enable = '1' then
                reg_output <= reg_input;
            end if;
        end if;
    end process;

end Behavioral;
--00100010001100000000000000010000
