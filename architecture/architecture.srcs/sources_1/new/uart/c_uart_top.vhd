library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity c_uart_top is
  Port (
        clock: in STD_LOGIC;
        reset: in STD_LOGIC;
        send_word : in std_logic;
        word      : in std_logic_vector(7 downto 0);
        rx        : in std_logic;
        busy_tx   : out std_logic;
        tx        : out std_logic;
        word_out  : out std_logic_vector(7 downto 0);
        busy_rx   : out std_logic
  );
end c_uart_top;

architecture Behavioral of c_uart_top is

signal UART_CLK: STD_LOGIC := '0';

component c_uart_tx
    port (
    clock       : in std_logic;
    reset      : in std_logic;
    send_word : in std_logic;
    word      : in std_logic_vector(7 downto 0);
    busy_tx   : out std_logic;
    tx        : out std_logic
  );
end component; 

component c_uart_rx
    port (
        clock     : in std_logic;
        reset     : in std_logic;
        rx        : in std_logic;
        word      : out std_logic_vector(7 downto 0);
        busy_rx   : out std_logic
    );
end component;

component uart_clockgen
    port(
        clock: in STD_LOGIC;
        reset: in STD_LOGIC;
        output: out STD_LOGIC
    );
end component;    


begin

U_CLOCK: uart_clockgen
    port map(
        clock => clock,
        reset => reset,
        output => UART_CLK
        );

U_TX: c_uart_tx
port map(
    clock    => UART_CLK,
    reset    => reset,
    send_word=> send_word,
    word     => word,
    busy_tx  => busy_tx,
    tx       => tx
);

U_RX: c_uart_rx
port map(
    clock    => UART_CLK,
    reset    => reset,
    rx       => rx,
    word     => word_out,
    busy_rx  => busy_rx
);
    

end Behavioral;
