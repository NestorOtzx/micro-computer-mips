
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux4to1_4b is
    Port ( inputA, inputB, inputC, inputD : in STD_LOGIC_VECTOR (3 downto 0);
           selection : in STD_LOGIC_VECTOR (1 downto 0);
           outputX : out STD_LOGIC_VECTOR (3 downto 0)
           );
end mux4to1_4b;


architecture Behavioral of mux4to1_4b is

begin
--    outputX <= inputA when selection = "00" else
--               inputB when selection = "01" else
--               inputC when selection = "10" else
--               inputD; 

    with selection select
        outputX <=  inputA when "00",
                    inputB when "01",
                    inputC when "10",
                    inputD when others;
end Behavioral;
