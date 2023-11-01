library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity controlDisplay is
    Port ( dataIn : in STD_LOGIC_VECTOR (15 downto 0);
            clock, reset : STD_LOGIC;
           --counter : in STD_LOGIC_VECTOR (1 downto 0);
           enDigit : out STD_LOGIC_VECTOR (3 downto 0);
           sevenSeg : out STD_LOGIC_VECTOR (6 downto 0));
end controlDisplay;

architecture Behavioral of controlDisplay is
    component mux4to1_4b
    Port ( inputA, inputB, inputC, inputD : in STD_LOGIC_VECTOR (3 downto 0);
           selection : in STD_LOGIC_VECTOR (1 downto 0);
           outputX : out STD_LOGIC_VECTOR (3 downto 0)
           );
    end component;

    component bin2Hex
    Port ( binIn : in STD_LOGIC_VECTOR (3 downto 0);
           sevenSeg : out STD_LOGIC_VECTOR (6 downto 0));    
    end component;
    
    component counterDisplay
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           countOut : out STD_LOGIC_VECTOR (20 downto 0));
    end component;

    signal tempMuxOut : std_logic_vector(3 downto 0);
    signal counter :  std_logic_vector(20 downto 0);
begin

    U0 : mux4to1_4b
    port map(
        inputA => dataIn(3 downto 0),
        inputB => dataIn(7 downto 4),
        inputC => dataIn(11 downto 8),
        inputD => dataIn(15 downto 12),
        selection => counter(20 downto 19),
        outputX => tempMuxOut
    );
    
    U1 : bin2Hex
    port map(
        binIn => tempMuxOut,
        sevenSeg => sevenSeg
    );
   
   U2 : counterDisplay
   port map (
        clock => clock,
        reset => reset,
        countOut => counter
   );
    
    with counter (20 downto 19) select
        enDigit <=  "1110" when "00",
                    "1101" when "01",
                    "1011" when "10",
                    "0111" when others;

end Behavioral;
