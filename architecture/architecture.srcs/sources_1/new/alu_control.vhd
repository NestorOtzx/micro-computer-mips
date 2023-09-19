library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_control is
    Port ( func: in STD_LOGIC_VECTOR (5 downto 0);
           alu_op: in STD_LOGIC_VECTOR (2 downto 0);
           control_out: out STD_LOGIC_VECTOR (3 downto 0)
    );
end alu_control;
architecture alu_ctrl of alu_control is

    signal r_signal: STD_LOGIC_VECTOR (3 downto 0);   
begin
    with func select
        r_signal <= "0000" when "100100",
                    "0001" when "100101",
                    "0010" when "100000",
                    "0011" when "100111",
                    "0100" when "000000",
                    "0101" when "000010",
                    "0110" when "100010",
                    "0111" when "101010",
                    "1111" when others;
    
    with alu_op select
        control_out <= "0010" when "000",
                       "0110" when "001",
                       (r_signal) when "010",
                       "0001" when "011",
                       "0000" when "100",
                       "0111" when "101",
                       "1111" when others; 


end alu_ctrl;
