library ieee;
use ieee.std_logic_1164.all;

entity tb_alu is
end tb_alu;

architecture tb of tb_alu is

    component alu
        port (alu_in_a   : in std_logic_vector (31 downto 0);
              alu_in_b   : in std_logic_vector (31 downto 0);
              operation  : in std_logic_vector (3 downto 0);
              alu_output : out std_logic_vector (31 downto 0);
              zero       : out std_logic);
    end component;

    signal alu_in_a   : std_logic_vector (31 downto 0);
    signal alu_in_b   : std_logic_vector (31 downto 0);
    signal operation  : std_logic_vector (3 downto 0);
    signal alu_output : std_logic_vector (31 downto 0);
    signal zero       : std_logic;

begin

    dut : alu
    port map (alu_in_a   => alu_in_a,
              alu_in_b   => alu_in_b,
              operation  => operation,
              alu_output => alu_output,
              zero       => zero);

    stimuli : process
    begin
        -- PRUEBA DE AND
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000001010";
        operation <= "0000";

        wait for 10 ns;
        
        -- PRUEBA DE OR
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000001010";
        operation <= "0001";

        wait for 10 ns;
        
        -- PRUEBA DE +
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000001010";
        operation <= "0010";

        wait for 10 ns;
        
        -- PRUEBA DE NOR
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000001010";
        operation <= "0011";

        wait for 10 ns;
        
        -- PRUEBA DE SLL
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000000010";
        operation <= "0100";

        wait for 10 ns;
        
        -- PRUEBA DE SRL
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000000010";
        operation <= "0101";

        wait for 10 ns;
        
        -- PRUEBA DE -
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000001010";
        operation <= "0110";

        wait for 10 ns;
        
        -- PRUEBA DE SLT
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000001010";
        operation <= "0111";

        wait for 10 ns;
        
        alu_in_a <= "00000000000000000000000000001100";
        alu_in_b <= "00000000000000000000000000011010";
        operation <= "0111";

        wait for 10 ns;
        
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_alu of tb_alu is
    for tb
    end for;
end cfg_tb_alu;