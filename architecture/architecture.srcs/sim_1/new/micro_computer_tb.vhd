-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 13.10.2023 21:19:27 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_micro_computer is
end tb_micro_computer;

architecture tb of tb_micro_computer is

    component micro_computer
        port (clk             : in std_logic;
              reset           : in std_logic;
              aluout          : out std_logic_vector (31 downto 0);
              pcOut           : out std_logic_vector (31 downto 0);
              testMemOut      : out std_logic_vector (31 downto 0);
              testInstruction : out std_logic_vector (31 downto 0);
              testALUUP       : out std_logic_vector (31 downto 0);
              testALUDOWN     : out std_logic_vector (31 downto 0);
              testSignExtend  : out std_logic_vector (31 downto 0);
              testIRWRITE     : out std_logic);
    end component;

    signal clk             : std_logic;
    signal reset           : std_logic;
    signal aluout          : std_logic_vector (31 downto 0);
    signal pcOut           : std_logic_vector (31 downto 0);
    signal testMemOut      : std_logic_vector (31 downto 0);
    signal testInstruction : std_logic_vector (31 downto 0);
    signal testALUUP       : std_logic_vector (31 downto 0);
    signal testALUDOWN     : std_logic_vector (31 downto 0);
    signal testSignExtend  : std_logic_vector (31 downto 0);
    signal testIRWRITE     : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : micro_computer
    port map (clk             => clk,
              reset           => reset,
              aluout          => aluout,
              pcOut           => pcOut,
              testMemOut      => testMemOut,
              testInstruction => testInstruction,
              testALUUP       => testALUUP,
              testALUDOWN     => testALUDOWN,
              testSignExtend  => testSignExtend,
              testIRWRITE     => testIRWRITE);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';


        -- EDIT Add stimuli here
        wait for 10000ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_micro_computer of tb_micro_computer is
    for tb
    end for;
end cfg_tb_micro_computer;