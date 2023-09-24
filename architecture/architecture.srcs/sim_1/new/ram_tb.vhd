library ieee;
use ieee.std_logic_1164.all;

entity tb_ram is
end tb_ram;

architecture tb of tb_ram is

    component ram
        port (dir       : in std_logic_vector (31 downto 0);
              data      : in std_logic_vector (31 downto 0);
              mem_read  : in std_logic;
              mem_write : in std_logic;
              mem_data  : out std_logic_vector (31 downto 0);
              clk       : in std_logic;
              reset     : in std_logic);
    end component;

    signal dir       : std_logic_vector (31 downto 0);
    signal data      : std_logic_vector (31 downto 0);
    signal mem_read  : std_logic;
    signal mem_write : std_logic;
    signal mem_data  : std_logic_vector (31 downto 0);
    signal clk       : std_logic;
    signal reset     : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ram
    port map (dir       => dir,
              data      => data,
              mem_read  => mem_read,
              mem_write => mem_write,
              mem_data  => mem_data,
              clk       => clk,
              reset     => reset);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        dir <= (others => '0');
        data <= (others => '0');
        mem_read <= '0';
        mem_write <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        dir <= "00000000000000000000000000000000";
        data <= "00000000000000000000000000000101";
        mem_read <= '1';
        mem_write <= '1';
        
        wait for 100 ns;
        
        dir <= "00000000000000000000000000000001";
        data <= "00000000000000000000000000000001";
        mem_read <= '1';
        mem_write <= '1';
        
        wait for 100 ns;
        
        dir <= "00000000000000000000000000000001";
        data <= "00000000000000000000000000000000";
        mem_read <= '1';
        mem_write <= '0';
        
        wait for 100 ns;
        
        dir <= "00000000000000000000000000000000";
        data <= "00000000000000000000000000000000";
        mem_read <= '1';
        mem_write <= '0';
        
        wait for 100 ns;
        
        dir <= "00000000000000000000000000000000";
        data <= "00000000000000000000000000000000";
        mem_read <= '0';
        mem_write <= '0';
        
        wait for 100 ns;
        
        dir <= "00000000000000000000000000000001";
        data <= "00000000000000000000000000000000";
        mem_read <= '0';
        mem_write <= '0';
        
        wait for 100 ns;
        
        dir <= "00000000000000000000000000001010";
        data <= "00000000000000000000000000000000";
        mem_read <= '1';
        mem_write <= '0';
        
        wait for 1000 ns;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ram of tb_ram is
    for tb
    end for;
end cfg_tb_ram;