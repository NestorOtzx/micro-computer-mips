library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity alu is
    Port ( alu_in_a : in STD_LOGIC_VECTOR (31 downto 0);
           alu_in_b : in STD_LOGIC_VECTOR (31 downto 0);
           operation: in STD_LOGIC_VECTOR (3 downto 0);
           alu_output : out STD_LOGIC_VECTOR (31 downto 0);
           zero: out STD_LOGIC
           );
end alu;

architecture Alu_behaviour of alu is

    signal temp, less_than: STD_LOGIC_VECTOR (31 downto 0);   
begin

    -- A < B --
    process (alu_in_a, alu_in_b)
    begin
        if (alu_in_a < alu_in_b) then
            less_than <= "00000000000000000000000000000001";
        else
            less_than <= "00000000000000000000000000000000";
        end if;
    end process;

    -- OPERACIONES INMEDIATAS --
    with operation select
        temp <= (alu_in_a and alu_in_b) when "0000",
                (alu_in_a or alu_in_b) when "0001",
                (alu_in_a + alu_in_b) when "0010",
                (alu_in_a nor alu_in_b) when "0011",
                (std_logic_vector(shift_left(unsigned(alu_in_a),  to_integer(unsigned(alu_in_b))))) when "0100",
                (std_logic_vector(shift_right(unsigned(alu_in_a), to_integer(unsigned(alu_in_b))))) when "0101",
                (alu_in_a - alu_in_b) when "0110",
                (less_than) when "0111",
                "00000000000000000000000000000000" when others;
    
    zero <= '1' when temp = "00000000000000000000000000000000" else
            '0';
                
    alu_output <= temp;

end Alu_behaviour;
