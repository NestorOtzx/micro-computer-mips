
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mux4to1_5b is
    Port ( mux_in0 : in STD_LOGIC_VECTOR (4 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (4 downto 0);
           mux_in2 : in STD_LOGIC_VECTOR (4 downto 0);
           mux_in3 : in STD_LOGIC_VECTOR (4 downto 0);
           mux_sel : in STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out STD_LOGIC_VECTOR (4 downto 0));
end mux4to1_5b;

architecture Behavioral of mux4to1_5b is
    
begin
    with mux_sel select
        mux_out <= mux_in0 when "00",
                   mux_in1 when "01",
                   mux_in2 when "10",
                   mux_in3 when others;
end Behavioral;
