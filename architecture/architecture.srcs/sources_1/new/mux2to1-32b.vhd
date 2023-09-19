library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1_32b is
    Port ( mux_in0 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in STD_LOGIC;
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end mux2to1_32b;

architecture Behavioral of mux2to1_32b is

begin
    with mux_sel select
        mux_out <= mux_in0 when '0',
                   mux_in1 when others;


end Behavioral;
