library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8to1_32b is
    Port ( mux_in0 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in2 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in3 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in4 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in5 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in6 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in7 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in STD_LOGIC_VECTOR (2 downto 0);
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end mux8to1_32b;

architecture Behavioral of mux8to1_32b is

begin
    with mux_sel select
        mux_out <= mux_in0 when "000",
                   mux_in1 when "001",
                   mux_in2 when "010",
                   mux_in3 when "011",
                   mux_in4 when "100",
                   mux_in5 when "101",
                   mux_in6 when "110",
                   mux_in7 when others;
end Behavioral;

