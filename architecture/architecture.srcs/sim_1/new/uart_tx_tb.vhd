-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 8.11.2023 00:00:48 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_uart_tx is
end tb_uart_tx;

architecture tb of tb_uart_tx is

    component uart_tx
        port (clk       : in std_logic;
              rstn      : in std_logic;
              send_word : in std_logic;
              word      : in std_logic_vector (7 downto 0);
              busy_tx   : out std_logic;
              tx        : out std_logic);
    end component;

    signal clk       : std_logic;
    signal rstn      : std_logic;
    signal send_word : std_logic;
    signal word      : std_logic_vector (7 downto 0);
    signal busy_tx   : std_logic;
    signal tx        : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : uart_tx
    port map (clk       => clk,
              rstn      => rstn,
              send_word => send_word,
              word      => word,
              busy_tx   => busy_tx,
              tx        => tx);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        send_word <= '0';
        word <= (others => '0');

        -- Reset generation
        -- EDIT: Check that rstn is really your reset signal
        rstn <= '0';
        wait for 100 ns;
        rstn <= '1';
        wait for 100 ns;
        
        send_word <= '1';
        word <= "10111011";
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_uart_tx of tb_uart_tx is
    for tb
    end for;
end cfg_tb_uart_tx;