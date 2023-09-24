library ieee;
use ieee.std_logic_1164.all;

entity tb_sign_extend is
end tb_sign_extend;

architecture tb of tb_sign_extend is

    component sign_extend
        port (input  : in std_logic_vector (15 downto 0);
              output : out std_logic_vector (31 downto 0));
    end component;

    signal input  : std_logic_vector (15 downto 0);
    signal output : std_logic_vector (31 downto 0);

begin

    dut : sign_extend
    port map (input  => input,
              output => output);

    stimuli : process
    begin
        input <= (others => '0');
        wait for 10 ns;
        
        input <= "0000000000000001";
        wait for 10 ns;
        
        input <= "1000000000000001";
        wait for 10 ns;
        
    end process;

end tb;


configuration cfg_tb_sign_extend of tb_sign_extend is
    for tb
    end for;
end cfg_tb_sign_extend;