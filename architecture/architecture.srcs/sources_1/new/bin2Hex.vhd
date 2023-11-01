
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bin2Hex is
    Port ( binIn : in STD_LOGIC_VECTOR (3 downto 0);
           sevenSeg : out STD_LOGIC_VECTOR (6 downto 0));
end bin2Hex;

architecture Behavioral of bin2Hex is

begin
    sevenSeg <= "0000001" when binIn = "0000" else
                "1001111" when binIn = "0001" else
                "0010010" when binIn = "0010" else
                "0000110" when binIn = "0011" else
                "1001100" when binIn = "0100" else
                "0100100" when binIn = "0101" else
                "0100000" when binIn = "0110" else
                "0001111" when binIn = "0111" else
                "0000000" when binIn = "1000" else
                "0001100" when binIn = "1001" else
                "0001000" when binIn = "1010" else
                "1100000" when binIn = "1011" else
                "0110001" when binIn = "1100" else
                "1000010" when binIn = "1101" else
                "0110000" when binIn = "1110" else
                "0111000" when binIn = "1111" else
                "1111111";

end Behavioral;
