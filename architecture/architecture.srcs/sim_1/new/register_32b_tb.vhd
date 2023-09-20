library ieee;
use ieee.std_logic_1164.all;

entity tb_register_32b is
end tb_register_32b;

architecture tb of tb_register_32b is

    component register_32b
        port (reg_input    : in std_logic_vector (31 downto 0);
              write_enable : in std_logic;
              clk          : in std_logic;
              reset        : in std_logic;
              reg_output   : out std_logic_vector (31 downto 0));
    end component;

    signal reg_input    : std_logic_vector (31 downto 0);
    signal write_enable : std_logic;
    signal clk          : std_logic;
    signal reset        : std_logic;
    signal reg_output   : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : register_32b
    port map (reg_input    => reg_input,
              write_enable => write_enable,
              clk          => clk,
              reset        => reset,
              reg_output   => reg_output);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        reg_input <= "00000000000000000000000000000001";
        write_enable <= '1';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;
        
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
        
        reg_input <= "00000000000000000000000000000011";
        write_enable <= '1';
        
        wait for 100 * TbPeriod;
        
        reg_input <= "00000000000000000000000000000111";
        write_enable <= '1';
      
        wait for 100 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_register_32b of tb_register_32b is
    for tb
    end for;
end cfg_tb_register_32b;