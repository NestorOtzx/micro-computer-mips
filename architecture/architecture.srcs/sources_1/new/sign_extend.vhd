library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity sign_extend is
        Port (
            input: in STD_LOGIC_VECTOR(15 downto 0);
            output: out STD_LOGIC_VECTOR(31 downto 0)
        );
end sign_extend;
architecture Behavioral of sign_extend is
begin
process(input)
begin
if (input(15)='1') then --si es negativo
    output<="1111111111111111"&input; --concatenar
else
    output<="0000000000000000"&Input;
end if;
end process;
end Behavioral;