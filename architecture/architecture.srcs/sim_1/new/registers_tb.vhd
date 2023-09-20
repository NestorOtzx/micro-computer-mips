library ieee;
use ieee.std_logic_1164.all;

entity tb_registers is
end tb_registers;

architecture tb of tb_registers is

    component registers
        port (rs             : in std_logic_vector (4 downto 0);
              rt             : in std_logic_vector (4 downto 0);
              write_register : in std_logic_vector (4 downto 0);
              write_data     : in std_logic_vector (31 downto 0);
              reg_write      : in std_logic;
              clk            : in std_logic;
              reset          : in std_logic;
              read_data1     : out std_logic_vector (31 downto 0);
              read_data2     : out std_logic_vector (31 downto 0));
    end component;

    signal rs             : std_logic_vector (4 downto 0);
    signal rt             : std_logic_vector (4 downto 0);
    signal write_register : std_logic_vector (4 downto 0);
    signal write_data     : std_logic_vector (31 downto 0);
    signal reg_write      : std_logic;
    signal clk            : std_logic;
    signal reset          : std_logic;
    signal read_data1     : std_logic_vector (31 downto 0);
    signal read_data2     : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : registers
    port map (rs             => rs,
              rt             => rt,
              write_register => write_register,
              write_data     => write_data,
              reg_write      => reg_write,
              clk            => clk,
              reset          => reset,
              read_data1     => read_data1,
              read_data2     => read_data2);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        rs <= (others => '0');
        rt <= (others => '0');
        write_register <= (others => '0');
        write_data <= (others => '0');
        reg_write <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 10 ns;

        
        rs <= "00001";
        rt <= "00010";
        write_register <= "00000";
        write_data <= "00000000000000000000000000001010";
        reg_write <= '1';
        wait for 100 ns;
        
        rs <= "00000";
        rt <= "00000";
        write_register <= "00010";
        write_data <= "00000000000000000000000000001010";
        reg_write <= '1';
        wait for 100 ns;
        
        rs <= "00001";
        rt <= "00010";
        write_register <= "00001";
        write_data <= "00000000000000000000000000001010";
        reg_write <= '1';
        wait for 100 ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_registers of tb_registers is
    for tb
    end for;
end cfg_tb_registers;