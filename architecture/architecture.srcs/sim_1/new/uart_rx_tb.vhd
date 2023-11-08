
library ieee;
use ieee.std_logic_1164.all;

entity tb_uart_rx is
end tb_uart_rx;

architecture tb of tb_uart_rx is

    component uart_rx
        port (clk       : in std_logic;
              rstn      : in std_logic;
              recv_word : out std_logic;
              word      : out std_logic_vector (7 downto 0);
              parity_rx : out std_logic;
              busy_rx   : out std_logic;
              rx        : in std_logic);
    end component;

    signal clk       : std_logic;
    signal rstn      : std_logic;
    signal recv_word : std_logic;
    signal word      : std_logic_vector (7 downto 0);
    signal parity_rx : std_logic;
    signal busy_rx   : std_logic;
    signal rx        : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : uart_rx
    port map (clk       => clk,
              rstn      => rstn,
              recv_word => recv_word,
              word      => word,
              parity_rx => parity_rx,
              busy_rx   => busy_rx,
              rx        => rx);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        rx <= '1';

        -- Reset generation
        -- EDIT: Check that rstn is really your reset signal
        rstn <= '1';
        wait for 100 ns;
        rstn <= '0';
        wait for 100 ns;
        
        rx <= '0';
        
        wait for 868 ns;

        rx <= '1';
        
        wait for 868 ns;

        
        rx <= '0';
        
        wait for 868 ns;

        rx <= '1';
        
        wait for 868 ns;



        rx <= '0';
        
        wait for 868 ns;

        rx <= '1';
        
        wait for 868 ns;



        rx <= '0';
        
        wait for 868 ns;

        rx <= '1';
        
        wait for 868 ns;



        rx <= '0';
        
        wait for 868 ns;

        rx <= '1';
        
        wait for 868 ns;


        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_uart_rx of tb_uart_rx is
    for tb
    end for;
end cfg_tb_uart_rx;