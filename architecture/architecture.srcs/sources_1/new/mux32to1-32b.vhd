library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32to1_32b is
    Port ( mux_in0 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in2 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in3 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in4 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in5 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in6 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in7 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in8 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in9 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in10 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in11 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in12 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in13 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in14 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in15 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in16 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in17 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in18 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in19 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in20 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in21 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in22 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in23 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in24 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in25 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in26 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in27 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in28 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in29 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in30 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in31 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in STD_LOGIC_VECTOR (4 downto 0);
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end mux32to1_32b;

architecture Behavioral of mux32to1_32b is

begin
    with mux_sel select
        mux_out <= mux_in0 when "00000",
                   mux_in1 when "00001",
                   mux_in2 when "00010",
                   mux_in3 when "00011",
                   mux_in4 when "00100",
                   mux_in5 when "00101",
                   mux_in6 when "00110",
                   mux_in7 when "00111",
                   mux_in8 when "01000",
                   mux_in9 when "01001",
                   mux_in10 when "01010",
                   mux_in11 when "01011",
                   mux_in12 when "01100",
                   mux_in13 when "01101",
                   mux_in14 when "01110",
                   mux_in15 when "01111",
                   mux_in16 when "10000",
                   mux_in17 when "10001",
                   mux_in18 when "10010",
                   mux_in19 when "10011",
                   mux_in20 when "10100",
                   mux_in21 when "10101",
                   mux_in22 when "10110",
                   mux_in23 when "10111",
                   mux_in24 when "11000",
                   mux_in25 when "11001",
                   mux_in26 when "11010",
                   mux_in27 when "11011",
                   mux_in28 when "11100",
                   mux_in29 when "11101",
                   mux_in30 when "11110",
                   mux_in31 when others;
end Behavioral;
