library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity alu is
    Port ( alu_in_a : in STD_LOGIC_VECTOR (31 downto 0);
           alu_in_b : in STD_LOGIC_VECTOR (31 downto 0);
           operation: in STD_LOGIC_VECTOR (2 downto 0);
           func : in STD_LOGIC_VECTOR (5 downto 0);
           alu_output : out STD_LOGIC_VECTOR (31 downto 0);
           zero: out STD_LOGIC
           
           );
end alu;

architecture Alu_behaviour of alu is

    signal temp, less_than, r_signal : STD_LOGIC_VECTOR (31 downto 0);   
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

    -- R-TYPE --
    with func select
        r_signal <= (alu_in_a + alu_in_b) when "100000",
                    (alu_in_a - alu_in_b) when "100010",
                    (alu_in_a and alu_in_b) when "100100",
                    (alu_in_a or alu_in_b) when "100101",
                    (alu_in_a nor alu_in_b) when "100111",
                    (less_than) when "101010",
                    (std_logic_vector(shift_left(unsigned(alu_in_a),  to_integer(unsigned(alu_in_b))))) when "000000",
                    (std_logic_vector(shift_right(unsigned(alu_in_a), to_integer(unsigned(alu_in_b))))) when "000010",
                    (alu_in_a) when others;
    
    
    -- OPERACIONES INMEDIATAS --
    with operation select
        temp <= (alu_in_a + alu_in_b) when "000",
                (alu_in_a - alu_in_b) when "001",
                (r_signal) when "010",
                (alu_in_a or alu_in_b) when "011",
                (alu_in_a and alu_in_b) when "100",
                (less_than) when "101",
                alu_in_a when others;
    
    zero <= '1' when temp = "00000000000000000000000000000000" else
            '0';
                
    alu_output <= temp;

end Alu_behaviour;
