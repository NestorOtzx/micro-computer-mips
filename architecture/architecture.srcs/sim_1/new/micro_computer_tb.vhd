-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 4.11.2023 19:28:32 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_micro_computer is
end tb_micro_computer;

architecture tb of tb_micro_computer is

    component micro_computer
        port (clk     : in std_logic;
              reset   : in std_logic;
              input   : in std_logic_vector (19 downto 0);
              leds    : out std_logic_vector (15 downto 0);
              debug   : out std_logic_vector (31 downto 0);
              enDigit : out std_logic_vector (3 downto 0);
              display : out std_logic_vector (6 downto 0);
              rx: in std_logic;
              tx: out std_logic
              );
              
    end component;

    signal clk     : std_logic;
    signal reset   : std_logic;
    signal input   : std_logic_vector (19 downto 0);
    signal leds    : std_logic_vector (15 downto 0);
    signal debug   : std_logic_vector (31 downto 0);
    signal enDigit : std_logic_vector (3 downto 0);
    signal display : std_logic_vector (6 downto 0);
    signal rx: std_logic;
    signal tx: std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : micro_computer
    port map (clk     => clk,
              reset   => reset,
              input   => input,
              leds    => leds,
              debug   => debug,
              enDigit => enDigit,
              display => display,
              rx => rx,
              tx => tx
              );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        input <= (others => '0');
        rx <= '1';
        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        input <= "00000000000000000001";
        wait for 100 ns;
        reset <= '0';
        
        wait for 100 us;
        rx <= '0';
        -- EDIT Add stimuli here
        wait for 100 us;
        
        rx <= '1';
        
        wait for 20 us;
        
 --------------------------------------
        -- INGRESAR EL N
        input <= "00000000000000000010";
        wait for 200 us;
        input <= "10000000000000000010";
        wait for 100 us;
        input <= "00000000000000000010";
        wait for 200 us;
       
        
        -- INGRESAR EL A[1]
         input <= "00000000000000000111";
        wait for 200 us;
        input <= "10000000000000000111";
        wait for 100 us;
        input <= "00000000000000000111";
        wait for 200 us;
        
        -- INGRESAR EL A[2]
        input <= "00000000000000001010";
        wait for 200 us;
        input <= "10000000000000001010";
        wait for 100 us;
        input <= "00000000000000001010";
        wait for 200 us;

--------------------------------------
        -- INGRESAR EL B[1]
         input <= "00000000000000001000";
        wait for 200 us;
        input <= "10000000000000001000";
        wait for 100 us;
        input <= "00000000000000001000";
        wait for 200 us;
        
        -- INGRESAR EL B[2]
        input <= "00000000000000001011";
        wait for 200 us;
        input <= "10000000000000001011";
        wait for 100 us;
        input <= "00000000000000001011";
        wait for 200 us;
        
        -- INGRESAR EL B[3]
        input <= "00000000000000000001";
        wait for 200 us;
        input <= "10000000000000000001";
        wait for 100 us;
        input <= "00000000000000000001";
        wait for 200 us;
        
--------------------------------------
        -- INGRESAR EL X[1]
        input <= "00000000000000101111";
        wait for 200 us;
        input <= "10000000000000101111";
        wait for 100 us;
        input <= "00000000000000101111";
        wait for 200 us;
        
        -- INGRESAR EL X[2]
        input <= "00000000000000011111";
        wait for 200 us;
        input <= "10000000000000011111";
        wait for 100 us;
        input <= "00000000000000011111";
        wait for 200 us;
        
        -- INGRESAR EL X[3]
        input <= "00000000000001011111";
        wait for 200 us;
        input <= "10000000000001011111";
        wait for 100 us;
        input <= "00000000000001011111";
        wait for 200 us;
        
        -- Salir
        input <= "00000000000000000000";
        wait for 200 us;
        input <= "10000000000000000000";
        wait for 100 us;
        input <= "00000000000000000000";
        wait for 200 us;
        
        input <= "00000000000000000000";
        wait for 10000 us;
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