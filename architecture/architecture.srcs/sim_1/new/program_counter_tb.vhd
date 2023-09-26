library ieee;
use ieee.std_logic_1164.all;

entity tb_program_counter is
end tb_program_counter;

architecture tb of tb_program_counter is

    component program_counter
        port (pc_in    : in std_logic_vector (31 downto 0);
              pc_write : in std_logic;
              clk      : in std_logic;
              reset    : in std_logic;
              pc_out   : out std_logic_vector (31 downto 0));
    end component;

    signal pc_in    : std_logic_vector (31 downto 0);
    signal pc_write : std_logic;
    signal clk      : std_logic;
    signal reset    : std_logic;
    signal pc_out   : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : program_counter
    port map (pc_in    => pc_in,
              pc_write => pc_write,
              clk      => clk,
              reset    => reset,
              pc_out   => pc_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        pc_in <= (others => '0');
        pc_write <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        pc_in <= (others => '0');
        pc_write <= '0';
        
        wait for 100 ns;
        
        pc_in <= "00000000000000000000000000001001";
        pc_write <= '1';
        
        wait for 1000 ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_program_counter of tb_program_counter is
    for tb
    end for;
end cfg_tb_program_counter;